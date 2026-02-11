module 0x39e56fc1b75b59bfa8e9043a26d77e158633a0aa2e8297d526721152ea03b1f1::live {
    struct LiveStream has key {
        id: 0x2::object::UID,
        creator: address,
        title: vector<u8>,
        stream_key: vector<u8>,
        playback_url: vector<u8>,
        status: u8,
        started_ms: u64,
        ended_ms: u64,
        archive_blob_id: vector<u8>,
        ban_reason: vector<u8>,
    }

    struct StreamStarted has copy, drop {
        stream_id: 0x2::object::ID,
        creator: address,
        title: vector<u8>,
    }

    struct StreamEnded has copy, drop {
        stream_id: 0x2::object::ID,
        creator: address,
    }

    struct StreamBanned has copy, drop {
        stream_id: 0x2::object::ID,
        creator: address,
        reason: vector<u8>,
    }

    entry fun admin_ban_stream(arg0: &0x39e56fc1b75b59bfa8e9043a26d77e158633a0aa2e8297d526721152ea03b1f1::platform::AdminCap, arg1: &0x39e56fc1b75b59bfa8e9043a26d77e158633a0aa2e8297d526721152ea03b1f1::platform::PlatformConfig, arg2: &mut LiveStream, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        arg2.status = 2;
        arg2.ban_reason = arg3;
        let v0 = StreamBanned{
            stream_id : 0x2::object::uid_to_inner(&arg2.id),
            creator   : arg2.creator,
            reason    : arg3,
        };
        0x2::event::emit<StreamBanned>(v0);
    }

    entry fun end_live(arg0: &mut LiveStream, arg1: u64, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg3), 1);
        assert!(arg0.status == 0, 3);
        arg0.status = 1;
        arg0.ended_ms = arg1;
        arg0.archive_blob_id = arg2;
        let v0 = StreamEnded{
            stream_id : 0x2::object::uid_to_inner(&arg0.id),
            creator   : arg0.creator,
        };
        0x2::event::emit<StreamEnded>(v0);
    }

    public fun is_banned(arg0: &LiveStream) : bool {
        arg0.status == 2
    }

    public fun is_live(arg0: &LiveStream) : bool {
        arg0.status == 0
    }

    entry fun start_live(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = LiveStream{
            id              : 0x2::object::new(arg4),
            creator         : 0x2::tx_context::sender(arg4),
            title           : arg0,
            stream_key      : arg1,
            playback_url    : arg2,
            status          : 0,
            started_ms      : arg3,
            ended_ms        : 0,
            archive_blob_id : b"",
            ban_reason      : b"",
        };
        0x2::transfer::share_object<LiveStream>(v0);
        let v1 = StreamStarted{
            stream_id : 0x2::object::uid_to_inner(&v0.id),
            creator   : v0.creator,
            title     : v0.title,
        };
        0x2::event::emit<StreamStarted>(v1);
    }

    // decompiled from Move bytecode v6
}

