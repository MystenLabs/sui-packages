module 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::quest {
    struct EventCheckin has copy, drop, store {
        user: address,
        day: u64,
        last_checkin_time: u64,
    }

    struct ClaimBonusEvent has copy, drop, store {
        user: address,
        task_id: 0x1::string::String,
        sub_task_id: 0x1::string::String,
        nonce: u128,
    }

    public fun migrate(arg0: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::AdminCap, arg1: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Config, arg2: u64) {
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::migrate(arg0, arg1, arg2);
    }

    public fun register(arg0: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Logs, arg1: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Config, arg2: &mut 0x2::tx_context::TxContext) : 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::UserArchive {
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::register(arg0, arg1, arg2)
    }

    public fun set_max_check_in_days(arg0: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::AdminCap, arg1: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Config, arg2: u64) {
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::set_max_check_in_days(arg0, arg1, arg2);
    }

    public fun checkin(arg0: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Config, arg1: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::UserArchive, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        abort 8001
    }

    public fun checkin_v2<T0>(arg0: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Config, arg1: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::GlobalVault, arg2: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::UserArchive, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::verify_config(arg0, 0x1::string::utf8(b"QUEST_MODULE"));
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::validate_archive_owner(arg2, arg5);
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::init_checkin(arg2);
        let (v0, v1) = 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::set_checkin_v2<T0>(arg0, arg1, arg2, arg3, arg4);
        let v2 = EventCheckin{
            user              : 0x2::tx_context::sender(arg5),
            day               : v0,
            last_checkin_time : v1,
        };
        0x2::event::emit<EventCheckin>(v2);
    }

    public fun claim_bonus(arg0: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Config, arg1: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::UserArchive, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::verify_config(arg0, 0x1::string::utf8(b"QUEST_MODULE"));
        let v0 = 0x2::tx_context::sender(arg7);
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::validate_archive_owner(arg1, arg7);
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::verify_signature_v2(arg0, arg4, arg5);
        let v1 = 0x2::bcs::new(arg5);
        assert!(v0 == 0x2::bcs::peel_address(&mut v1), 8002);
        assert!(0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)) == arg2, 8004);
        assert!(0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)) == arg3, 8005);
        assert!(0x2::clock::timestamp_ms(arg6) < 0x2::bcs::peel_u64(&mut v1), 8003);
        let v2 = ClaimBonusEvent{
            user        : v0,
            task_id     : arg2,
            sub_task_id : arg3,
            nonce       : 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::update_user_nonce(arg1, 0x2::bcs::peel_u8(&mut v1), 0x2::bcs::peel_u128(&mut v1)),
        };
        0x2::event::emit<ClaimBonusEvent>(v2);
    }

    public fun paused(arg0: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::AdminCap, arg1: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Config, arg2: bool) {
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::paused_v2(arg0, arg1, 0x1::string::utf8(b"QUEST_MODULE"), arg2);
    }

    // decompiled from Move bytecode v6
}

