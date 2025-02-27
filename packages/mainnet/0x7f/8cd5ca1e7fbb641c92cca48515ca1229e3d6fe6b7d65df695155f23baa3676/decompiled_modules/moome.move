module 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::moome {
    struct MoomeBank has store, key {
        id: 0x2::object::UID,
        admin_cap_id: 0x2::object::ID,
        whitelist_cap_id: 0x2::object::ID,
        fee: 0x2::balance::Balance<MOOME>,
        version: u64,
        locked_supply: 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::locked_supply::MoomeLockedSupply<MOOME>,
        storage: 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::storage_pool::MoomeStoragePool,
        burning: 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::burning_pool::MoomeBurningPool<MOOME>,
        whitelist: 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::whitelist::MoomeWhitelist,
        price_supporter: 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::price_supporter::MoomePriceSupporter,
        meta: vector<u8>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct WhitelistCap has store, key {
        id: 0x2::object::UID,
    }

    struct MOOME has drop {
        dummy_field: bool,
    }

    public fun circulating_supply(arg0: &MoomeBank) : u64 {
        assert!(arg0.version == 4, 1);
        0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::locked_supply::circulating_supply<MOOME>(&arg0.locked_supply)
    }

    public entry fun adjust_support_price_to_current_pool<T0>(arg0: &AdminCap, arg1: &mut MoomeBank, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<MOOME, 0x2::sui::SUI, T0>, arg3: &0x2::clock::Clock) {
        assert!(arg1.version == 4, 1);
        assert!(arg1.admin_cap_id == 0x2::object::id<AdminCap>(arg0), 5);
        if (!is_whitelisted(arg1, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<MOOME, 0x2::sui::SUI, T0>>(arg2))) {
            abort 4
        };
        0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::price_supporter::adjust_support_price_to_current_pool<MOOME, T0>(&mut arg1.price_supporter, arg2, arg3);
    }

    public entry fun collect_fees(arg0: &AdminCap, arg1: &mut MoomeBank, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 4, 1);
        assert!(arg1.admin_cap_id == 0x2::object::id<AdminCap>(arg0), 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<MOOME>>(0x2::coin::take<MOOME>(&mut arg1.fee, 0x2::balance::value<MOOME>(&arg1.fee), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun current_support_price(arg0: &MoomeBank) : u256 {
        assert!(arg0.version == 4, 1);
        0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::price_supporter::current_support_price(&arg0.price_supporter)
    }

    public entry fun disable_pool_cetus<T0, T1>(arg0: &WhitelistCap, arg1: &mut MoomeBank, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        assert!(arg1.version == 4, 1);
        assert!(arg1.whitelist_cap_id == 0x2::object::id<WhitelistCap>(arg0), 5);
        0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::whitelist::forget(&mut arg1.whitelist, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2));
    }

    public entry fun disable_pool_turbos<T0, T1>(arg0: &WhitelistCap, arg1: &mut MoomeBank, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>) {
        assert!(arg1.version == 4, 1);
        assert!(arg1.whitelist_cap_id == 0x2::object::id<WhitelistCap>(arg0), 5);
        0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::whitelist::forget(&mut arg1.whitelist, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>>(arg2));
    }

    public entry fun enable_pool_cetus<T0, T1>(arg0: &WhitelistCap, arg1: &mut MoomeBank, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        assert!(arg1.version == 4, 1);
        assert!(arg1.whitelist_cap_id == 0x2::object::id<WhitelistCap>(arg0), 5);
        0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::whitelist::whitelist_cetus<T0, T1>(&mut arg1.whitelist, arg2, 0x1::vector::empty<u8>());
    }

    public entry fun enable_pool_turbos<T0, T1>(arg0: &WhitelistCap, arg1: &mut MoomeBank, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>) {
        assert!(arg1.version == 4, 1);
        assert!(arg1.whitelist_cap_id == 0x2::object::id<WhitelistCap>(arg0), 5);
        0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::whitelist::whitelist_turbos<T0, T1>(&mut arg1.whitelist, arg2, 0x1::vector::empty<u8>());
    }

    public fun expected_unstaked(arg0: &MoomeBank, arg1: u64, arg2: &0x2::clock::Clock) : (vector<0x1::ascii::String>, vector<u64>, vector<u64>) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = arg1 - arg1 * 10 / 1000;
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::storage_pool::stored_amounts(&arg0.storage);
        let v5 = 0x2::vec_map::keys<0x1::ascii::String, u64>(v4);
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x1::ascii::String>(&v5)) {
            let v7 = *0x2::vec_map::get<0x1::ascii::String, u64>(v4, 0x1::vector::borrow<0x1::ascii::String>(&v5, v6));
            let (v8, v9) = 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::math::try_mul_div_down((v7 as u256), (v1 as u256), (virtual_supply_at_time(arg0, v0) as u256));
            if (v8) {
                0x1::vector::push_back<u64>(&mut v2, (v9 as u64));
            } else {
                0x1::vector::push_back<u64>(&mut v2, 0);
            };
            let (v10, v11) = 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::math::try_mul_div_down((v7 as u256), (v1 as u256), (virtual_supply_at_time(arg0, v0 + 3600000) as u256));
            if (v10) {
                0x1::vector::push_back<u64>(&mut v3, (v11 as u64));
            } else {
                0x1::vector::push_back<u64>(&mut v3, 0);
            };
            v6 = v6 + 1;
        };
        0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::events::emit_rewards_calculation_event(v5, arg1, v2, v3);
        (v5, v2, v3)
    }

    public fun finish_burn(arg0: &mut MoomeBank, arg1: 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::storage_pool::MoomeStorageWithdrawPotato, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.version == 4, 1);
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::storage_pool::consume_potato(&arg0.storage, arg1), arg3);
        if (arg2 > 0) {
            if (0x2::coin::value<0x2::sui::SUI>(&v0) < arg2) {
                abort 7
            };
        };
        v0
    }

    public fun get_staked<T0>(arg0: &mut MoomeBank, arg1: &mut 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::storage_pool::MoomeStorageWithdrawPotato, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 4, 1);
        let v0 = 0x2::coin::from_balance<T0>(0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::storage_pool::get_with_potato<T0>(&mut arg0.storage, arg1), arg3);
        if (arg2 > 0) {
            if (0x2::coin::value<T0>(&v0) < arg2) {
                abort 7
            };
        };
        v0
    }

    fun init(arg0: MOOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOME>(arg0, 9, b"MOOME", b"MOOME", b"Moome is a dual-purpose coin that acts as both a liquid staking token backed by meme collateral and a community-driven meme token, designed for transparency, sustainability, and fun", 0x1::option::some<0x2::url::Url>(0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::icon::get_icon_url()), arg1);
        let v2 = 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::locked_supply::make<MOOME>(v0, 21000000000000000, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOOME>>(v1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        let v4 = WhitelistCap{id: 0x2::object::new(arg1)};
        let v5 = MoomeBank{
            id               : 0x2::object::new(arg1),
            admin_cap_id     : 0x2::object::id<AdminCap>(&v3),
            whitelist_cap_id : 0x2::object::id<WhitelistCap>(&v4),
            fee              : 0x2::balance::zero<MOOME>(),
            version          : 4,
            locked_supply    : v2,
            storage          : 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::storage_pool::make(arg1),
            burning          : 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::burning_pool::make<MOOME>(arg1),
            whitelist        : 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::whitelist::make(arg1),
            price_supporter  : 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::price_supporter::make(arg1),
            meta             : 0x1::vector::empty<u8>(),
        };
        let v6 = 0x2::object::id<MoomeBank>(&v5);
        0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::events::emit_new_bank_event(&v6);
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<WhitelistCap>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<MOOME>>(0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::locked_supply::unlock<MOOME>(&mut v2, 10000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<MoomeBank>(v5);
    }

    public(friend) fun is_whitelisted(arg0: &MoomeBank, arg1: 0x2::object::ID) : bool {
        assert!(arg0.version == 4, 1);
        0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::whitelist::is_whitelisted(&arg0.whitelist, arg1)
    }

    public entry fun migrate(arg0: &AdminCap, arg1: &mut MoomeBank, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin_cap_id == 0x2::object::id<AdminCap>(arg0), 5);
        assert!(arg1.version < 4, 1);
        arg1.version = 4;
    }

    fun mint_coin_step_cetus_a2b<T0>(arg0: &MoomeBank, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>, u64) {
        assert!(arg0.version == 4, 1);
        let v0 = 0;
        if (is_whitelisted(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg2))) {
            v0 = 75;
        };
        let (_, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<T0, 0x2::sui::SUI>(arg2);
        if (0x2::balance::value<0x2::sui::SUI>(v2) < 50000000000) {
            v0 = 0;
        };
        let v3 = 0x2::coin::value<T0>(&arg1);
        assert!(v3 >= 100, 6);
        let (v4, v5) = 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::swap::cetus_swap_a2b<T0, 0x2::sui::SUI>(0x2::coin::split<T0>(&mut arg1, v3 - v3 / 100 * v0, arg5), arg2, arg3, arg4, arg5);
        let v6 = v5;
        if (0x2::coin::value<T0>(&v6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<T0>(v6);
        };
        (v4, arg1, v0)
    }

    fun mint_coin_step_turbos<T0, T1>(arg0: &MoomeBank, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>, u64) {
        assert!(arg0.version == 4, 1);
        let v0 = 0;
        if (is_whitelisted(arg0, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>>(arg2))) {
            v0 = 80;
        };
        let (_, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_balance<T0, 0x2::sui::SUI, T1>(arg2);
        if (v2 < 50000000000) {
            v0 = 0;
        };
        let v3 = 0x2::coin::value<T0>(&arg1);
        assert!(v3 >= 100, 6);
        let (v4, v5) = 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::swap::turbos_swap_a2b<T0, 0x2::sui::SUI, T1>(0x2::coin::split<T0>(&mut arg1, v3 - v3 / 100 * v0, arg5), arg2, arg3, arg4, arg5);
        let v6 = v5;
        if (0x2::coin::value<T0>(&v6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<T0>(v6);
        };
        (v4, arg1, v0)
    }

    fun mint_extra_step<T0, T1>(arg0: &mut MoomeBank, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<MOOME, 0x2::sui::SUI, T0>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MOOME> {
        assert!(arg0.version == 4, 1);
        if (0x2::coin::value<T1>(&arg2) > 0) {
            0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::storage_pool::put<T1>(&mut arg0.storage, 0x2::coin::into_balance<T1>(arg2), arg6, 0x1::vector::empty<u8>());
        } else {
            0x2::coin::destroy_zero<T1>(arg2);
        };
        let v0 = mint_with_sui_return<T0>(arg0, arg1, arg4, arg5, arg6, arg7);
        if (arg3 > 0) {
            0x2::coin::join<MOOME>(&mut v0, 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::locked_supply::unlock<MOOME>(&mut arg0.locked_supply, 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::math::x_is_percent_so_to_100_need(0x2::coin::value<MOOME>(&v0), 100 - arg3), arg7));
        };
        let v1 = &mut v0;
        take_the_fee(arg0, v1, arg7);
        v0
    }

    public entry fun mint_with_check_cetus_a2b<T0, T1>(arg0: &mut MoomeBank, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<MOOME, 0x2::sui::SUI, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 4, 1);
        if (!0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::price_supporter::is_pool_in_expected_price_scope<MOOME, T1>(&mut arg0.price_supporter, arg3, arg6)) {
            let (v0, v1) = 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::swap::cetus_swap_a2b<T0, 0x2::sui::SUI>(arg1, arg2, arg4, arg6, arg8);
            let (v2, v3) = 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::swap::turbos_swap_b2a<MOOME, 0x2::sui::SUI, T1>(v0, arg3, arg5, arg6, arg8);
            let v4 = v2;
            let v5 = 0x2::coin::value<MOOME>(&v4);
            if (arg7 > 0 && v5 < arg7) {
                abort 7
            };
            let v6 = &mut v4;
            take_the_fee(arg0, v6, arg8);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg8));
            0x2::transfer::public_transfer<0x2::coin::Coin<MOOME>>(v4, 0x2::tx_context::sender(arg8));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, 0x2::tx_context::sender(arg8));
            let v7 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg2);
            0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::events::emit_mint_event(&v7, 0x1::type_name::into_string(0x1::type_name::get<T0>()), 0x2::coin::value<T0>(&arg1), v5, 0);
            return
        };
        let v8 = circulating_supply(arg0);
        let (v9, v10, v11) = mint_coin_step_cetus_a2b<T0>(arg0, arg1, arg2, arg4, arg6, arg8);
        let v12 = mint_extra_step<T1, T0>(arg0, v9, v10, v11, arg3, arg5, arg6, arg8);
        let v13 = 0x2::coin::value<MOOME>(&v12);
        if (arg7 > 0 && v13 < arg7) {
            abort 7
        };
        let v14 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg2);
        0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::events::emit_mint_event(&v14, 0x1::type_name::into_string(0x1::type_name::get<T0>()), 0x2::coin::value<T0>(&arg1), v13, circulating_supply(arg0) - v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<MOOME>>(v12, 0x2::tx_context::sender(arg8));
    }

    public entry fun mint_with_check_turbos<T0, T1, T2>(arg0: &mut MoomeBank, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, 0x2::sui::SUI, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<MOOME, 0x2::sui::SUI, T0>, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 4, 1);
        if (!0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::price_supporter::is_pool_in_expected_price_scope<MOOME, T0>(&mut arg0.price_supporter, arg3, arg5)) {
            let (v0, v1) = 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::swap::turbos_swap_a2b<T1, 0x2::sui::SUI, T2>(arg1, arg2, arg4, arg5, arg7);
            let (v2, v3) = 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::swap::turbos_swap_b2a<MOOME, 0x2::sui::SUI, T0>(v0, arg3, arg4, arg5, arg7);
            let v4 = v2;
            let v5 = 0x2::coin::value<MOOME>(&v4);
            if (arg6 > 0 && v5 < arg6) {
                abort 7
            };
            let v6 = &mut v4;
            take_the_fee(arg0, v6, arg7);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg7));
            0x2::transfer::public_transfer<0x2::coin::Coin<MOOME>>(v4, 0x2::tx_context::sender(arg7));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, 0x2::tx_context::sender(arg7));
            let v7 = 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, 0x2::sui::SUI, T2>>(arg2);
            0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::events::emit_mint_event(&v7, 0x1::type_name::into_string(0x1::type_name::get<T1>()), 0x2::coin::value<T1>(&arg1), v5, 0);
            return
        };
        let v8 = circulating_supply(arg0);
        let (v9, v10, v11) = mint_coin_step_turbos<T1, T2>(arg0, arg1, arg2, arg4, arg5, arg7);
        let v12 = mint_extra_step<T0, T1>(arg0, v9, v10, v11, arg3, arg4, arg5, arg7);
        let v13 = 0x2::coin::value<MOOME>(&v12);
        if (arg6 > 0 && v13 < arg6) {
            abort 7
        };
        let v14 = 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, 0x2::sui::SUI, T2>>(arg2);
        0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::events::emit_mint_event(&v14, 0x1::type_name::into_string(0x1::type_name::get<T1>()), 0x2::coin::value<T1>(&arg1), v13, circulating_supply(arg0) - v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<MOOME>>(v12, 0x2::tx_context::sender(arg7));
    }

    fun mint_with_sui_return<T0>(arg0: &mut MoomeBank, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<MOOME, 0x2::sui::SUI, T0>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MOOME> {
        assert!(arg0.version == 4, 1);
        assert!(50 > 0, 2);
        assert!(50 < 100, 2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1) / 100 * (100 - 50);
        assert!(v0 >= 1000000, 3);
        if (!is_whitelisted(arg0, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<MOOME, 0x2::sui::SUI, T0>>(arg2))) {
            abort 4
        };
        let (v1, v2) = 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::swap::turbos_swap_b2a<MOOME, 0x2::sui::SUI, T0>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v0, arg5), arg2, arg3, arg4, arg5);
        let v3 = v1;
        0x2::coin::join<0x2::sui::SUI>(&mut arg1, v2);
        0x2::coin::join<MOOME>(&mut v3, 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::locked_supply::unlock<MOOME>(&mut arg0.locked_supply, 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::math::x_is_percent_so_to_100_need(0x2::coin::value<MOOME>(&v3), 100 - 50), arg5));
        0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::storage_pool::put_sui(&mut arg0.storage, 0x2::coin::into_balance<0x2::sui::SUI>(arg1), arg5);
        v3
    }

    public fun start_burn(arg0: &mut MoomeBank, arg1: 0x2::coin::Coin<MOOME>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::storage_pool::MoomeStorageWithdrawPotato {
        assert!(arg0.version == 4, 1);
        let v0 = &mut arg1;
        take_the_fee(arg0, v0, arg3);
        0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::burning_pool::burn<MOOME>(&mut arg0.burning, arg1, &mut arg0.locked_supply, arg2, arg3);
        0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::storage_pool::withdraw(&mut arg0.storage, 0x2::coin::value<MOOME>(&arg1), virtual_supply_at_time(arg0, 0x2::clock::timestamp_ms(arg2)))
    }

    public fun stored_amount<T0>(arg0: &MoomeBank) : u64 {
        assert!(arg0.version == 4, 1);
        0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::storage_pool::stored_amount<T0>(&arg0.storage)
    }

    public entry fun supply<T0>(arg0: &mut MoomeBank, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 4, 1);
        if (stored_amount<T0>(arg0) == 0) {
            abort 8
        };
        0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::storage_pool::put<T0>(&mut arg0.storage, 0x2::coin::into_balance<T0>(arg1), arg2, 0x1::vector::empty<u8>());
    }

    public entry fun supply_sui(arg0: &mut MoomeBank, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 4, 1);
        0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::storage_pool::put_sui(&mut arg0.storage, 0x2::coin::into_balance<0x2::sui::SUI>(arg1), arg2);
    }

    fun take_the_fee(arg0: &mut MoomeBank, arg1: &mut 0x2::coin::Coin<MOOME>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = (((0x2::coin::value<MOOME>(arg1) as u256) * (10 as u256) / 1000) as u64);
        if (v0 > 0) {
            0x2::balance::join<MOOME>(&mut arg0.fee, 0x2::coin::into_balance<MOOME>(0x2::coin::split<MOOME>(arg1, v0, arg2)));
        };
    }

    public fun virtual_supply_at_time(arg0: &MoomeBank, arg1: u64) : u64 {
        assert!(arg0.version == 4, 1);
        let v0 = circulating_supply(arg0);
        let v1 = 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::burning_pool::get_virtual_burn_amount<MOOME>(&arg0.burning, arg1);
        if (v1 > v0) {
            return 0
        };
        v0 - v1
    }

    // decompiled from Move bytecode v6
}

