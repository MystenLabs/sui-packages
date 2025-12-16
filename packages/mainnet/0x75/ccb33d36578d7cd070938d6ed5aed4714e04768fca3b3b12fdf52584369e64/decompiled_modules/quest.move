module 0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::quest {
    struct SetCheckinFeeEvent has copy, drop, store {
        fee: u64,
        type: 0x1::type_name::TypeName,
    }

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

    public fun migrate(arg0: &0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::AdminCap, arg1: &mut 0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::Config, arg2: u64) {
        0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::migrate(arg0, arg1, arg2);
    }

    public fun register(arg0: &mut 0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::Logs, arg1: &mut 0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::Config, arg2: &mut 0x2::tx_context::TxContext) : 0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::UserArchive {
        0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::register(arg0, arg1, arg2)
    }

    public fun set_checkin_fee<T0>(arg0: &0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::AdminCap, arg1: &mut 0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::Config, arg2: u64) {
        0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::set_checkin_fee(arg0, arg1, arg2);
        0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::set_fee_type<T0>(arg0, arg1, 0x1::string::utf8(b"QUEST_MODULE"));
        let v0 = SetCheckinFeeEvent{
            fee  : arg2,
            type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<SetCheckinFeeEvent>(v0);
    }

    public fun set_max_check_in_days(arg0: &0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::AdminCap, arg1: &mut 0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::Config, arg2: u64) {
        0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::set_max_check_in_days(arg0, arg1, arg2);
    }

    public fun checkin(arg0: &0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::Config, arg1: &mut 0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::UserArchive, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        abort 8001
    }

    public fun checkin_v2<T0>(arg0: &0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::Config, arg1: &mut 0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::GlobalVault, arg2: &mut 0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::UserArchive, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::verify_config(arg0, 0x1::string::utf8(b"QUEST_MODULE"));
        0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::validate_archive_owner(arg2, arg5);
        0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::init_checkin(arg2);
        assert!(0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::get_fee_type(arg0, 0x1::string::utf8(b"QUEST_MODULE")) == 0x1::type_name::get<T0>(), 8005);
        assert!(0x2::coin::value<T0>(&arg3) >= 0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::get_checkin_fee(arg0), 8004);
        let (v0, v1) = 0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::set_checkin(arg0, arg2, arg4);
        0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::deposit_to_vault<T0>(arg1, 0x2::coin::into_balance<T0>(arg3), arg4);
        let v2 = EventCheckin{
            user              : 0x2::tx_context::sender(arg5),
            day               : v0,
            last_checkin_time : v1,
        };
        0x2::event::emit<EventCheckin>(v2);
    }

    public fun claim_bonus_point<T0>(arg0: &0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::Config, arg1: &mut 0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::GlobalVault, arg2: &mut 0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::UserArchive, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::verify_config(arg0, 0x1::string::utf8(b"QUEST_MODULE"));
        let v0 = 0x2::tx_context::sender(arg7);
        0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::validate_archive_owner(arg2, arg7);
        0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::verify_signature_v2(arg0, arg3, arg4);
        let v1 = 0x2::bcs::new(arg4);
        assert!(v0 == 0x2::bcs::peel_address(&mut v1), 8002);
        assert!(0x2::coin::value<T0>(&arg5) >= 0x2::bcs::peel_u64(&mut v1), 8004);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())) == 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)), 8006);
        assert!(0x2::clock::timestamp_ms(arg6) < 0x2::bcs::peel_u64(&mut v1), 8003);
        0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::deposit_to_vault<T0>(arg1, 0x2::coin::into_balance<T0>(arg5), arg6);
        let v2 = ClaimBonusEvent{
            user        : v0,
            task_id     : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)),
            sub_task_id : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)),
            nonce       : 0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::update_user_nonce(arg2, 0x2::bcs::peel_u8(&mut v1), 0x2::bcs::peel_u128(&mut v1)),
        };
        0x2::event::emit<ClaimBonusEvent>(v2);
    }

    public fun paused(arg0: &0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::AdminCap, arg1: &mut 0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::Config, arg2: bool) {
        0xb61e68cc3e565fc23f3b9e5f4b1c19451eb173dae2f6f4391efce1c924a3e9a6::guild::paused_v2(arg0, arg1, 0x1::string::utf8(b"QUEST_MODULE"), arg2);
    }

    // decompiled from Move bytecode v6
}

