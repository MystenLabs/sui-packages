module 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::dividend {
    struct DividendManager has key {
        id: 0x2::object::UID,
        dividends: 0x2::linked_table::LinkedTable<u64, DividendInfo>,
        venft_dividends: 0x2::linked_table::LinkedTable<0x2::object::ID, VeNFTDividendInfo>,
        bonus_types: vector<0x1::type_name::TypeName>,
        start_time: u64,
        interval_day: u8,
        balances: 0x2::bag::Bag,
        is_open: bool,
    }

    struct VeNFTDividendInfo has store {
        dividends: 0x2::table::Table<u64, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>,
    }

    struct DividendInfo has drop, store {
        register_time: u64,
        settled_num: u64,
        is_settled: bool,
        bonus_types: vector<0x1::type_name::TypeName>,
        bonus: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        redeemed_num: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct InitEvent has copy, drop, store {
        manager_id: 0x2::object::ID,
    }

    struct AddBonusEvent has copy, drop, store {
        token_type: 0x1::type_name::TypeName,
    }

    struct RemoveBonusEvent has copy, drop, store {
        token_type: 0x1::type_name::TypeName,
    }

    struct RegisterEvent has copy, drop, store {
        phase: u64,
        amount: u64,
    }

    struct UpdateDividendInfoEvent has copy, drop, store {
        phase: u64,
        amount_before: u64,
        amount: u64,
    }

    struct SettleEvent has copy, drop, store {
        phase: u64,
        start: vector<0x2::object::ID>,
        limit: u64,
        next_id: 0x1::option::Option<0x2::object::ID>,
        count: u64,
    }

    struct RedeemEvent has copy, drop, store {
        venft_id: 0x2::object::ID,
        phases: vector<u64>,
        redeemed_nums: 0x2::vec_map::VecMap<u64, u64>,
        amount: u64,
    }

    struct LegacyRedeemEvent has copy, drop, store {
        venft_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct TokenRedeemEvent has copy, drop, store {
        venft_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct ReceiveEvent has copy, drop, store {
        amount: u64,
    }

    struct RedeemAllEvent has copy, drop, store {
        receiver: address,
        amount: u64,
    }

    struct CloseEvent has copy, drop, store {
        manager_id: 0x2::object::ID,
        closed_by: address,
    }

    struct UpdateStartTimeEvent has copy, drop, store {
        old_start_time: u64,
        new_start_time: u64,
    }

    struct DividendInfoEvent has copy, drop, store {
        venft_id: 0x2::object::ID,
        phases: vector<u64>,
        amounts: vector<0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>,
    }

    struct UpdateIntervalDayEvent has copy, drop, store {
        old_interval_day: u8,
        interval_day: u8,
    }

    fun add_dividend(arg0: &mut DividendManager, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, arg4: &mut 0x2::tx_context::TxContext) : bool {
        if (!0x2::linked_table::contains<0x2::object::ID, VeNFTDividendInfo>(&arg0.venft_dividends, arg1)) {
            let v0 = VeNFTDividendInfo{dividends: 0x2::table::new<u64, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(arg4)};
            0x2::linked_table::push_back<0x2::object::ID, VeNFTDividendInfo>(&mut arg0.venft_dividends, arg1, v0);
        };
        let v1 = 0x2::linked_table::borrow_mut<0x2::object::ID, VeNFTDividendInfo>(&mut arg0.venft_dividends, arg1);
        if (0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&v1.dividends, arg2)) {
            0x2::table::remove<u64, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&mut v1.dividends, arg2);
            0x2::table::add<u64, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&mut v1.dividends, arg2, arg3);
            return false
        };
        0x2::table::add<u64, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&mut v1.dividends, arg2, arg3);
        true
    }

    fun calculate_total_allocated<T0>(arg0: &DividendManager) : u64 {
        let v0 = key<T0>();
        let v1 = 0;
        let v2 = *0x2::linked_table::front<u64, DividendInfo>(&arg0.dividends);
        while (0x1::option::is_some<u64>(&v2)) {
            let v3 = *0x1::option::borrow<u64>(&v2);
            let v4 = 0x2::linked_table::borrow<u64, DividendInfo>(&arg0.dividends, v3);
            if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v4.bonus, &v0)) {
                if (v4.is_settled) {
                    let v5 = v1 + *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&v4.bonus, &v0);
                    v1 = v5 - *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&v4.redeemed_num, &v0);
                } else {
                    v1 = v1 + *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&v4.bonus, &v0);
                };
            };
            v2 = *0x2::linked_table::next<u64, DividendInfo>(&arg0.dividends, v3);
        };
        v1
    }

    fun checked_package_version(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig) {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
    }

    public fun close(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut DividendManager, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::check_dividend_manager_role(arg0, 0x2::tx_context::sender(arg2));
        arg1.is_open = false;
        let v0 = CloseEvent{
            manager_id : 0x2::object::id<DividendManager>(arg1),
            closed_by  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<CloseEvent>(v0);
    }

    public fun deposit<T0>(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut DividendManager, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        assert!(arg1.is_open, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::manager_closed());
        assert!(arg3 > 0, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::insufficient_balance());
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, v0), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, arg3, arg4)));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, v0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, arg3, arg4)));
        };
        let v1 = ReceiveEvent{amount: arg3};
        0x2::event::emit<ReceiveEvent>(v1);
    }

    public fun fetch_dividend_info(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &DividendManager, arg2: 0x2::object::ID) {
        checked_package_version(arg0);
        if (!0x2::linked_table::contains<0x2::object::ID, VeNFTDividendInfo>(&arg1.venft_dividends, arg2)) {
            let v0 = DividendInfoEvent{
                venft_id : arg2,
                phases   : 0x1::vector::empty<u64>(),
                amounts  : 0x1::vector::empty<0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(),
            };
            0x2::event::emit<DividendInfoEvent>(v0);
            return
        };
        let v1 = 0x2::linked_table::borrow<0x2::object::ID, VeNFTDividendInfo>(&arg1.venft_dividends, arg2);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>();
        let v4 = *0x2::linked_table::front<u64, DividendInfo>(&arg1.dividends);
        while (0x1::option::is_some<u64>(&v4)) {
            let v5 = *0x1::option::borrow<u64>(&v4);
            if (0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&v1.dividends, v5)) {
                0x1::vector::push_back<u64>(&mut v2, v5);
                0x1::vector::push_back<0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&mut v3, *0x2::table::borrow<u64, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&v1.dividends, v5));
            };
            v4 = *0x2::linked_table::next<u64, DividendInfo>(&arg1.dividends, v5);
        };
        let v6 = DividendInfoEvent{
            venft_id : arg2,
            phases   : v2,
            amounts  : v3,
        };
        0x2::event::emit<DividendInfoEvent>(v6);
    }

    fun increase_redeem(arg0: &mut DividendManager, arg1: 0x2::vec_map::VecMap<u64, u64>, arg2: 0x1::type_name::TypeName) {
        let v0 = 0;
        let (v1, v2) = 0x2::vec_map::into_keys_values<u64, u64>(arg1);
        let v3 = v2;
        let v4 = v1;
        while (v0 < 0x1::vector::length<u64>(&v4)) {
            let v5 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut 0x2::linked_table::borrow_mut<u64, DividendInfo>(&mut arg0.dividends, *0x1::vector::borrow<u64>(&v4, v0)).redeemed_num, &arg2);
            *v5 = *v5 + *0x1::vector::borrow<u64>(&v3, v0);
            v0 = v0 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DividendManager{
            id              : 0x2::object::new(arg0),
            dividends       : 0x2::linked_table::new<u64, DividendInfo>(arg0),
            venft_dividends : 0x2::linked_table::new<0x2::object::ID, VeNFTDividendInfo>(arg0),
            bonus_types     : 0x1::vector::empty<0x1::type_name::TypeName>(),
            start_time      : 0,
            interval_day    : 7,
            balances        : 0x2::bag::new(arg0),
            is_open         : true,
        };
        let v1 = InitEvent{manager_id: 0x2::object::id<DividendManager>(&v0)};
        0x2::event::emit<InitEvent>(v1);
        0x2::transfer::share_object<DividendManager>(v0);
    }

    fun key<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::with_defining_ids<T0>()
    }

    public fun push_bonus<T0>(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut DividendManager, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::check_dividend_manager_role(arg0, 0x2::tx_context::sender(arg2));
        assert!(arg1.is_open, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::manager_closed());
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg1.bonus_types, &v0), 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::token_type_exists());
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.bonus_types, v0);
        let v1 = AddBonusEvent{token_type: v0};
        0x2::event::emit<AddBonusEvent>(v1);
    }

    public fun redeem<T0>(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut DividendManager, arg2: vector<u64>, arg3: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::VeNFT, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        checked_package_version(arg0);
        let v0 = redeem_token<T0>(arg1, arg2, arg3, arg4);
        assert!(v0 > 0, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::no_dividends_to_redeem());
        let v1 = TokenRedeemEvent{
            venft_id   : 0x2::object::id<0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::VeNFT>(arg3),
            token_type : 0x1::type_name::with_defining_ids<T0>(),
            amount     : v0,
        };
        0x2::event::emit<TokenRedeemEvent>(v1);
        0x2::coin::from_balance<T0>(take<T0>(arg1, v0), arg5)
    }

    public fun redeem_extra<T0>(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut DividendManager, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::check_dividend_manager_role(arg0, 0x2::tx_context::sender(arg4));
        assert!(arg3 <= 0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg1.balances, key<T0>())) - calculate_total_allocated<T0>(arg1), 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::insufficient_balance());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(take<T0>(arg1, arg3), arg4), arg2);
        let v0 = RedeemAllEvent{
            receiver : arg2,
            amount   : arg3,
        };
        0x2::event::emit<RedeemAllEvent>(v0);
    }

    fun redeem_token<T0>(arg0: &mut DividendManager, arg1: vector<u64>, arg2: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::VeNFT, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::object::id<0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::VeNFT>(arg2);
        if (!0x2::linked_table::contains<0x2::object::ID, VeNFTDividendInfo>(&arg0.venft_dividends, v0)) {
            return 0
        };
        let v1 = 0x2::linked_table::borrow_mut<0x2::object::ID, VeNFTDividendInfo>(&mut arg0.venft_dividends, v0);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0x2::vec_map::empty<u64, u64>();
        let v5 = key<T0>();
        let v6 = 0x1::vector::empty<u64>();
        while (v3 < 0x1::vector::length<u64>(&arg1)) {
            let v7 = *0x1::vector::borrow<u64>(&arg1, v3);
            let v8 = (arg0.start_time as u128) + (v7 as u128) * (3600 as u128) * (arg0.interval_day as u128);
            let v9 = (v8 as u64);
            assert!((v9 as u128) == v8, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::invalid_start_time());
            if (v9 > 0x2::clock::timestamp_ms(arg3) / 1000) {
                v3 = v3 + 1;
                continue
            };
            assert!(0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&v1.dividends, v7), 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::phase_dividend_not_found());
            let v10 = 0x2::table::borrow_mut<u64, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&mut v1.dividends, v7);
            if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(v10, &v5)) {
                let (_, v12) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(v10, &v5);
                v2 = v2 + v12;
                0x2::vec_map::insert<u64, u64>(&mut v4, v7, v12);
                0x1::vector::push_back<u64>(&mut v6, v7);
            };
            if (0x2::vec_map::length<0x1::type_name::TypeName, u64>(v10) == 0) {
                0x2::table::remove<u64, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&mut v1.dividends, v7);
            };
            v3 = v3 + 1;
        };
        increase_redeem(arg0, v4, v5);
        let v13 = RedeemEvent{
            venft_id      : 0x2::object::id<0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::VeNFT>(arg2),
            phases        : v6,
            redeemed_nums : v4,
            amount        : v2,
        };
        0x2::event::emit<RedeemEvent>(v13);
        v2
    }

    public fun redeem_xtoken(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::locking::LockUpManager, arg2: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::XturbosManager, arg3: &mut DividendManager, arg4: vector<u64>, arg5: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::VeNFT, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS> {
        checked_package_version(arg0);
        let v0 = redeem_token<0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::XTURBOS>(arg3, arg4, arg5, arg6);
        let v1 = LegacyRedeemEvent{
            venft_id   : 0x2::object::id<0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::VeNFT>(arg5),
            token_type : 0x1::type_name::with_defining_ids<0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::XTURBOS>(),
            amount     : v0,
        };
        0x2::event::emit<LegacyRedeemEvent>(v1);
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::locking::convert(arg0, arg1, arg2, 0x1::vector::singleton<0x2::coin::Coin<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>>(0x2::coin::from_balance<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(take<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(arg3, v0), arg7)), v0, arg5, arg7)
    }

    public fun register_bonus<T0>(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut DividendManager, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::check_dividend_manager_role(arg0, 0x2::tx_context::sender(arg5));
        assert!(arg1.is_open, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::manager_closed());
        assert!(arg2 > 0, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::invalid_phase());
        if (arg2 > 1) {
            assert!(0x2::linked_table::contains<u64, DividendInfo>(&arg1.dividends, arg2 - 1), 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::phase_not_settled());
            assert!(0x2::linked_table::borrow<u64, DividendInfo>(&arg1.dividends, arg2 - 1).is_settled, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::phase_not_settled());
        };
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg1.bonus_types, &v0), 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::token_type_not_supported());
        assert!(arg3 <= 0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg1.balances, v0)) - calculate_total_allocated<T0>(arg1), 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::insufficient_balance());
        if (!0x2::linked_table::contains<u64, DividendInfo>(&arg1.dividends, arg2)) {
            let v1 = DividendInfo{
                register_time : 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::utils::now_timestamp(arg4),
                settled_num   : 0,
                is_settled    : false,
                bonus_types   : 0x1::vector::empty<0x1::type_name::TypeName>(),
                bonus         : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
                redeemed_num  : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            };
            0x2::linked_table::push_back<u64, DividendInfo>(&mut arg1.dividends, arg2, v1);
        };
        let v2 = 0x2::linked_table::borrow_mut<u64, DividendInfo>(&mut arg1.dividends, arg2);
        assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v2.bonus, &v0), 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::token_type_already_registered());
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v2.bonus, v0, arg3);
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v2.redeemed_num, v0, 0);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v2.bonus_types, v0);
        let v3 = RegisterEvent{
            phase  : arg2,
            amount : arg3,
        };
        0x2::event::emit<RegisterEvent>(v3);
    }

    public fun remove_bonus<T0>(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut DividendManager, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::check_dividend_manager_role(arg0, 0x2::tx_context::sender(arg2));
        assert!(arg1.is_open, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::manager_closed());
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let (v1, v2) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg1.bonus_types, &v0);
        assert!(v1, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::token_type_not_found());
        0x1::vector::remove<0x1::type_name::TypeName>(&mut arg1.bonus_types, v2);
        let v3 = RemoveBonusEvent{token_type: v0};
        0x2::event::emit<RemoveBonusEvent>(v3);
    }

    public fun settle(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut DividendManager, arg2: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::XturbosManager, arg3: u64, arg4: vector<0x2::object::ID>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::object::ID> {
        checked_package_version(arg0);
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::check_dividend_settle_role(arg0, 0x2::tx_context::sender(arg6));
        assert!(arg1.is_open, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::manager_closed());
        assert!(arg3 > 0, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::invalid_phase());
        assert!(0x2::linked_table::contains<u64, DividendInfo>(&arg1.dividends, arg3), 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::phase_not_found());
        assert!(!0x2::linked_table::borrow<u64, DividendInfo>(&arg1.dividends, arg3).is_settled, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::phase_already_settled());
        let v0 = 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::total_amount(arg0, arg2);
        assert!(v0 > 0, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::insufficient_balance());
        let v1 = 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::nfts(arg0, arg2);
        let v2 = if (0x1::vector::is_empty<0x2::object::ID>(&arg4)) {
            *0x2::linked_table::front<0x2::object::ID, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::VeNftInfo>(v1)
        } else {
            assert!(0x1::vector::length<0x2::object::ID>(&arg4) == 1, 6);
            0x1::option::some<0x2::object::ID>(0x1::vector::pop_back<0x2::object::ID>(&mut arg4))
        };
        let v3 = v2;
        if (0x1::option::is_none<0x2::object::ID>(&v3)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        let v4 = 0;
        let v5 = 0;
        let v6 = 0x2::linked_table::borrow<u64, DividendInfo>(&arg1.dividends, arg3).bonus_types;
        let v7 = 0x2::linked_table::borrow<u64, DividendInfo>(&arg1.dividends, arg3).bonus;
        while (0x1::option::is_some<0x2::object::ID>(&v3) && v4 < arg5) {
            let v8 = *0x1::option::borrow<0x2::object::ID>(&v3);
            let v9 = 0;
            let v10 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
            while (v9 < 0x1::vector::length<0x1::type_name::TypeName>(&v6)) {
                let v11 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v6, v9);
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v10, v11, (((0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::xturbos_amount(arg0, 0x2::linked_table::borrow<0x2::object::ID, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::VeNftInfo>(v1, v8)) as u128) * (*0x2::vec_map::get<0x1::type_name::TypeName, u64>(&v7, &v11) as u128) / (v0 as u128)) as u64));
                v9 = v9 + 1;
            };
            if (add_dividend(arg1, v8, arg3, v10, arg6)) {
                v5 = v5 + 1;
            };
            v3 = *0x2::linked_table::next<0x2::object::ID, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::VeNftInfo>(v1, v8);
            v4 = v4 + 1;
        };
        let v12 = 0x2::linked_table::borrow_mut<u64, DividendInfo>(&mut arg1.dividends, arg3);
        v12.settled_num = v12.settled_num + v5;
        if (v12.settled_num >= 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::total_holder(arg0, arg2)) {
            v12.is_settled = true;
        };
        let v13 = SettleEvent{
            phase   : arg3,
            start   : arg4,
            limit   : arg5,
            next_id : v3,
            count   : v5,
        };
        0x2::event::emit<SettleEvent>(v13);
        v3
    }

    fun take<T0>(arg0: &mut DividendManager, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = key<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0), 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::balance_not_found());
        0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1)
    }

    public fun update_bonus<T0>(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut DividendManager, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::check_dividend_manager_role(arg0, 0x2::tx_context::sender(arg4));
        assert!(arg1.is_open, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::manager_closed());
        assert!(arg2 > 0, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::invalid_phase());
        assert!(0x2::linked_table::contains<u64, DividendInfo>(&arg1.dividends, arg2), 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::phase_not_found());
        assert!(!0x2::linked_table::borrow<u64, DividendInfo>(&arg1.dividends, arg2).is_settled, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::phase_already_settled());
        let v0 = key<T0>();
        let v1 = *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&0x2::linked_table::borrow<u64, DividendInfo>(&arg1.dividends, arg2).bonus, &v0);
        assert!(v1 != arg3, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::amount_unchanged());
        assert!(calculate_total_allocated<T0>(arg1) - v1 + arg3 <= 0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg1.balances, v0)), 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::insufficient_balance());
        *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut 0x2::linked_table::borrow_mut<u64, DividendInfo>(&mut arg1.dividends, arg2).bonus, &v0) = arg3;
        let v2 = UpdateDividendInfoEvent{
            phase         : arg2,
            amount_before : v1,
            amount        : arg3,
        };
        0x2::event::emit<UpdateDividendInfoEvent>(v2);
    }

    public fun update_interval_day(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut DividendManager, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::check_dividend_manager_role(arg0, 0x2::tx_context::sender(arg3));
        assert!(arg1.is_open, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::manager_closed());
        arg1.interval_day = arg2;
        let v0 = UpdateIntervalDayEvent{
            old_interval_day : arg1.interval_day,
            interval_day     : arg2,
        };
        0x2::event::emit<UpdateIntervalDayEvent>(v0);
    }

    public fun update_start_time(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut DividendManager, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::check_dividend_manager_role(arg0, 0x2::tx_context::sender(arg4));
        assert!(arg1.is_open, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::manager_closed());
        assert!(arg2 > 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::utils::now_timestamp(arg3), 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::invalid_start_time());
        arg1.start_time = arg2;
        let v0 = UpdateStartTimeEvent{
            old_start_time : arg1.start_time,
            new_start_time : arg2,
        };
        0x2::event::emit<UpdateStartTimeEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

