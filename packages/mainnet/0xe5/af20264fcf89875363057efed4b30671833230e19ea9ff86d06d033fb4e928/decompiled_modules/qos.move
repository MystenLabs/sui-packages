module 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::qos {
    struct QoSStats has store, key {
        id: 0x2::object::UID,
        deal_id: 0x2::object::ID,
        provider_id: 0x2::object::ID,
        consumer: address,
        uptime_percentage: u64,
        avg_upload_speed_mbps: u64,
        avg_download_speed_mbps: u64,
        total_downtime_minutes: u64,
        files_uploaded: u64,
        files_downloaded: u64,
        total_bytes_stored: u64,
        last_updated_by_provider: u64,
        last_updated_by_consumer: u64,
        provider_update_count: u64,
        consumer_update_count: u64,
        created_at: u64,
        updated_at: u64,
    }

    struct QoSUpdated has copy, drop {
        qos_id: 0x2::object::ID,
        updated_by: address,
        uptime_percentage: u64,
        timestamp: u64,
    }

    public fun consumer_update_qos(arg0: &mut QoSStats, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        arg0.files_uploaded = arg1;
        arg0.total_bytes_stored = arg2;
        arg0.last_updated_by_consumer = v0;
        arg0.consumer_update_count = arg0.consumer_update_count + 1;
        arg0.updated_at = v0;
    }

    public(friend) fun create_qos_stats(arg0: 0x2::object::ID, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v1 = QoSStats{
            id                       : 0x2::object::new(arg2),
            deal_id                  : 0x2::object::id_from_address(@0x0),
            provider_id              : arg0,
            consumer                 : arg1,
            uptime_percentage        : 10000,
            avg_upload_speed_mbps    : 0,
            avg_download_speed_mbps  : 0,
            total_downtime_minutes   : 0,
            files_uploaded           : 0,
            files_downloaded         : 0,
            total_bytes_stored       : 0,
            last_updated_by_provider : 0,
            last_updated_by_consumer : 0,
            provider_update_count    : 0,
            consumer_update_count    : 0,
            created_at               : v0,
            updated_at               : v0,
        };
        0x2::transfer::share_object<QoSStats>(v1);
        0x2::object::uid_to_inner(&v1.id)
    }

    public fun get_metrics(arg0: &QoSStats) : (u64, u64, u64, u64) {
        (arg0.uptime_percentage, arg0.avg_upload_speed_mbps, arg0.avg_download_speed_mbps, arg0.files_uploaded)
    }

    public fun get_uptime(arg0: &QoSStats) : u64 {
        arg0.uptime_percentage
    }

    public fun provider_update_qos(arg0: &mut QoSStats, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        arg0.uptime_percentage = arg1;
        arg0.avg_upload_speed_mbps = arg2;
        arg0.avg_download_speed_mbps = arg3;
        arg0.last_updated_by_provider = v0;
        arg0.provider_update_count = arg0.provider_update_count + 1;
        arg0.updated_at = v0;
        let v1 = QoSUpdated{
            qos_id            : 0x2::object::uid_to_inner(&arg0.id),
            updated_by        : 0x2::tx_context::sender(arg4),
            uptime_percentage : arg1,
            timestamp         : v0,
        };
        0x2::event::emit<QoSUpdated>(v1);
    }

    // decompiled from Move bytecode v6
}

