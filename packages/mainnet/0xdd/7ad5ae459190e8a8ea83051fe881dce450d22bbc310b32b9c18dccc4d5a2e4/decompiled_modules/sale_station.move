module 0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::sale_station {
    struct Station has key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::drachma::DRACHMA>,
        revenue_vault: address,
        start_time: u64,
        end_time: u64,
    }

    struct RevenueVaultModified has copy, drop {
        revenue_vault: address,
    }

    struct Deposited has copy, drop {
        amount: u64,
    }

    struct Withdrawn has copy, drop {
        amount: u64,
    }

    struct Bought has copy, drop {
        user: address,
        nft: address,
        tier: 0x1::string::String,
        price: u64,
        drachma_provide_amount: u64,
    }

    fun buy(arg0: &mut Station, arg1: &mut 0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::nft::NFTInfo, arg2: &0x2::token::TokenPolicy<0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::drachma::DRACHMA>, arg3: &mut 0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::nft::TierInfo, arg4: 0x1::string::String, arg5: address, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0, 300);
        assert!(arg4 != 0x1::string::utf8(b"Collection"), 303);
        assert!(0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::utils::check_is_within(arg0.start_time, arg0.end_time, arg7), 302);
        let v0 = 0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::nft::get_remaining_tier_count(arg3, arg4, arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            assert!(*0x1::option::borrow<u64>(&v0) > 0, 304);
        };
        let v1 = 0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::nft::get_remaining_user_tier_count(arg3, arg4, arg1, arg5);
        if (0x1::option::is_some<u64>(&v1)) {
            assert!(*0x1::option::borrow<u64>(&v1) > 0, 305);
        };
        let v2 = 0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::nft::drachma_provide_amount_of_tier(arg3, arg4);
        if (v2 > 0) {
            let v3 = v2 * arg6;
            assert!(0x2::balance::value<0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::drachma::DRACHMA>(&arg0.pool) >= v3, 301);
            0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::drachma::transfer(arg2, 0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::drachma::from_coin(arg2, 0x2::coin::from_balance<0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::drachma::DRACHMA>(0x2::balance::split<0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::drachma::DRACHMA>(&mut arg0.pool, v3), arg8), arg8), arg5, arg8);
        };
        while (arg6 > 0) {
            let v4 = Bought{
                user                   : arg5,
                nft                    : 0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::nft::mint(arg1, arg3, arg4, arg5, arg8),
                tier                   : 0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::nft::name_of_tier(arg3, arg4),
                price                  : 0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::nft::price_of_tier(arg3, arg4),
                drachma_provide_amount : v2,
            };
            0x2::event::emit<Bought>(v4);
            arg6 = arg6 - 1;
        };
    }

    public entry fun buy_with_usdc(arg0: &mut Station, arg1: &mut 0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::nft::NFTInfo, arg2: &0x2::token::TokenPolicy<0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::drachma::DRACHMA>, arg3: &mut 0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::nft::TierInfo, arg4: 0x1::string::String, arg5: &mut 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        buy_with_usdc_to(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg6, arg7, arg8);
    }

    public entry fun buy_with_usdc_to(arg0: &mut Station, arg1: &mut 0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::nft::NFTInfo, arg2: &0x2::token::TokenPolicy<0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::drachma::DRACHMA>, arg3: &mut 0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::nft::TierInfo, arg4: 0x1::string::String, arg5: &mut 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::nft::price_of_tier(arg3, arg4) * arg7;
        buy(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg5, v0, arg9), arg0.revenue_vault);
    }

    entry fun deposit(arg0: &0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::role_manager::RoleManager, arg1: &mut Station, arg2: 0x2::token::Token<0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::drachma::DRACHMA>, arg3: &0x2::token::TokenPolicy<0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::drachma::DRACHMA>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::drachma::get_balance(&arg2);
        assert!(v0 >= arg4, 300);
        0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::role_manager::check_role(arg0, 0x1::string::utf8(b"ug_sale_station_admin"), arg5);
        let v1 = if (v0 == arg4) {
            0x2::coin::into_balance<0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::drachma::DRACHMA>(0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::drachma::to_coin(arg3, arg2, arg5))
        } else {
            0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::drachma::transfer(arg3, arg2, 0x2::tx_context::sender(arg5), arg5);
            0x2::coin::into_balance<0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::drachma::DRACHMA>(0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::drachma::to_coin(arg3, 0x2::token::split<0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::drachma::DRACHMA>(&mut arg2, arg4, arg5), arg5))
        };
        0x2::balance::join<0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::drachma::DRACHMA>(&mut arg1.pool, v1);
        let v2 = Deposited{amount: arg4};
        0x2::event::emit<Deposited>(v2);
    }

    public fun get_pool_balance(arg0: &Station) : u64 {
        0x2::balance::value<0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::drachma::DRACHMA>(&arg0.pool)
    }

    public fun get_sale_time(arg0: &Station) : (u64, u64) {
        (arg0.start_time, arg0.end_time)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Station{
            id            : 0x2::object::new(arg0),
            pool          : 0x2::balance::zero<0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::drachma::DRACHMA>(),
            revenue_vault : @0x8ddb50bc98d7767a11f30a623935fd0a839dd199ec28fbad26835646f085d301,
            start_time    : 1752552000000,
            end_time      : 1754280000000,
        };
        0x2::transfer::share_object<Station>(v0);
    }

    entry fun set_revenue_vault(arg0: &0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::role_manager::RoleManager, arg1: &mut Station, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::role_manager::check_role(arg0, 0x1::string::utf8(b"ug_sale_station_admin"), arg3);
        arg1.revenue_vault = arg2;
        let v0 = RevenueVaultModified{revenue_vault: arg2};
        0x2::event::emit<RevenueVaultModified>(v0);
    }

    entry fun set_start_and_end_time(arg0: &0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::role_manager::RoleManager, arg1: &mut Station, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::role_manager::check_role(arg0, 0x1::string::utf8(b"ug_sale_station_admin"), arg4);
        arg1.start_time = arg2;
        arg1.end_time = arg3;
    }

    entry fun withdraw(arg0: &0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::role_manager::RoleManager, arg1: &mut Station, arg2: &0x2::token::TokenPolicy<0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::drachma::DRACHMA>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::drachma::DRACHMA>(&arg1.pool) >= arg3, 301);
        0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::role_manager::check_role(arg0, 0x1::string::utf8(b"ug_sale_station_admin"), arg4);
        0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::drachma::transfer(arg2, 0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::drachma::from_coin(arg2, 0x2::coin::from_balance<0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::drachma::DRACHMA>(0x2::balance::split<0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::drachma::DRACHMA>(&mut arg1.pool, arg3), arg4), arg4), 0x2::tx_context::sender(arg4), arg4);
        let v0 = Withdrawn{amount: arg3};
        0x2::event::emit<Withdrawn>(v0);
    }

    // decompiled from Move bytecode v6
}

