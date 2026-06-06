module 0x214302d985fac734bd93a8ae74abeb51e010ad42e52864dc87f9af43ac3d5c9d::stream {
    struct Stream has store, key {
        id: 0x2::object::UID,
        creator: address,
        vessel_id: 0x2::object::ID,
        price_per_session: u64,
        duration_ms: u64,
        payment_type: u8,
        state: u8,
        created_at: u64,
        total_earned: u64,
        session_count: u64,
    }

    struct StreamSession has store, key {
        id: 0x2::object::UID,
        stream_id: 0x2::object::ID,
        viewer: address,
        paid: u64,
        expires_at: u64,
        joined_at: u64,
    }

    struct StreamCreated has copy, drop {
        stream_id: address,
        creator: address,
        vessel_id: address,
        price_per_session: u64,
        duration_ms: u64,
        payment_type: u8,
        created_at: u64,
    }

    struct SessionJoined has copy, drop {
        stream_id: address,
        session_id: address,
        viewer: address,
        paid: u64,
        expires_at: u64,
        joined_at: u64,
    }

    struct StreamEnded has copy, drop {
        stream_id: address,
        creator: address,
        vessel_id: address,
        total_earned: u64,
        session_count: u64,
        ended_at: u64,
        vod_chest_id: 0x1::option::Option<0x2::object::ID>,
    }

    public fun create(arg0: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &mut 0x214302d985fac734bd93a8ae74abeb51e010ad42e52864dc87f9af43ac3d5c9d::abyss::Abyss, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u8, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 <= 2, 5);
        assert!(arg3 >= 10000, 3);
        0x214302d985fac734bd93a8ae74abeb51e010ad42e52864dc87f9af43ac3d5c9d::abyss::receive_stream_create(arg1, arg0, arg6, arg7);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = Stream{
            id                : 0x2::object::new(arg7),
            creator           : v0,
            vessel_id         : arg2,
            price_per_session : arg3,
            duration_ms       : arg4,
            payment_type      : arg5,
            state             : 0,
            created_at        : v1,
            total_earned      : 0,
            session_count     : 0,
        };
        let v3 = 0x2::object::id<Stream>(&v2);
        let v4 = StreamCreated{
            stream_id         : 0x2::object::id_to_address(&v3),
            creator           : v0,
            vessel_id         : 0x2::object::id_to_address(&arg2),
            price_per_session : arg3,
            duration_ms       : arg4,
            payment_type      : arg5,
            created_at        : v1,
        };
        0x2::event::emit<StreamCreated>(v4);
        0x2::transfer::share_object<Stream>(v2);
    }

    public fun creator(arg0: &Stream) : address {
        arg0.creator
    }

    public fun duration_ms(arg0: &Stream) : u64 {
        arg0.duration_ms
    }

    public fun end(arg0: &mut Stream, arg1: 0x1::option::Option<0x2::object::ID>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 1);
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 2);
        arg0.state = 1;
        let v0 = 0x2::object::id<Stream>(arg0);
        let v1 = StreamEnded{
            stream_id     : 0x2::object::id_to_address(&v0),
            creator       : arg0.creator,
            vessel_id     : 0x2::object::id_to_address(&arg0.vessel_id),
            total_earned  : arg0.total_earned,
            session_count : arg0.session_count,
            ended_at      : 0x2::clock::timestamp_ms(arg2),
            vod_chest_id  : arg1,
        };
        0x2::event::emit<StreamEnded>(v1);
    }

    public fun fee_stream_create() : u64 {
        50000
    }

    public fun is_live(arg0: &Stream) : bool {
        arg0.state == 0
    }

    public fun join(arg0: &mut Stream, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &mut 0x214302d985fac734bd93a8ae74abeb51e010ad42e52864dc87f9af43ac3d5c9d::abyss::Abyss, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 1);
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1);
        assert!(v0 >= arg0.price_per_session, 4);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = v2 + arg0.duration_ms;
        0x214302d985fac734bd93a8ae74abeb51e010ad42e52864dc87f9af43ac3d5c9d::abyss::receive_stream_access(arg2, 0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1, v0 * 300 / 10000, arg4), arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1, arg0.creator);
        arg0.total_earned = arg0.total_earned + v0;
        arg0.session_count = arg0.session_count + 1;
        let v4 = StreamSession{
            id         : 0x2::object::new(arg4),
            stream_id  : 0x2::object::id<Stream>(arg0),
            viewer     : v1,
            paid       : v0,
            expires_at : v3,
            joined_at  : v2,
        };
        let v5 = 0x2::object::id<Stream>(arg0);
        let v6 = 0x2::object::id<StreamSession>(&v4);
        let v7 = SessionJoined{
            stream_id  : 0x2::object::id_to_address(&v5),
            session_id : 0x2::object::id_to_address(&v6),
            viewer     : v1,
            paid       : v0,
            expires_at : v3,
            joined_at  : v2,
        };
        0x2::event::emit<SessionJoined>(v7);
        0x2::transfer::transfer<StreamSession>(v4, v1);
    }

    public fun min_session_price() : u64 {
        10000
    }

    public fun payment_per_minute() : u8 {
        1
    }

    public fun payment_per_view() : u8 {
        0
    }

    public fun payment_subscription() : u8 {
        2
    }

    public fun payment_type(arg0: &Stream) : u8 {
        arg0.payment_type
    }

    public fun price_per_session(arg0: &Stream) : u64 {
        arg0.price_per_session
    }

    public fun session_count(arg0: &Stream) : u64 {
        arg0.session_count
    }

    public fun session_expires_at(arg0: &StreamSession) : u64 {
        arg0.expires_at
    }

    public fun session_paid(arg0: &StreamSession) : u64 {
        arg0.paid
    }

    public fun session_stream_id(arg0: &StreamSession) : 0x2::object::ID {
        arg0.stream_id
    }

    public fun session_viewer(arg0: &StreamSession) : address {
        arg0.viewer
    }

    public fun state(arg0: &Stream) : u8 {
        arg0.state
    }

    public fun total_earned(arg0: &Stream) : u64 {
        arg0.total_earned
    }

    public fun verify(arg0: &StreamSession, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) < arg0.expires_at
    }

    public fun vessel_id(arg0: &Stream) : 0x2::object::ID {
        arg0.vessel_id
    }

    // decompiled from Move bytecode v7
}

