module 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::boosting {
    struct PreSubscribe has key {
        id: 0x2::object::UID,
        paused: bool,
        start_time: u64,
        duration: u64,
        price_per_class: 0x2::table::Table<u8, u64>,
        subscribers: 0x2::table::Table<u8, 0x2::vec_set::VecSet<address>>,
        wl_manager: 0x2::vec_set::VecSet<address>,
        whitelisted: 0x2::table::Table<u8, 0x2::vec_set::VecSet<address>>,
        total_deposit: u64,
        total_refund: u64,
    }

    struct PreSubscribeDepositEvent has copy, drop {
        subscriber: address,
        class: u8,
        amount: u64,
    }

    struct PreSubscribeClaimEvent has copy, drop {
        subscriber: address,
        type: 0x1::string::String,
    }

    struct PreSubscribeClaimRefundEvent has copy, drop {
        subscriber: address,
        amount: u64,
    }

    struct PreSubscribeAddWlManagerEvent has copy, drop {
        users: vector<address>,
    }

    struct PreSubscribeRemoveWlManagerEvent has copy, drop {
        users: vector<address>,
    }

    struct PreSubscribeAddWhiteListEvent has copy, drop {
        users: vector<address>,
    }

    struct PreSubscribeRemoveWhiteListEvent has copy, drop {
        users: vector<address>,
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

    public fun add_whitelist_manager_pre_subscribe(arg0: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::AdminCap, arg1: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Config, arg2: &mut PreSubscribe, arg3: vector<address>) {
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::verify_config(arg1, 0x1::string::utf8(b"BOOSTING_MODULE"));
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            let v1 = 0x1::vector::borrow<address>(&arg3, v0);
            if (!0x2::vec_set::contains<address>(&arg2.wl_manager, v1)) {
                0x2::vec_set::insert<address>(&mut arg2.wl_manager, *v1);
            };
            v0 = v0 + 1;
        };
        let v2 = PreSubscribeAddWlManagerEvent{users: arg3};
        0x2::event::emit<PreSubscribeAddWlManagerEvent>(v2);
    }

    public fun add_whitelist_pre_subscribe(arg0: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Config, arg1: &mut PreSubscribe, arg2: u8, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::verify_config(arg0, 0x1::string::utf8(b"BOOSTING_MODULE"));
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg1.wl_manager, &v0), 7007);
        let v1 = 0;
        if (!0x2::table::contains<u8, 0x2::vec_set::VecSet<address>>(&arg1.whitelisted, arg2)) {
            0x2::table::add<u8, 0x2::vec_set::VecSet<address>>(&mut arg1.whitelisted, arg2, 0x2::vec_set::empty<address>());
        };
        let v2 = 0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg1.whitelisted, arg2);
        while (v1 < 0x1::vector::length<address>(&arg3)) {
            let v3 = 0x1::vector::borrow<address>(&arg3, v1);
            if (!0x2::vec_set::contains<address>(v2, v3)) {
                0x2::vec_set::insert<address>(v2, *v3);
            };
            v1 = v1 + 1;
        };
        let v4 = PreSubscribeAddWhiteListEvent{users: arg3};
        0x2::event::emit<PreSubscribeAddWhiteListEvent>(v4);
    }

    public fun buying_stars<T0>(arg0: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Config, arg1: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::GlobalVault, arg2: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::UserArchive, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x2::balance::Balance<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::verify_config(arg0, 0x1::string::utf8(b"BOOSTING_MODULE"));
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::verify_signature_v2(arg0, arg4, arg5);
        let v0 = 0x2::tx_context::sender(arg8);
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::validate_archive_owner(arg2, arg8);
        let v1 = 0x2::bcs::new(arg5);
        let v2 = 0x2::bcs::peel_u64(&mut v1);
        assert!(v0 == 0x2::bcs::peel_address(&mut v1), 7000);
        assert!(arg3 > 0 && arg3 == 0x2::bcs::peel_u64(&mut v1), 7001);
        assert!(v2 > 0 && 0x2::balance::value<T0>(&arg6) == v2, 7002);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())) == 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)), 7005);
        assert!(0x2::clock::timestamp_ms(arg7) < 0x2::bcs::peel_u64(&mut v1), 7004);
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::deposit_to_vault<T0>(arg1, arg6, arg7);
        let v3 = BuyingStarEvent{
            buyer           : v0,
            number_of_stars : arg3,
            fee             : v2,
            nonce           : 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::update_user_nonce(arg2, 0x2::bcs::peel_u8(&mut v1), 0x2::bcs::peel_u128(&mut v1)),
        };
        0x2::event::emit<BuyingStarEvent>(v3);
    }

    fun check_can_claim_refund_pre_subscribe(arg0: &PreSubscribe, arg1: address, arg2: u8, arg3: &0x2::clock::Clock) : bool {
        if (arg0.paused) {
            return false
        };
        if (arg0.start_time == 0 || 0x2::clock::timestamp_ms(arg3) < arg0.start_time) {
            return false
        };
        let v0 = 0x2::table::borrow<u8, 0x2::vec_set::VecSet<address>>(&arg0.whitelisted, arg2);
        if (0x2::vec_set::contains<address>(0x2::table::borrow<u8, 0x2::vec_set::VecSet<address>>(&arg0.subscribers, arg2), &arg1) && !0x2::vec_set::contains<address>(v0, &arg1)) {
            return true
        };
        false
    }

    public fun claim_commission<T0>(arg0: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Config, arg1: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::GlobalVault, arg2: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::UserArchive, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::verify_config(arg0, 0x1::string::utf8(b"BOOSTING_MODULE"));
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::verify_signature_v2(arg0, arg6, arg7);
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::validate_archive_owner(arg2, arg9);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        assert!(v1 >= arg5 && arg5 >= arg4, 7001);
        let v2 = 0x2::bcs::new(arg7);
        let v3 = 0x2::bcs::peel_address(&mut v2);
        assert!(v0 == v3, 7000);
        assert!(arg3 > 0 && 0x2::bcs::peel_u64(&mut v2) == arg3, 7002);
        assert!(0x2::bcs::peel_u64(&mut v2) == arg4 && 0x2::bcs::peel_u64(&mut v2) == arg5, 7001);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())) == 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)), 7005);
        assert!(v1 < 0x2::bcs::peel_u64(&mut v2), 7004);
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::update_time_range(arg2, arg4, arg5);
        let v4 = CommissionClaimEvent{
            claimer  : v0,
            amount   : arg3,
            min_time : arg4,
            max_time : arg5,
            nonce    : 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::update_user_nonce(arg2, 0x2::bcs::peel_u8(&mut v2), 0x2::bcs::peel_u128(&mut v2)),
        };
        0x2::event::emit<CommissionClaimEvent>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::withdraw_from_vault<T0>(arg1, arg3, arg8, arg9), v3);
    }

    public fun claim_refund_pre_subscribe(arg0: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Config, arg1: &mut PreSubscribe, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        abort 7012
    }

    public fun claim_refund_pre_subscribe_v2<T0>(arg0: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Config, arg1: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::GlobalVault, arg2: &mut PreSubscribe, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::verify_config(arg0, 0x1::string::utf8(b"BOOSTING_MODULE"));
        assert!(!arg2.paused, 7006);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = check_can_claim_refund_pre_subscribe(arg2, v0, 0, arg3);
        let v2 = check_can_claim_refund_pre_subscribe(arg2, v0, 1, arg3);
        assert!(v1 || v2, 7012);
        let v3 = 0;
        let v4 = v3;
        if (v1) {
            v4 = v3 + *0x2::table::borrow<u8, u64>(&arg2.price_per_class, 0);
            0x2::vec_set::remove<address>(0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg2.subscribers, 0), &v0);
        };
        if (v2) {
            v4 = v4 + *0x2::table::borrow<u8, u64>(&arg2.price_per_class, 1);
            0x2::vec_set::remove<address>(0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg2.subscribers, 1), &v0);
        };
        arg2.total_refund = arg2.total_refund + v4;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::withdraw_from_vault<T0>(arg1, v4, arg3, arg4), v0);
        let v5 = PreSubscribeClaimRefundEvent{
            subscriber : v0,
            amount     : v4,
        };
        0x2::event::emit<PreSubscribeClaimRefundEvent>(v5);
    }

    public fun claim_subscribe(arg0: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Config, arg1: &mut PreSubscribe, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::verify_config(arg0, 0x1::string::utf8(b"BOOSTING_MODULE"));
        assert!(!arg1.paused, 7006);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg1.start_time != 0 && v0 >= arg1.start_time, 7010);
        assert!(v0 <= arg1.start_time + arg1.duration, 7010);
        assert!(arg1.duration > 0 && v0 <= arg1.start_time + arg1.duration, 7011);
        let v1 = 0x2::tx_context::sender(arg4);
        if (arg2 > 0 || arg2 < 1) {
            abort 7001
        };
        let v2 = if (arg2 == 0) {
            assert!(0x2::table::contains<u8, 0x2::vec_set::VecSet<address>>(&arg1.whitelisted, arg2), 7008);
            let v3 = 0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg1.whitelisted, arg2);
            assert!(0x2::vec_set::contains<address>(v3, &v1), 7009);
            0x2::vec_set::remove<address>(v3, &v1);
            0x2::vec_set::remove<address>(0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg1.subscribers, arg2), &v1);
            0x1::string::utf8(b"premium")
        } else {
            assert!(0x2::table::contains<u8, 0x2::vec_set::VecSet<address>>(&arg1.whitelisted, arg2), 7008);
            let v4 = 0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg1.whitelisted, arg2);
            assert!(0x2::vec_set::contains<address>(v4, &v1), 7009);
            0x2::vec_set::remove<address>(v4, &v1);
            0x2::vec_set::remove<address>(0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg1.subscribers, arg2), &v1);
            0x1::string::utf8(b"premium_plus")
        };
        let v5 = PreSubscribeClaimEvent{
            subscriber : v1,
            type       : v2,
        };
        0x2::event::emit<PreSubscribeClaimEvent>(v5);
    }

    public fun deposit_fund_to_vault<T0>(arg0: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::TreasureCap, arg1: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::GlobalVault, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) {
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::deposit_to_vault<T0>(arg1, arg2, arg3);
    }

    public fun deposit_pre_subscribe<T0>(arg0: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Config, arg1: &mut PreSubscribe, arg2: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::GlobalVault, arg3: u8, arg4: 0x2::balance::Balance<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::verify_config(arg0, 0x1::string::utf8(b"BOOSTING_MODULE"));
        assert!(!arg1.paused, 7006);
        assert!(0x2::table::contains<u8, u64>(&arg1.price_per_class, arg3), 7001);
        let v0 = 0x2::table::borrow<u8, u64>(&arg1.price_per_class, arg3);
        assert!(0x2::balance::value<T0>(&arg4) >= *v0, 7002);
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::deposit_to_vault<T0>(arg2, arg4, arg5);
        0x2::vec_set::insert<address>(0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg1.subscribers, arg3), 0x2::tx_context::sender(arg6));
        arg1.total_deposit = arg1.total_deposit + *v0;
        let v1 = PreSubscribeDepositEvent{
            subscriber : 0x2::tx_context::sender(arg6),
            class      : arg3,
            amount     : *v0,
        };
        0x2::event::emit<PreSubscribeDepositEvent>(v1);
    }

    public fun init_pre_subscribe(arg0: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::AdminCap, arg1: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Config, arg2: &mut 0x2::tx_context::TxContext) {
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::verify_config(arg1, 0x1::string::utf8(b"BOOSTING_MODULE"));
        let v0 = PreSubscribe{
            id              : 0x2::object::new(arg2),
            paused          : true,
            start_time      : 0,
            duration        : 259200000,
            price_per_class : 0x2::table::new<u8, u64>(arg2),
            subscribers     : 0x2::table::new<u8, 0x2::vec_set::VecSet<address>>(arg2),
            wl_manager      : 0x2::vec_set::empty<address>(),
            whitelisted     : 0x2::table::new<u8, 0x2::vec_set::VecSet<address>>(arg2),
            total_deposit   : 0,
            total_refund    : 0,
        };
        0x2::transfer::share_object<PreSubscribe>(v0);
    }

    public fun migrate(arg0: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::AdminCap, arg1: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Config, arg2: u64) {
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::migrate(arg0, arg1, arg2);
    }

    public fun pause_pre_subscribe(arg0: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::AdminCap, arg1: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Config, arg2: &mut PreSubscribe, arg3: bool) {
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::verify_config(arg1, 0x1::string::utf8(b"BOOSTING_MODULE"));
        assert!(arg2.paused != arg3, 7001);
        arg2.paused = arg3;
    }

    public fun paused(arg0: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::AdminCap, arg1: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Config, arg2: bool) {
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::paused_v2(arg0, arg1, 0x1::string::utf8(b"BOOSTING_MODULE"), arg2);
    }

    public fun register(arg0: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Logs, arg1: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Config, arg2: &mut 0x2::tx_context::TxContext) : 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::UserArchive {
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::register(arg0, arg1, arg2)
    }

    public fun remove_whitelist_manager_pre_subscribe(arg0: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::AdminCap, arg1: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Config, arg2: &mut PreSubscribe, arg3: vector<address>) {
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::verify_config(arg1, 0x1::string::utf8(b"BOOSTING_MODULE"));
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            let v1 = 0x1::vector::borrow<address>(&arg3, v0);
            if (0x2::vec_set::contains<address>(&arg2.wl_manager, v1)) {
                0x2::vec_set::remove<address>(&mut arg2.wl_manager, v1);
            };
            v0 = v0 + 1;
        };
        let v2 = PreSubscribeRemoveWlManagerEvent{users: arg3};
        0x2::event::emit<PreSubscribeRemoveWlManagerEvent>(v2);
    }

    public fun remove_whitelist_pre_subscribe(arg0: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Config, arg1: &mut PreSubscribe, arg2: u8, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::verify_config(arg0, 0x1::string::utf8(b"BOOSTING_MODULE"));
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg1.wl_manager, &v0), 7007);
        assert!(0x2::table::contains<u8, 0x2::vec_set::VecSet<address>>(&arg1.whitelisted, arg2), 7008);
        let v1 = 0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg1.whitelisted, arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg3)) {
            let v3 = 0x1::vector::borrow<address>(&arg3, v2);
            if (0x2::vec_set::contains<address>(v1, v3)) {
                0x2::vec_set::remove<address>(v1, v3);
            };
            v2 = v2 + 1;
        };
        let v4 = PreSubscribeRemoveWhiteListEvent{users: arg3};
        0x2::event::emit<PreSubscribeRemoveWhiteListEvent>(v4);
    }

    public fun set_duration_pre_subscribe(arg0: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::AdminCap, arg1: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Config, arg2: &mut PreSubscribe, arg3: u64) {
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::verify_config(arg1, 0x1::string::utf8(b"BOOSTING_MODULE"));
        assert!(arg3 >= 0, 7001);
        arg2.duration = arg3;
    }

    public fun set_fund_receiver(arg0: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::TreasureCap, arg1: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Config, arg2: address) {
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::set_fund_receiver(arg0, arg2, arg1);
    }

    public fun set_price_per_class_pre_subscribe(arg0: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::AdminCap, arg1: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Config, arg2: &mut PreSubscribe, arg3: u8, arg4: u64) {
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::verify_config(arg1, 0x1::string::utf8(b"BOOSTING_MODULE"));
        assert!(arg4 > 0, 7001);
        0x2::table::add<u8, u64>(&mut arg2.price_per_class, arg3, arg4);
    }

    public fun set_start_time_pre_subscribe(arg0: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::AdminCap, arg1: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Config, arg2: &mut PreSubscribe, arg3: u64, arg4: &0x2::clock::Clock) {
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::verify_config(arg1, 0x1::string::utf8(b"BOOSTING_MODULE"));
        assert!(arg3 >= 0x2::clock::timestamp_ms(arg4), 7001);
        arg2.start_time = arg3;
    }

    public fun subscribe<T0>(arg0: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Config, arg1: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::GlobalVault, arg2: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::UserArchive, arg3: u16, arg4: u8, arg5: vector<u8>, arg6: vector<u8>, arg7: 0x2::balance::Balance<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::verify_config(arg0, 0x1::string::utf8(b"BOOSTING_MODULE"));
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::verify_signature_v2(arg0, arg5, arg6);
        let v0 = 0x2::tx_context::sender(arg9);
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::validate_archive_owner(arg2, arg9);
        let v1 = 0x2::bcs::new(arg6);
        let v2 = 0x2::bcs::peel_u8(&mut v1);
        let v3 = 0x2::bcs::peel_u64(&mut v1);
        assert!(v0 == 0x2::bcs::peel_address(&mut v1), 7000);
        assert!(0x2::bcs::peel_u16(&mut v1) == arg3, 7001);
        assert!(v2 == arg4, 7001);
        assert!(v3 > 0 && 0x2::balance::value<T0>(&arg7) == v3, 7002);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())) == 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)), 7005);
        assert!(0x2::clock::timestamp_ms(arg8) < 0x2::bcs::peel_u64(&mut v1), 7004);
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::deposit_to_vault<T0>(arg1, arg7, arg8);
        let v4 = SubscriptionEvent{
            subscriber : v0,
            duration   : arg3,
            fee        : v3,
            class      : v2,
            nonce      : 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::update_user_nonce(arg2, 0x2::bcs::peel_u8(&mut v1), 0x2::bcs::peel_u128(&mut v1)),
        };
        0x2::event::emit<SubscriptionEvent>(v4);
    }

    public fun swap_stars<T0>(arg0: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Config, arg1: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::GlobalVault, arg2: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::UserArchive, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::verify_config(arg0, 0x1::string::utf8(b"BOOSTING_MODULE"));
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::verify_signature_v2(arg0, arg5, arg6);
        let v0 = 0x2::tx_context::sender(arg8);
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::validate_archive_owner(arg2, arg8);
        let v1 = 0x2::bcs::new(arg6);
        let v2 = 0x2::bcs::peel_address(&mut v1);
        let v3 = 0x2::bcs::peel_u64(&mut v1);
        assert!(v0 == v2, 7000);
        assert!(arg3 > 0 && 0x2::bcs::peel_u64(&mut v1) == arg3, 7001);
        assert!(v3 > 0 && arg4 == v3, 7002);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())) == 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)), 7005);
        assert!(0x2::clock::timestamp_ms(arg7) < 0x2::bcs::peel_u64(&mut v1), 7004);
        let v4 = SwappingStarEvent{
            swapper         : v0,
            number_of_stars : arg3,
            received_fee    : v3,
            nonce           : 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::update_user_nonce(arg2, 0x2::bcs::peel_u8(&mut v1), 0x2::bcs::peel_u128(&mut v1)),
        };
        0x2::event::emit<SwappingStarEvent>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::withdraw_from_vault<T0>(arg1, v3, arg7, arg8), v2);
    }

    public fun withdraw_all_from_vault<T0>(arg0: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::TreasureCap, arg1: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Config, arg2: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::GlobalVault, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::withdraw_all_from_vault<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun withdraw_amount_from_vault<T0>(arg0: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::TreasureCap, arg1: &0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::Config, arg2: &mut 0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::GlobalVault, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9e6d08c834126114d8ba66239a2c0637939087a4e5b91a752e956798f76be024::guild::withdraw_amount_from_vault<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

