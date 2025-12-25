module 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::quest_v2 {
    struct QuestVault has key {
        id: 0x2::object::UID,
        balances: 0x2::bag::Bag,
        fund_receiver: address,
        tokens_stat: vector<TokenStat>,
    }

    struct TokenStat has copy, drop, store {
        token_type: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
        last_updated: u64,
    }

    struct VaultCreatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct SetFundReceiverEvent has copy, drop {
        new_receiver: address,
    }

    struct VaultDepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        total_balance: u64,
    }

    struct VaultWithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        total_balance: u64,
    }

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
        point: u128,
        min_time: u64,
        max_time: u64,
        msg_expire_time: u64,
    }

    public fun register(arg0: &mut 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::Logs, arg1: &mut 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::Config, arg2: &mut 0x2::tx_context::TxContext) : 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::UserArchive {
        0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::register(arg0, arg1, arg2)
    }

    public fun set_checkin_fee<T0>(arg0: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::AdminCap, arg1: &mut 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::Config, arg2: u64) {
        0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::set_checkin_fee(arg0, arg1, arg2);
        0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::set_fee_type<T0>(arg0, arg1, 0x1::string::utf8(b"QUEST_MODULE"));
        let v0 = SetCheckinFeeEvent{
            fee  : arg2,
            type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<SetCheckinFeeEvent>(v0);
    }

    public fun set_max_check_in_days(arg0: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::AdminCap, arg1: &mut 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::Config, arg2: u64) {
        0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::set_max_check_in_days(arg0, arg1, arg2);
    }

    public fun checkin<T0>(arg0: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::Config, arg1: &mut QuestVault, arg2: &mut 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::UserArchive, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::verify_config(arg0, 0x1::string::utf8(b"QUEST_MODULE"));
        0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::validate_archive_owner(arg2, arg5);
        0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::init_checkin(arg2);
        assert!(0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::get_fee_type(arg0, 0x1::string::utf8(b"QUEST_MODULE")) == 0x1::type_name::get<T0>(), 8005);
        assert!(0x2::coin::value<T0>(&arg3) >= 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::get_checkin_fee(arg0), 8004);
        let (v0, v1) = 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::set_checkin(arg0, arg2, arg4);
        deposit_to_vault<T0>(arg1, 0x2::coin::into_balance<T0>(arg3), arg4);
        let v2 = EventCheckin{
            user              : 0x2::tx_context::sender(arg5),
            day               : v0,
            last_checkin_time : v1,
        };
        0x2::event::emit<EventCheckin>(v2);
    }

    public fun claim_bonus_point<T0>(arg0: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::Config, arg1: &mut QuestVault, arg2: &mut 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::UserArchive, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::verify_config(arg0, 0x1::string::utf8(b"QUEST_MODULE"));
        let v0 = 0x2::tx_context::sender(arg7);
        0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::validate_archive_owner(arg2, arg7);
        0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::verify_signature_v2(arg0, arg3, arg4);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = 0x2::bcs::new(arg4);
        let v3 = 0x2::bcs::peel_u64(&mut v2);
        let v4 = 0x2::bcs::peel_u64(&mut v2);
        let v5 = 0x2::bcs::peel_vec_u8(&mut v2);
        let v6 = 0x2::bcs::peel_u64(&mut v2);
        assert!(v0 == 0x2::bcs::peel_address(&mut v2), 8002);
        assert!(0x2::coin::value<T0>(&arg5) == 0x2::bcs::peel_u64(&mut v2), 8004);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())) == 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)), 8006);
        0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::update_task_time_range(arg2, b"QUEST_CLAIM_BONUS_POINT_TIME_RANGE", v5, v3, v4);
        assert!(v1 < v6, 8003);
        deposit_to_vault<T0>(arg1, 0x2::coin::into_balance<T0>(arg5), arg6);
        0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::set_archive_last_name_time(arg2, v1);
        let v7 = ClaimBonusEvent{
            user            : v0,
            task_id         : 0x1::string::utf8(v5),
            sub_task_id     : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)),
            point           : 0x2::bcs::peel_u128(&mut v2),
            min_time        : v3,
            max_time        : v4,
            msg_expire_time : v6,
        };
        0x2::event::emit<ClaimBonusEvent>(v7);
    }

    public fun deposit_fund_to_vault<T0>(arg0: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::TreasureCap, arg1: &mut QuestVault, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) {
        deposit_to_vault<T0>(arg1, arg2, arg3);
    }

    fun deposit_to_vault<T0>(arg0: &mut QuestVault, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<QuestVault>(arg0);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x2::balance::value<T0>(&arg1);
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v1)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1, 0x2::balance::zero<T0>());
        };
        let v3 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1);
        0x2::balance::join<T0>(v3, arg1);
        update_vault_token_stat(arg0, v1, v2, 0, arg2);
        let v4 = VaultDepositEvent{
            vault_id      : v0,
            token_type    : v1,
            amount        : v2,
            total_balance : 0x2::balance::value<T0>(v3),
        };
        0x2::event::emit<VaultDepositEvent>(v4);
    }

    public fun init_vault(arg0: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = QuestVault{
            id            : 0x2::object::new(arg1),
            balances      : 0x2::bag::new(arg1),
            fund_receiver : 0x2::tx_context::sender(arg1),
            tokens_stat   : 0x1::vector::empty<TokenStat>(),
        };
        let v1 = VaultCreatedEvent{vault_id: 0x2::object::id<QuestVault>(&v0)};
        0x2::event::emit<VaultCreatedEvent>(v1);
        0x2::transfer::share_object<QuestVault>(v0);
    }

    public fun paused(arg0: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::AdminCap, arg1: &mut 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::Config, arg2: bool) {
        0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::paused_v2(arg0, arg1, 0x1::string::utf8(b"QUEST_MODULE"), arg2);
    }

    public fun set_fund_receiver(arg0: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::AdminCap, arg1: &mut QuestVault, arg2: address) {
        arg1.fund_receiver = arg2;
        let v0 = SetFundReceiverEvent{new_receiver: arg2};
        0x2::event::emit<SetFundReceiverEvent>(v0);
    }

    fun update_vault_token_stat(arg0: &mut QuestVault, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = &mut arg0.tokens_stat;
        let v1 = 0;
        while (v1 < 0x1::vector::length<TokenStat>(v0)) {
            let v2 = 0x1::vector::borrow_mut<TokenStat>(v0, v1);
            if (v2.token_type == arg1) {
                v2.amount_in = v2.amount_in + arg2;
                v2.amount_out = v2.amount_out + arg3;
                v2.last_updated = 0x2::clock::timestamp_ms(arg4);
                return
            };
            v1 = v1 + 1;
        };
        let v3 = TokenStat{
            token_type   : arg1,
            amount_in    : arg2,
            amount_out   : arg3,
            last_updated : 0x2::clock::timestamp_ms(arg4),
        };
        0x1::vector::push_back<TokenStat>(v0, v3);
    }

    public fun withdraw_amount_from_vault<T0>(arg0: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::TreasureCap, arg1: &mut QuestVault, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_from_vault<T0>(arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg1.fund_receiver);
    }

    fun withdraw_from_vault<T0>(arg0: &mut QuestVault, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::object::id<QuestVault>(arg0);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v1), 8007);
        let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1);
        assert!(0x2::balance::value<T0>(v2) >= arg1, 8008);
        update_vault_token_stat(arg0, v1, 0, arg1, arg2);
        let v3 = VaultWithdrawEvent{
            vault_id      : v0,
            token_type    : v1,
            amount        : arg1,
            total_balance : 0x2::balance::value<T0>(v2),
        };
        0x2::event::emit<VaultWithdrawEvent>(v3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v2, arg1), arg3)
    }

    // decompiled from Move bytecode v6
}

