require 'gs2/core/AbstractClient.rb'

module Gs2 module Watch
  
  # GS2-Watch クライアント
  #
  # @author Game Server Services, Inc.
  class Client < Gs2::Core::AbstractClient
  
    @@ENDPOINT = 'watch'
  
    # コンストラクタ
    # 
    # @param region [String] リージョン名
    # @param gs2_client_id [String] GSIクライアントID
    # @param gs2_client_secret [String] GSIクライアントシークレット
    def initialize(region, gs2_client_id, gs2_client_secret)
      super(region, gs2_client_id, gs2_client_secret)
    end
    
    # デバッグ用。通常利用する必要はありません。
    def self.ENDPOINT(v = nil)
      if v
        @@ENDPOINT = v
      else
        return @@ENDPOINT
      end
    end

    # アラームリストを取得
    # 
    # @param pageToken [String] ページトークン
    # @param limit [Integer] 取得件数
    # @return [Array]
    #   * items
    #     [Array]
    #       * alarmId => アラームID
    #       * ownerId => オーナーID
    #       * name => アラーム名
    #       * description => 説明文
    #       * service => 監視対象サービス
    #       * serviceId => 監視対象サービスID
    #       * operation => 監視対象オペレーション
    #       * expression => 演算子
    #       * threshold => 閾値
    #       * notificationId => 通知ID
    #       * createAt => 作成日時
    #       * updateAt => 更新日時
    #       * status => ステータス
    #       * lastStatusChangeAt => 最終ステータス更新日時
    #   * nextPageToken => 次ページトークン
    def describe_alarm(pageToken = nil, limit = nil)
      query = {}
      if pageToken; query['pageToken'] = pageToken; end
      if limit; query['limit'] = limit; end
      return get(
            'Gs2Watch', 
            'DescribeAlarm', 
            @@ENDPOINT, 
            '/alarm',
            query);
    end
    
    # アラームを作成<br>
    # <br>
    # GS2 内のスタティスティックスに対して監視を行うことができます。<br>
    # クオータの消費量に対して閾値を設定し、閾値を超えた際に通知を出すことができます。<br>
    # 
    # @param request [Array]
    #   * name => アラーム名
    #   * description => 説明文
    #   * service => 監視対象サービス
    #   * serviceId => 監視対象サービスID
    #   * operation => 監視対象オペレーション
    #   * expression => 演算子(>=, >, <, <=)
    #   * threshold => 閾値
    #   * notificationId => 通知ID
    # @return [Array]
    #   * item
    #     * alarmId => アラームID
    #     * ownerId => オーナーID
    #     * name => アラーム名
    #     * description => 説明文
    #     * service => 監視対象サービス
    #     * serviceId => 監視対象サービスID
    #     * operation => 監視対象オペレーション
    #     * expression => 演算子
    #     * threshold => 閾値
    #     * notificationId => 通知ID
    #     * createAt => 作成日時
    #     * updateAt => 更新日時
    #     * status => ステータス
    #     * lastStatusChangeAt => 最終ステータス更新日時
    def create_alarm(request)
      if not request; raise ArgumentError.new(); end
      body = {}
      if request.has_key?('name'); body['name'] = request['name']; end
      if request.has_key?('description'); body['description'] = request['description']; end
      if request.has_key?('service'); body['service'] = request['service']; end
      if request.has_key?('serviceId'); body['serviceId'] = request['serviceId']; end
      if request.has_key?('operation'); body['operation'] = request['operation']; end
      if request.has_key?('expression'); body['expression'] = request['expression']; end
      if request.has_key?('threshold'); body['threshold'] = request['threshold']; end
      if request.has_key?('notificationId'); body['notificationId'] = request['notificationId']; end
      query = {}
      return post(
            'Gs2Watch', 
            'CreateAlarm', 
            @@ENDPOINT, 
            '/alarm',
            body,
            query);
    end
  
    # アラームを取得
    # 
    # @param request [Array]
    #   * alarmName => アラーム名
    # @return [Array]
    #   * item
    #     * alarmId => アラームID
    #     * ownerId => オーナーID
    #     * name => アラーム名
    #     * description => 説明文
    #     * service => 監視対象サービス
    #     * serviceId => 監視対象サービスID
    #     * operation => 監視対象オペレーション
    #     * expression => 演算子
    #     * threshold => 閾値
    #     * notificationId => 通知ID
    #     * createAt => 作成日時
    #     * updateAt => 更新日時
    #     * status => ステータス
    #     * lastStatusChangeAt => 最終ステータス更新日時
    def get_alarm(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('alarmName'); raise ArgumentError.new(); end
      if not request['alarmName']; raise ArgumentError.new(); end
      query = {}
      return get(
          'Gs2Watch',
          'GetAlarm',
          @@ENDPOINT,
          '/alarm/' + request['alarmName'],
          query);
    end
  
    # アラームを更新
    # 
    # @param request [Array]
    #   * alarmName => アラーム名
    #   * description => 説明文
    #   * expression => 演算子(>=, >, <, <=)
    #   * threshold => 閾値
    #   * notificationId => 通知ID
    # @return [Array]
    #   * item
    #     * alarmId => アラームID
    #     * ownerId => オーナーID
    #     * name => アラーム名
    #     * description => 説明文
    #     * service => 監視対象サービス
    #     * serviceId => 監視対象サービスID
    #     * operation => 監視対象オペレーション
    #     * expression => 演算子
    #     * threshold => 閾値
    #     * notificationId => 通知ID
    #     * createAt => 作成日時
    #     * updateAt => 更新日時
    #     * status => ステータス
    #     * lastStatusChangeAt => 最終ステータス更新日時
    def update_alarm(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('alarmName'); raise ArgumentError.new(); end
      if not request['alarmName']; raise ArgumentError.new(); end
      body = {}
      if request.has_key?('description'); body['description'] = request['description']; end
      if request.has_key?('expression'); body['expression'] = request['expression']; end
      if request.has_key?('threshold'); body['threshold'] = request['threshold']; end
      if request.has_key?('notificationId'); body['notificationId'] = request['notificationId']; end
      query = {}
      return put(
          'Gs2Watch',
          'UpdateAlarm',
          @@ENDPOINT,
          '/alarm/' + request['alarmName'],
          body,
          query);
    end
    
    # アラームを削除
    # 
    # @param request [Array]
    #   * alarmName => アラーム名
    def delete_alarm(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('alarmName'); raise ArgumentError.new(); end
      if not request['alarmName']; raise ArgumentError.new(); end
      query = {}
      return delete(
            'Gs2Watch', 
            'DeleteAlarm', 
            @@ENDPOINT, 
            '/alarm/' + request['alarmName'],
            query);
    end
  
    # アラームイベントリストを取得<br>
    # <br>
    # 過去にアラームが発生した履歴などを確認できます。<br>
    #
    # @param request [Array]
    #   * alarmName => アラーム名
    # @param pageToken [String] ページトークン
    # @param limit [Integer] 取得件数
    # @return [Array]
    #   * items
    #     [Array]
    #       * eventId => アラームイベントID
    #       * alarmId => アラームID
    #       * type => イベントの種類
    #       * eventAt => イベント発生日時
    #   * nextPageToken => 次ページトークン
    def describe_alarm_event(request, pageToken = nil, limit = nil)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('alarmName'); raise ArgumentError.new(); end
      if not request['alarmName']; raise ArgumentError.new(); end
      query = {}
      if pageToken; query['pageToken'] = pageToken; end
      if limit; query['limit'] = limit; end
      return get(
          'Gs2Watch',
          'DescribeAlarmEvent',
          @@ENDPOINT,
          '/alarm/' + request['alarmName'] + '/event',
          query);
    end
  
    # サービス名リストを取得<br>
    # <br>
    # アラームを設定する際に指定できるサービスの一覧を取得できます。<br>
    #
    # @return [Array] サービス名リスト
    def describe_service()
      query = {}
      result = get(
          'Gs2Watch',
          'DescribeService',
          @@ENDPOINT,
          '/service',
          query);
      return result['items'];
    end
  
    # オペレーション名リストを取得<br>
    # <br>
    # アラームを設定する際に指定できるオペレーションの一覧を取得できます。<br>
    #
    # @param request [Array]
    #   * serviceName => サービス名
    # @return [Array] オペレーション名リスト
    def describe_operation(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('serviceName'); raise ArgumentError.new(); end
      if not request['serviceName']; raise ArgumentError.new(); end
      query = {}
      result = get(
          'Gs2Watch',
          'DescribeOperation',
          @@ENDPOINT,
          '/service/' + request['serviceName'] + '/operation',
          query);
      return result['items'];
    end
  
    # メトリクスを取得<br>
    # <br>
    # 過去のサービスの利用状況を取得します。<br>
    # 
    # @param request [Array]
    #   * serviceId => サービスID
    #   * operation => オペレーション名
    #   * begin => メトリクス取得開始日時(unixepoch)
    #   * end => メトリクス取得終了日時(unixepoch)
    #   * allowLongTerm => 7日以上の期間のデータを取得することを許可するか(OPTIONAL)
    #   * serviceId => サービスID
    # @return [Array]
    #   * items
    #     [Array]
    #       * timestamp => タイムスタンプ(YYYY-MM-DD HH:mm:SS)
    #       * value => 値
    def get_metric(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('serviceId'); raise ArgumentError.new(); end
      if not request['serviceId']; raise ArgumentError.new(); end
      if not request.has_key?('operation'); raise ArgumentError.new(); end
      if not request['operation']; raise ArgumentError.new(); end
      query = {}
      if request.has_key?('begin'); query['begin'] = request['begin']; end
      if request.has_key?('end'); query['end'] = request['end']; end
      if request.has_key?('allowLongTerm'); query['allowLongTerm'] = request['allowLongTerm']; end
      return get(
          'Gs2Watch',
          'GetMetric',
          @@ENDPOINT,
          '/metric/' + request['serviceId'] + '/' + request['operation'],
          query);
    end
  end
end end