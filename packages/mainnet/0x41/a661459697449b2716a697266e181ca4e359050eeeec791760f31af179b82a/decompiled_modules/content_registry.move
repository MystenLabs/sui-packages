module 0x41a661459697449b2716a697266e181ca4e359050eeeec791760f31af179b82a::content_registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ContentRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        total_content: u64,
        active_content: u64,
        total_streams: u64,
        featured_ids: vector<0x2::object::ID>,
    }

    struct ContentItem has key {
        id: 0x2::object::UID,
        uploader: address,
        title: 0x1::string::String,
        description: 0x1::string::String,
        genre: u8,
        duration_seconds: u64,
        walrus_blob_ids: 0x1::string::String,
        thumbnail_url: 0x1::string::String,
        status: u8,
        total_streams: u64,
        total_watch_time: u64,
        average_completion_rate: u64,
        rating_sum: u64,
        rating_count: u64,
        upload_timestamp: u64,
    }

    struct StreamSession has store, key {
        id: 0x2::object::UID,
        content_id: 0x2::object::ID,
        viewer: address,
        start_time: u64,
        watch_duration: u64,
        completion_percentage: u64,
        quality_level: u8,
    }

    struct ContentRegistered has copy, drop {
        content_id: 0x2::object::ID,
        title: 0x1::string::String,
        uploader: address,
        walrus_blob_ids: 0x1::string::String,
        timestamp: u64,
    }

    struct ContentStatusUpdated has copy, drop {
        content_id: 0x2::object::ID,
        old_status: u8,
        new_status: u8,
    }

    struct StreamTracked has copy, drop {
        session_id: 0x2::object::ID,
        content_id: 0x2::object::ID,
        viewer: address,
        watch_duration: u64,
        completion_percentage: u64,
    }

    struct ContentRated has copy, drop {
        content_id: 0x2::object::ID,
        rater: address,
        rating: u64,
        new_average: u64,
    }

    public entry fun add_to_featured(arg0: &AdminCap, arg1: &mut ContentRegistry, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.featured_ids, arg2);
    }

    public fun get_average_rating(arg0: &ContentItem) : u64 {
        if (arg0.rating_count == 0) {
            return 0
        };
        arg0.rating_sum / arg0.rating_count
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = ContentRegistry{
            id             : 0x2::object::new(arg0),
            admin          : 0x2::tx_context::sender(arg0),
            total_content  : 0,
            active_content : 0,
            total_streams  : 0,
            featured_ids   : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<ContentRegistry>(v1);
    }

    public fun is_active(arg0: &ContentItem) : bool {
        arg0.status == 1
    }

    public entry fun rate_content(arg0: &mut ContentItem, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 1 && arg1 <= 5, 200);
        assert!(arg0.status == 1, 201);
        arg0.rating_sum = arg0.rating_sum + arg1;
        arg0.rating_count = arg0.rating_count + 1;
        let v0 = ContentRated{
            content_id  : 0x2::object::uid_to_inner(&arg0.id),
            rater       : 0x2::tx_context::sender(arg2),
            rating      : arg1,
            new_average : arg0.rating_sum / arg0.rating_count,
        };
        0x2::event::emit<ContentRated>(v0);
    }

    public entry fun register_content(arg0: &mut ContentRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= 9, 204);
        let v0 = 0x2::object::new(arg7);
        let v1 = ContentItem{
            id                      : v0,
            uploader                : 0x2::tx_context::sender(arg7),
            title                   : arg1,
            description             : arg2,
            genre                   : arg3,
            duration_seconds        : arg4,
            walrus_blob_ids         : arg5,
            thumbnail_url           : arg6,
            status                  : 0,
            total_streams           : 0,
            total_watch_time        : 0,
            average_completion_rate : 0,
            rating_sum              : 0,
            rating_count            : 0,
            upload_timestamp        : 0x2::tx_context::epoch_timestamp_ms(arg7),
        };
        arg0.total_content = arg0.total_content + 1;
        let v2 = ContentRegistered{
            content_id      : 0x2::object::uid_to_inner(&v0),
            title           : v1.title,
            uploader        : 0x2::tx_context::sender(arg7),
            walrus_blob_ids : v1.walrus_blob_ids,
            timestamp       : v1.upload_timestamp,
        };
        0x2::event::emit<ContentRegistered>(v2);
        0x2::transfer::share_object<ContentItem>(v1);
    }

    public entry fun remove_from_featured(arg0: &AdminCap, arg1: &mut ContentRegistry, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg1.featured_ids, &arg2);
        if (v0) {
            0x1::vector::remove<0x2::object::ID>(&mut arg1.featured_ids, v1);
        };
    }

    public entry fun track_stream(arg0: &mut ContentRegistry, arg1: &mut ContentItem, arg2: u64, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 1, 201);
        let v0 = if (arg1.duration_seconds > 0) {
            arg2 * 100 / arg1.duration_seconds
        } else {
            0
        };
        let v1 = if (v0 > 100) {
            100
        } else {
            v0
        };
        arg1.total_streams = arg1.total_streams + 1;
        arg1.total_watch_time = arg1.total_watch_time + arg2;
        if (arg1.total_streams > 0) {
            arg1.average_completion_rate = (arg1.average_completion_rate * (arg1.total_streams - 1) + v1) / arg1.total_streams;
        };
        arg0.total_streams = arg0.total_streams + 1;
        let v2 = 0x2::object::new(arg4);
        let v3 = StreamSession{
            id                    : v2,
            content_id            : 0x2::object::uid_to_inner(&arg1.id),
            viewer                : 0x2::tx_context::sender(arg4),
            start_time            : 0x2::tx_context::epoch_timestamp_ms(arg4),
            watch_duration        : arg2,
            completion_percentage : v1,
            quality_level         : arg3,
        };
        let v4 = StreamTracked{
            session_id            : 0x2::object::uid_to_inner(&v2),
            content_id            : 0x2::object::uid_to_inner(&arg1.id),
            viewer                : 0x2::tx_context::sender(arg4),
            watch_duration        : arg2,
            completion_percentage : v1,
        };
        0x2::event::emit<StreamTracked>(v4);
        0x2::transfer::transfer<StreamSession>(v3, 0x2::tx_context::sender(arg4));
    }

    public entry fun update_content_status(arg0: &AdminCap, arg1: &mut ContentRegistry, arg2: &mut ContentItem, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= 3, 203);
        let v0 = arg2.status;
        arg2.status = arg3;
        if (v0 != 1 && arg3 == 1) {
            arg1.active_content = arg1.active_content + 1;
        } else if (v0 == 1 && arg3 != 1) {
            arg1.active_content = arg1.active_content - 1;
        };
        let v1 = ContentStatusUpdated{
            content_id : 0x2::object::uid_to_inner(&arg2.id),
            old_status : v0,
            new_status : arg3,
        };
        0x2::event::emit<ContentStatusUpdated>(v1);
    }

    // decompiled from Move bytecode v6
}

