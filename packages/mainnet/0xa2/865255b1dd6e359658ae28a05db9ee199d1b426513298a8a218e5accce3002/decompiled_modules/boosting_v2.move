module 0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::boosting_v2 {
    struct BoostingVault has key {
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

    struct PreSubscribe has key {
        id: 0x2::object::UID,
        paused: bool,
        start_time: u64,
        duration: u64,
        price_per_class: 0x2::table::Table<u8, u64>,
        fee_type: 0x1::type_name::TypeName,
        subscribers: 0x2::vec_set::VecSet<address>,
        subscribers_type: 0x2::table::Table<u8, 0x2::vec_set::VecSet<address>>,
        no_slots: 0x2::table::Table<u8, u16>,
        wl_manager: 0x2::vec_set::VecSet<address>,
        whitelisted: 0x2::table::Table<u8, 0x2::vec_set::VecSet<address>>,
        refund_amounts: 0x2::table::Table<address, u64>,
        refund_available: bool,
        total_deposit: u64,
        total_refund: u64,
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

    struct InitPreSubscribeEvent has copy, drop {
        pre_subscribe: 0x2::object::ID,
    }

    struct PausePreSubscribeEvent has copy, drop {
        pre_subscribe: 0x2::object::ID,
        paused: bool,
    }

    struct SetartTimePreSubscribeEvent has copy, drop {
        pre_subscribe: 0x2::object::ID,
        start_time: u64,
    }

    struct SetDurationPreSubscribeEvent has copy, drop {
        pre_subscribe: 0x2::object::ID,
        duration: u64,
    }

    struct SetPricePerClassPreSubscribeEvent has copy, drop {
        pre_subscribe: 0x2::object::ID,
        class: u8,
        price: u64,
    }

    struct SetFeeTypePreSubscribeEvent has copy, drop {
        pre_subscribe: 0x2::object::ID,
        fee_type: 0x1::type_name::TypeName,
    }

    struct SetSlotsPreSubscribeEvent has copy, drop {
        pre_subscribe: 0x2::object::ID,
        type: u8,
        slots: u16,
    }

    struct AddWLManagerEvent has copy, drop {
        pre_subscribe: 0x2::object::ID,
        manager: vector<address>,
    }

    struct RemoveWLManagerEvent has copy, drop {
        pre_subscribe: 0x2::object::ID,
        manager: vector<address>,
    }

    struct AddWhitelistEvent has copy, drop {
        pre_subscribe: 0x2::object::ID,
        type: u8,
        users: vector<address>,
    }

    struct RemoveWhitelistEvent has copy, drop {
        pre_subscribe: 0x2::object::ID,
        type: u8,
        users: vector<address>,
    }

    struct SetRefundAvailableEvent has copy, drop {
        pre_subscribe: 0x2::object::ID,
        available: bool,
    }

    struct DepositPreSubscribeEvent has copy, drop {
        pre_subscribe: 0x2::object::ID,
        subscriber: address,
        type: u8,
        amount: u64,
    }

    struct RefundPreSubscribeEvent has copy, drop {
        pre_subscribe: 0x2::object::ID,
        subscriber: address,
        premium_refundable: bool,
        premium_plus_refundable: bool,
        amount: u64,
    }

    struct PreSubscribeEvent has copy, drop {
        subscriber: address,
        type: u8,
        amount: u64,
    }

    struct BuyingStarEvent has copy, drop {
        buyer: address,
        number_of_stars: u64,
        fee: u64,
        nonce: u128,
    }

    struct SwappingStarEvent has copy, drop {
        swapper: address,
        number_of_stars: u64,
        received_fee: u64,
        nonce: u128,
    }

    struct SubscriptionEvent has copy, drop {
        subscriber: address,
        duration: u16,
        fee: u64,
        class: u8,
        nonce: u128,
    }

    struct CommissionClaimEvent has copy, drop {
        claimer: address,
        amount: u64,
        min_time: u64,
        max_time: u64,
        nonce: u128,
    }

    struct CommissionClaimEventV2 has copy, drop {
        claimer: address,
        type: u8,
        amount: u64,
        min_time: u64,
        max_time: u64,
        nonce: u128,
    }

    struct ClaimBonusEvent has copy, drop {
        claimer: address,
        amount: u64,
        min_time: u64,
        max_time: u64,
        nonce: u128,
    }

    public fun add_whitelist_manager_pre_subscribe(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::AdminCap, arg1: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg2: &mut PreSubscribe, arg3: vector<address>) {
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::verify_config(arg1, 0x1::string::utf8(b"BOOSTING_MODULE"));
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            let v1 = *0x1::vector::borrow<address>(&arg3, v0);
            if (!0x2::vec_set::contains<address>(&arg2.wl_manager, &v1)) {
                0x2::vec_set::insert<address>(&mut arg2.wl_manager, v1);
            };
            v0 = v0 + 1;
        };
        let v2 = AddWLManagerEvent{
            pre_subscribe : 0x2::object::id<PreSubscribe>(arg2),
            manager       : arg3,
        };
        0x2::event::emit<AddWLManagerEvent>(v2);
    }

    public fun add_whitelist_pre_subscribe(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg1: &mut PreSubscribe, arg2: u8, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::verify_config(arg0, 0x1::string::utf8(b"BOOSTING_MODULE"));
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg1.wl_manager, &v0), 7003);
        let v1 = 0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg1.whitelisted, arg2);
        let v2 = 0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg1.subscribers_type, arg2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg3)) {
            let v4 = *0x1::vector::borrow<address>(&arg3, v3);
            if (!0x2::vec_set::contains<address>(v1, &v4)) {
                0x2::vec_set::insert<address>(v1, v4);
            };
            if (!0x2::vec_set::contains<address>(&arg1.subscribers, &v4)) {
                0x2::vec_set::insert<address>(&mut arg1.subscribers, v4);
            };
            if (!0x2::vec_set::contains<address>(v2, &v4)) {
                0x2::vec_set::insert<address>(v2, v4);
            };
            v3 = v3 + 1;
        };
        let v5 = AddWhitelistEvent{
            pre_subscribe : 0x2::object::id<PreSubscribe>(arg1),
            type          : arg2,
            users         : arg3,
        };
        0x2::event::emit<AddWhitelistEvent>(v5);
    }

    public fun buying_stars<T0>(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg1: &mut BoostingVault, arg2: &mut 0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::UserArchive, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x2::balance::Balance<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::verify_config(arg0, 0x1::string::utf8(b"BOOSTING_MODULE"));
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::verify_signature_v2(arg0, arg4, arg5);
        let v0 = 0x2::tx_context::sender(arg8);
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::validate_archive_owner(arg2, arg8);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        let v2 = 0x2::bcs::new(arg5);
        let v3 = 0x2::bcs::peel_u64(&mut v2);
        assert!(v0 == 0x2::bcs::peel_address(&mut v2), 7000);
        assert!(arg3 > 0 && arg3 == 0x2::bcs::peel_u64(&mut v2), 7001);
        assert!(v3 > 0 && 0x2::balance::value<T0>(&arg6) == v3, 7002);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())) == 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)), 7005);
        assert!(v1 < 0x2::bcs::peel_u64(&mut v2), 7004);
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::set_archive_last_name_time(arg2, v1);
        deposit_to_vault<T0>(arg1, arg6, arg7);
        let v4 = BuyingStarEvent{
            buyer           : v0,
            number_of_stars : arg3,
            fee             : v3,
            nonce           : 0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::update_user_nonce(arg2, 0x2::bcs::peel_u8(&mut v2), 0x2::bcs::peel_u128(&mut v2)),
        };
        0x2::event::emit<BuyingStarEvent>(v4);
    }

    public fun change_fee_type_pre_subscribe<T0>(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::AdminCap, arg1: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg2: &mut PreSubscribe) {
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::verify_config(arg1, 0x1::string::utf8(b"BOOSTING_MODULE"));
        arg2.fee_type = 0x1::type_name::get<T0>();
        let v0 = SetFeeTypePreSubscribeEvent{
            pre_subscribe : 0x2::object::id<PreSubscribe>(arg2),
            fee_type      : arg2.fee_type,
        };
        0x2::event::emit<SetFeeTypePreSubscribeEvent>(v0);
    }

    public fun claim_bonus<T0>(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg1: &mut BoostingVault, arg2: &mut 0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::UserArchive, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        abort 7013
    }

    public fun claim_commission<T0>(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg1: &mut BoostingVault, arg2: &mut 0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::UserArchive, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::verify_config(arg0, 0x1::string::utf8(b"BOOSTING_MODULE"));
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::verify_signature_v2(arg0, arg6, arg7);
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::validate_archive_owner(arg2, arg9);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        assert!(v1 >= arg5 && arg5 >= arg4, 7001);
        let v2 = 0x2::bcs::new(arg7);
        let v3 = 0x2::bcs::peel_u8(&mut v2);
        let v4 = 0x2::bcs::peel_address(&mut v2);
        assert!(v0 == v4, 7000);
        assert!(arg3 > 0 && 0x2::bcs::peel_u64(&mut v2) == arg3, 7002);
        assert!(0x2::bcs::peel_u64(&mut v2) == arg4 && 0x2::bcs::peel_u64(&mut v2) == arg5, 7001);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())) == 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)), 7005);
        assert!(v1 < 0x2::bcs::peel_u64(&mut v2), 7004);
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::update_claim_commission_time_range(arg2, b"BOOSTING_CLAIM_COMMISTION_TIME_RANGE", v3, arg4, arg5);
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::set_archive_last_name_time(arg2, v1);
        let v5 = CommissionClaimEventV2{
            claimer  : v0,
            type     : v3,
            amount   : arg3,
            min_time : arg4,
            max_time : arg5,
            nonce    : 0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::update_user_nonce(arg2, v3, 0x2::bcs::peel_u128(&mut v2)),
        };
        0x2::event::emit<CommissionClaimEventV2>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdraw_from_vault<T0>(arg1, arg3, arg8, arg9), v4);
    }

    public fun deposit_fund_to_vault<T0>(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::TreasureCap, arg1: &mut BoostingVault, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) {
        deposit_to_vault<T0>(arg1, arg2, arg3);
    }

    public fun deposit_fund_to_vault_from_swap<T0>(arg0: &mut BoostingVault, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"BOOSTING_WHITELIST_DEPOSIT"), 7003);
        assert!(0x2::vec_set::contains<address>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::vec_set::VecSet<address>>(&mut arg0.id, b"BOOSTING_WHITELIST_DEPOSIT"), &v0), 7003);
        deposit_to_vault<T0>(arg0, 0x2::coin::into_balance<T0>(arg1), arg2);
    }

    public fun deposit_pre_subscribe<T0>(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg1: &mut PreSubscribe, arg2: &mut BoostingVault, arg3: u8, arg4: 0x2::balance::Balance<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::verify_config(arg0, 0x1::string::utf8(b"BOOSTING_MODULE"));
        assert!(!arg1.paused, 7006);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 >= arg1.start_time && v0 <= arg1.start_time + arg1.duration, 7008);
        assert!(arg3 == 0 || arg3 == 1, 7001);
        assert!(0x2::table::contains<u8, u64>(&arg1.price_per_class, arg3), 7001);
        let v1 = *0x2::table::borrow<u8, u64>(&arg1.price_per_class, arg3);
        let v2 = 0x2::balance::value<T0>(&arg4);
        let v3 = 0x2::tx_context::sender(arg6);
        if (0x2::vec_set::contains<address>(&arg1.subscribers, &v3)) {
            assert!(arg3 == 1, 7009);
            let v4 = 0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg1.subscribers_type, 0);
            if (!0x2::vec_set::contains<address>(v4, &v3)) {
                abort 7009
            };
            0x2::vec_set::remove<address>(v4, &v3);
            assert!(0x2::table::contains<u8, u64>(&arg1.price_per_class, 0), 7001);
            let v5 = *0x2::table::borrow<u8, u64>(&arg1.price_per_class, 0);
            assert!(v2 == v1 - v5, 7002);
            let v6 = 0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg1.subscribers_type, 1);
            assert!(!0x2::vec_set::contains<address>(v6, &v3), 7009);
            0x2::vec_set::insert<address>(v6, v3);
            let v7 = 0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg1.whitelisted, 0);
            if (0x2::vec_set::contains<address>(v7, &v3)) {
                0x2::vec_set::remove<address>(v7, &v3);
            };
            if (!0x2::table::contains<address, u64>(&arg1.refund_amounts, v3)) {
                0x2::table::add<address, u64>(&mut arg1.refund_amounts, v3, v1 - v5);
            } else {
                *0x2::table::borrow_mut<address, u64>(&mut arg1.refund_amounts, v3) = v1;
            };
        } else {
            assert!(v2 == v1, 7002);
            0x2::vec_set::insert<address>(&mut arg1.subscribers, v3);
            0x2::vec_set::insert<address>(0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg1.subscribers_type, arg3), v3);
            if (!0x2::table::contains<address, u64>(&arg1.refund_amounts, v3)) {
                0x2::table::add<address, u64>(&mut arg1.refund_amounts, v3, v1);
            };
        };
        assert!(arg1.fee_type == 0x1::type_name::get<T0>(), 7005);
        arg1.total_deposit = arg1.total_deposit + v2;
        deposit_to_vault<T0>(arg2, arg4, arg5);
        let v8 = DepositPreSubscribeEvent{
            pre_subscribe : 0x2::object::id<PreSubscribe>(arg1),
            subscriber    : v3,
            type          : arg3,
            amount        : v2,
        };
        0x2::event::emit<DepositPreSubscribeEvent>(v8);
    }

    fun deposit_to_vault<T0>(arg0: &mut BoostingVault, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<BoostingVault>(arg0);
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

    public fun init_pre_subscribe<T0>(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::AdminCap, arg1: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg2: &mut 0x2::tx_context::TxContext) {
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::verify_config(arg1, 0x1::string::utf8(b"BOOSTING_MODULE"));
        let v0 = 0x2::table::new<u8, 0x2::vec_set::VecSet<address>>(arg2);
        0x2::table::add<u8, 0x2::vec_set::VecSet<address>>(&mut v0, 0, 0x2::vec_set::empty<address>());
        0x2::table::add<u8, 0x2::vec_set::VecSet<address>>(&mut v0, 1, 0x2::vec_set::empty<address>());
        let v1 = 0x2::table::new<u8, 0x2::vec_set::VecSet<address>>(arg2);
        0x2::table::add<u8, 0x2::vec_set::VecSet<address>>(&mut v1, 0, 0x2::vec_set::empty<address>());
        0x2::table::add<u8, 0x2::vec_set::VecSet<address>>(&mut v1, 1, 0x2::vec_set::empty<address>());
        let v2 = PreSubscribe{
            id               : 0x2::object::new(arg2),
            paused           : true,
            start_time       : 0,
            duration         : 259200000,
            price_per_class  : 0x2::table::new<u8, u64>(arg2),
            fee_type         : 0x1::type_name::get<T0>(),
            subscribers      : 0x2::vec_set::empty<address>(),
            subscribers_type : v0,
            no_slots         : 0x2::table::new<u8, u16>(arg2),
            wl_manager       : 0x2::vec_set::empty<address>(),
            whitelisted      : v1,
            refund_amounts   : 0x2::table::new<address, u64>(arg2),
            refund_available : false,
            total_deposit    : 0,
            total_refund     : 0,
        };
        let v3 = InitPreSubscribeEvent{pre_subscribe: 0x2::object::id<PreSubscribe>(&v2)};
        0x2::event::emit<InitPreSubscribeEvent>(v3);
        0x2::transfer::share_object<PreSubscribe>(v2);
    }

    public fun init_vault(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BoostingVault{
            id            : 0x2::object::new(arg1),
            balances      : 0x2::bag::new(arg1),
            fund_receiver : 0x2::tx_context::sender(arg1),
            tokens_stat   : 0x1::vector::empty<TokenStat>(),
        };
        let v1 = VaultCreatedEvent{vault_id: 0x2::object::id<BoostingVault>(&v0)};
        0x2::event::emit<VaultCreatedEvent>(v1);
        0x2::transfer::share_object<BoostingVault>(v0);
    }

    public fun pause_pre_subscribe(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::AdminCap, arg1: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg2: &mut PreSubscribe, arg3: bool) {
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::verify_config(arg1, 0x1::string::utf8(b"BOOSTING_MODULE"));
        assert!(arg2.paused != arg3, 7001);
        arg2.paused = arg3;
        let v0 = PausePreSubscribeEvent{
            pre_subscribe : 0x2::object::id<PreSubscribe>(arg2),
            paused        : arg3,
        };
        0x2::event::emit<PausePreSubscribeEvent>(v0);
    }

    public fun paused(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::AdminCap, arg1: &mut 0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg2: bool) {
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::paused_v2(arg0, arg1, 0x1::string::utf8(b"BOOSTING_MODULE"), arg2);
    }

    public fun pre_subscribe<T0>(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg1: &mut PreSubscribe, arg2: &mut BoostingVault, arg3: u8, arg4: 0x2::balance::Balance<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::verify_config(arg0, 0x1::string::utf8(b"BOOSTING_MODULE"));
        assert!(!arg1.paused, 7006);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 >= arg1.start_time && v0 <= arg1.start_time + arg1.duration, 7008);
        assert!(arg3 == 0 || arg3 == 1, 7001);
        let v1 = 0x2::tx_context::sender(arg6);
        assert!(0x2::table::contains<u8, u16>(&arg1.no_slots, arg3) && 0x2::table::contains<u8, u64>(&arg1.price_per_class, arg3), 7001);
        let v2 = 0x2::table::borrow_mut<u8, u16>(&mut arg1.no_slots, arg3);
        let v3 = *0x2::table::borrow<u8, u64>(&arg1.price_per_class, arg3);
        let v4 = 0x2::balance::value<T0>(&arg4);
        if (0x2::vec_set::contains<address>(&arg1.subscribers, &v1)) {
            assert!(arg3 == 1, 7009);
            let v5 = 0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg1.subscribers_type, 0);
            if (!0x2::vec_set::contains<address>(v5, &v1)) {
                abort 7009
            };
            0x2::vec_set::remove<address>(v5, &v1);
            assert!(0x2::table::contains<u8, u64>(&arg1.price_per_class, 0), 7001);
            let v6 = *0x2::table::borrow<u8, u64>(&arg1.price_per_class, 0);
            assert!(v4 == v3 - v6, 7002);
            let v7 = 0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg1.subscribers_type, 1);
            assert!(!0x2::vec_set::contains<address>(v7, &v1), 7009);
            0x2::vec_set::insert<address>(v7, v1);
            let v8 = 0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg1.whitelisted, 0);
            if (0x2::vec_set::contains<address>(v8, &v1)) {
                0x2::vec_set::remove<address>(v8, &v1);
            };
            if (!0x2::table::contains<address, u64>(&arg1.refund_amounts, v1)) {
                0x2::table::add<address, u64>(&mut arg1.refund_amounts, v1, v3 - v6);
            } else {
                *0x2::table::borrow_mut<address, u64>(&mut arg1.refund_amounts, v1) = v6;
            };
        } else {
            assert!(v4 == v3, 7002);
            0x2::vec_set::insert<address>(&mut arg1.subscribers, v1);
            0x2::vec_set::insert<address>(0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg1.subscribers_type, arg3), v1);
            if (!0x2::table::contains<address, u64>(&arg1.refund_amounts, v1)) {
                0x2::table::add<address, u64>(&mut arg1.refund_amounts, v1, v3);
            };
        };
        assert!(*v2 > 0, 7007);
        *v2 = *v2 - 1;
        assert!(arg1.fee_type == 0x1::type_name::get<T0>(), 7005);
        deposit_to_vault<T0>(arg2, arg4, arg5);
        let v9 = PreSubscribeEvent{
            subscriber : 0x2::tx_context::sender(arg6),
            type       : arg3,
            amount     : v4,
        };
        0x2::event::emit<PreSubscribeEvent>(v9);
    }

    public fun refund_pre_subscribe<T0>(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg1: &mut PreSubscribe, arg2: &mut BoostingVault, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::verify_config(arg0, 0x1::string::utf8(b"BOOSTING_MODULE"));
        assert!(!arg1.paused, 7006);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = validate_claim_refund_pre_subscribe(arg1, v0, 0, arg3);
        let v2 = validate_claim_refund_pre_subscribe(arg1, v0, 1, arg3);
        assert!(v1 || v2, 7012);
        let v3 = if (0x2::table::contains<address, u64>(&arg1.refund_amounts, v0)) {
            0x2::table::remove<address, u64>(&mut arg1.refund_amounts, v0)
        } else {
            0
        };
        assert!(v3 > 0, 7012);
        arg1.total_refund = arg1.total_refund + v3;
        0x2::vec_set::remove<address>(&mut arg1.subscribers, &v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdraw_from_vault<T0>(arg2, v3, arg3, arg4), v0);
        let v4 = RefundPreSubscribeEvent{
            pre_subscribe           : 0x2::object::id<PreSubscribe>(arg1),
            subscriber              : v0,
            premium_refundable      : v1,
            premium_plus_refundable : v2,
            amount                  : v3,
        };
        0x2::event::emit<RefundPreSubscribeEvent>(v4);
    }

    public fun register(arg0: &mut 0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Logs, arg1: &mut 0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg2: &mut 0x2::tx_context::TxContext) : 0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::UserArchive {
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::register(arg0, arg1, arg2)
    }

    public fun remove_whitelist_manager_pre_subscribe(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::AdminCap, arg1: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg2: &mut PreSubscribe, arg3: vector<address>) {
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::verify_config(arg1, 0x1::string::utf8(b"BOOSTING_MODULE"));
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            let v1 = *0x1::vector::borrow<address>(&arg3, v0);
            if (0x2::vec_set::contains<address>(&arg2.wl_manager, &v1)) {
                0x2::vec_set::remove<address>(&mut arg2.wl_manager, &v1);
            };
            v0 = v0 + 1;
        };
        let v2 = RemoveWLManagerEvent{
            pre_subscribe : 0x2::object::id<PreSubscribe>(arg2),
            manager       : arg3,
        };
        0x2::event::emit<RemoveWLManagerEvent>(v2);
    }

    public fun remove_whitelist_pre_subscribe(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg1: &mut PreSubscribe, arg2: u8, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::verify_config(arg0, 0x1::string::utf8(b"BOOSTING_MODULE"));
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg1.wl_manager, &v0), 7003);
        let v1 = 0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg1.whitelisted, arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg3)) {
            let v3 = *0x1::vector::borrow<address>(&arg3, v2);
            if (0x2::vec_set::contains<address>(v1, &v3)) {
                0x2::vec_set::remove<address>(v1, &v3);
            };
            v2 = v2 + 1;
        };
        let v4 = RemoveWhitelistEvent{
            pre_subscribe : 0x2::object::id<PreSubscribe>(arg1),
            type          : arg2,
            users         : arg3,
        };
        0x2::event::emit<RemoveWhitelistEvent>(v4);
    }

    public fun remove_whitelist_subscribers_pre_subscribe(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg1: &mut PreSubscribe, arg2: u8, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::verify_config(arg0, 0x1::string::utf8(b"BOOSTING_MODULE"));
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg1.wl_manager, &v0), 7003);
        let v1 = 0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg1.whitelisted, arg2);
        let v2 = 0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg1.subscribers_type, arg2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg3)) {
            let v4 = *0x1::vector::borrow<address>(&arg3, v3);
            if (0x2::vec_set::contains<address>(v1, &v4)) {
                0x2::vec_set::remove<address>(v1, &v4);
            };
            if (0x2::vec_set::contains<address>(&arg1.subscribers, &v4)) {
                0x2::vec_set::remove<address>(&mut arg1.subscribers, &v4);
            };
            if (0x2::vec_set::contains<address>(v2, &v4)) {
                0x2::vec_set::remove<address>(v2, &v4);
            };
            v3 = v3 + 1;
        };
        let v5 = RemoveWhitelistEvent{
            pre_subscribe : 0x2::object::id<PreSubscribe>(arg1),
            type          : arg2,
            users         : arg3,
        };
        0x2::event::emit<RemoveWhitelistEvent>(v5);
    }

    public fun set_duration_pre_subscribe(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::AdminCap, arg1: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg2: &mut PreSubscribe, arg3: u64) {
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::verify_config(arg1, 0x1::string::utf8(b"BOOSTING_MODULE"));
        assert!(arg3 >= 0, 7001);
        arg2.duration = arg3;
        let v0 = SetDurationPreSubscribeEvent{
            pre_subscribe : 0x2::object::id<PreSubscribe>(arg2),
            duration      : arg3,
        };
        0x2::event::emit<SetDurationPreSubscribeEvent>(v0);
    }

    public fun set_fund_receiver(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::AdminCap, arg1: &mut BoostingVault, arg2: address) {
        arg1.fund_receiver = arg2;
        let v0 = SetFundReceiverEvent{new_receiver: arg2};
        0x2::event::emit<SetFundReceiverEvent>(v0);
    }

    public fun set_no_slots_pre_subscribe(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::AdminCap, arg1: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg2: &mut PreSubscribe, arg3: u8, arg4: u16) {
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::verify_config(arg1, 0x1::string::utf8(b"BOOSTING_MODULE"));
        assert!(arg4 > 0, 7001);
        if (0x2::table::contains<u8, u16>(&arg2.no_slots, arg3)) {
            0x2::table::remove<u8, u16>(&mut arg2.no_slots, arg3);
            0x2::table::add<u8, u16>(&mut arg2.no_slots, arg3, arg4);
        } else {
            0x2::table::add<u8, u16>(&mut arg2.no_slots, arg3, arg4);
        };
        let v0 = SetSlotsPreSubscribeEvent{
            pre_subscribe : 0x2::object::id<PreSubscribe>(arg2),
            type          : arg3,
            slots         : arg4,
        };
        0x2::event::emit<SetSlotsPreSubscribeEvent>(v0);
    }

    public fun set_price_per_class_pre_subscribe(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::AdminCap, arg1: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg2: &mut PreSubscribe, arg3: u8, arg4: u64) {
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::verify_config(arg1, 0x1::string::utf8(b"BOOSTING_MODULE"));
        assert!(arg4 > 0, 7001);
        if (0x2::table::contains<u8, u64>(&arg2.price_per_class, arg3)) {
            0x2::table::remove<u8, u64>(&mut arg2.price_per_class, arg3);
            0x2::table::add<u8, u64>(&mut arg2.price_per_class, arg3, arg4);
        } else {
            0x2::table::add<u8, u64>(&mut arg2.price_per_class, arg3, arg4);
        };
        let v0 = SetPricePerClassPreSubscribeEvent{
            pre_subscribe : 0x2::object::id<PreSubscribe>(arg2),
            class         : arg3,
            price         : arg4,
        };
        0x2::event::emit<SetPricePerClassPreSubscribeEvent>(v0);
    }

    public fun set_refund_available_pre_subscribe(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::AdminCap, arg1: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg2: &mut PreSubscribe, arg3: bool) {
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::verify_config(arg1, 0x1::string::utf8(b"BOOSTING_MODULE"));
        arg2.refund_available = arg3;
        let v0 = SetRefundAvailableEvent{
            pre_subscribe : 0x2::object::id<PreSubscribe>(arg2),
            available     : arg3,
        };
        0x2::event::emit<SetRefundAvailableEvent>(v0);
    }

    public fun set_start_time_pre_subscribe(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::AdminCap, arg1: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg2: &mut PreSubscribe, arg3: u64, arg4: &0x2::clock::Clock) {
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::verify_config(arg1, 0x1::string::utf8(b"BOOSTING_MODULE"));
        assert!(arg3 >= 0x2::clock::timestamp_ms(arg4), 7001);
        arg2.start_time = arg3;
        let v0 = SetartTimePreSubscribeEvent{
            pre_subscribe : 0x2::object::id<PreSubscribe>(arg2),
            start_time    : arg3,
        };
        0x2::event::emit<SetartTimePreSubscribeEvent>(v0);
    }

    public fun set_whitelist_deposit(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::AdminCap, arg1: &mut BoostingVault, arg2: vector<address>) {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"BOOSTING_WHITELIST_DEPOSIT")) {
            0x2::dynamic_field::add<vector<u8>, 0x2::vec_set::VecSet<address>>(&mut arg1.id, b"BOOSTING_WHITELIST_DEPOSIT", 0x2::vec_set::empty<address>());
        } else {
            let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::vec_set::VecSet<address>>(&mut arg1.id, b"BOOSTING_WHITELIST_DEPOSIT");
            let v1 = 0;
            while (v1 < 0x1::vector::length<address>(&arg2)) {
                let v2 = *0x1::vector::borrow<address>(&arg2, v1);
                if (!0x2::vec_set::contains<address>(v0, &v2)) {
                    0x2::vec_set::insert<address>(v0, v2);
                };
                v1 = v1 + 1;
            };
        };
    }

    public fun subscribe<T0>(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg1: &mut BoostingVault, arg2: &mut 0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::UserArchive, arg3: u16, arg4: u8, arg5: vector<u8>, arg6: vector<u8>, arg7: 0x2::balance::Balance<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::verify_config(arg0, 0x1::string::utf8(b"BOOSTING_MODULE"));
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::verify_signature_v2(arg0, arg5, arg6);
        let v0 = 0x2::tx_context::sender(arg9);
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::validate_archive_owner(arg2, arg9);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        let v2 = 0x2::bcs::new(arg6);
        let v3 = 0x2::bcs::peel_u8(&mut v2);
        let v4 = 0x2::bcs::peel_u64(&mut v2);
        assert!(v0 == 0x2::bcs::peel_address(&mut v2), 7000);
        assert!(0x2::bcs::peel_u16(&mut v2) == arg3, 7001);
        assert!(v3 == arg4, 7001);
        assert!(v4 > 0 && 0x2::balance::value<T0>(&arg7) == v4, 7002);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())) == 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)), 7005);
        assert!(v1 < 0x2::bcs::peel_u64(&mut v2), 7004);
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::set_archive_last_name_time(arg2, v1);
        deposit_to_vault<T0>(arg1, arg7, arg8);
        let v5 = SubscriptionEvent{
            subscriber : v0,
            duration   : arg3,
            fee        : v4,
            class      : v3,
            nonce      : 0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::update_user_nonce(arg2, 0x2::bcs::peel_u8(&mut v2), 0x2::bcs::peel_u128(&mut v2)),
        };
        0x2::event::emit<SubscriptionEvent>(v5);
    }

    public fun swap_stars<T0>(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg1: &mut BoostingVault, arg2: &mut 0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::UserArchive, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::verify_config(arg0, 0x1::string::utf8(b"BOOSTING_MODULE"));
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::verify_signature_v2(arg0, arg5, arg6);
        let v0 = 0x2::tx_context::sender(arg8);
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::validate_archive_owner(arg2, arg8);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        let v2 = 0x2::bcs::new(arg6);
        let v3 = 0x2::bcs::peel_address(&mut v2);
        let v4 = 0x2::bcs::peel_u64(&mut v2);
        assert!(v0 == v3, 7000);
        assert!(arg3 > 0 && 0x2::bcs::peel_u64(&mut v2) == arg3, 7001);
        assert!(v4 > 0 && arg4 == v4, 7002);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())) == 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)), 7005);
        assert!(v1 < 0x2::bcs::peel_u64(&mut v2), 7004);
        0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::set_archive_last_name_time(arg2, v1);
        let v5 = SwappingStarEvent{
            swapper         : v0,
            number_of_stars : arg3,
            received_fee    : v4,
            nonce           : 0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::update_user_nonce(arg2, 0x2::bcs::peel_u8(&mut v2), 0x2::bcs::peel_u128(&mut v2)),
        };
        0x2::event::emit<SwappingStarEvent>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdraw_from_vault<T0>(arg1, v4, arg7, arg8), v3);
    }

    fun update_vault_token_stat(arg0: &mut BoostingVault, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
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

    fun validate_claim_refund_pre_subscribe(arg0: &PreSubscribe, arg1: address, arg2: u8, arg3: &0x2::clock::Clock) : bool {
        if (!arg0.refund_available) {
            return false
        };
        if (0x2::clock::timestamp_ms(arg3) <= arg0.start_time + arg0.duration) {
            return false
        };
        if (0x2::vec_set::contains<address>(&arg0.subscribers, &arg1)) {
            if (!0x2::table::contains<u8, 0x2::vec_set::VecSet<address>>(&arg0.whitelisted, arg2)) {
                return true
            };
            if (!0x2::vec_set::contains<address>(0x2::table::borrow<u8, 0x2::vec_set::VecSet<address>>(&arg0.whitelisted, arg2), &arg1)) {
                return true
            };
        };
        false
    }

    public fun withdraw_amount_from_vault<T0>(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::TreasureCap, arg1: &mut BoostingVault, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_from_vault<T0>(arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg1.fund_receiver);
    }

    fun withdraw_from_vault<T0>(arg0: &mut BoostingVault, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::object::id<BoostingVault>(arg0);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v1), 7010);
        let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1);
        assert!(0x2::balance::value<T0>(v2) >= arg1, 7011);
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

