module 0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::live {
    struct LiveStream has key {
        id: 0x2::object::UID,
        creator: address,
        title: vector<u8>,
        description: vector<u8>,
        thumbnail_blob_id: vector<u8>,
        stream_key: vector<u8>,
        playback_url: vector<u8>,
        status: u8,
        started_ms: u64,
        ended_ms: u64,
        archive_blob_id: vector<u8>,
        archive_blob_object_id: 0x2::object::ID,
        ban_reason: vector<u8>,
    }

    struct LiveStarted has copy, drop {
        stream_id: 0x2::object::ID,
        creator: address,
        title: vector<u8>,
        playback_url: vector<u8>,
    }

    struct LiveEnded has copy, drop {
        stream_id: 0x2::object::ID,
        creator: address,
        duration_ms: u64,
        archived: bool,
    }

    struct LiveBanned has copy, drop {
        stream_id: 0x2::object::ID,
        creator: address,
        reason: vector<u8>,
        banned_by_admin: bool,
    }

    entry fun admin_ban_stream(arg0: &0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::AdminCap, arg1: &0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::PlatformConfig, arg2: &mut LiveStream, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 1, 3);
        arg2.status = 3;
        arg2.ended_ms = 0x2::clock::timestamp_ms(arg4);
        arg2.ban_reason = arg3;
        let v0 = LiveBanned{
            stream_id       : 0x2::object::id<LiveStream>(arg2),
            creator         : arg2.creator,
            reason          : arg3,
            banned_by_admin : true,
        };
        0x2::event::emit<LiveBanned>(v0);
    }

    entry fun end_live(arg0: &mut LiveStream, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg4), 1);
        assert!(arg0.status == 1, 3);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg0.status = 2;
        arg0.ended_ms = v0;
        arg0.archive_blob_id = arg1;
        arg0.archive_blob_object_id = arg2;
        let v1 = LiveEnded{
            stream_id   : 0x2::object::id<LiveStream>(arg0),
            creator     : arg0.creator,
            duration_ms : v0 - arg0.started_ms,
            archived    : 0x1::vector::length<u8>(&arg1) > 0,
        };
        0x2::event::emit<LiveEnded>(v1);
    }

    public fun get_creator(arg0: &LiveStream) : address {
        arg0.creator
    }

    public fun get_playback_url(arg0: &LiveStream) : vector<u8> {
        arg0.playback_url
    }

    public fun is_banned(arg0: &LiveStream) : bool {
        arg0.status == 3
    }

    public fun is_live(arg0: &LiveStream) : bool {
        arg0.status == 1
    }

    entry fun start_live(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = LiveStream{
            id                     : 0x2::object::new(arg6),
            creator                : v0,
            title                  : arg0,
            description            : arg1,
            thumbnail_blob_id      : arg2,
            stream_key             : arg3,
            playback_url           : arg4,
            status                 : 1,
            started_ms             : 0x2::clock::timestamp_ms(arg5),
            ended_ms               : 0,
            archive_blob_id        : 0x1::vector::empty<u8>(),
            archive_blob_object_id : 0x2::object::id_from_address(@0x0),
            ban_reason             : 0x1::vector::empty<u8>(),
        };
        0x2::transfer::transfer<LiveStream>(v1, v0);
        let v2 = LiveStarted{
            stream_id    : 0x2::object::id<LiveStream>(&v1),
            creator      : v0,
            title        : v1.title,
            playback_url : v1.playback_url,
        };
        0x2::event::emit<LiveStarted>(v2);
    }

    // decompiled from Move bytecode v6
}

