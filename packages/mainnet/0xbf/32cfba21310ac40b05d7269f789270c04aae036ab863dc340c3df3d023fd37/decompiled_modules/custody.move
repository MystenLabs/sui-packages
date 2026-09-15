module 0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        account_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        admin: 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>,
        max_order_size: u64,
        paused: bool,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
    }

    public fun new<T0>(arg0: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (Vault<T0>, OwnerCap) {
        assert!(arg2 > 0, 4);
        let (v0, v1, v2) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::create_account<T0>(arg0, arg3);
        let v3 = v0;
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::consume_policy_and_share_account<T0>(v3, v1);
        let v4 = Vault<T0>{
            id             : 0x2::object::new(arg3),
            account_id     : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>>(&v3),
            market_id      : arg1,
            admin          : v2,
            max_order_size : arg2,
            paused         : true,
        };
        let v5 = OwnerCap{
            id    : 0x2::object::new(arg3),
            vault : 0x2::object::id<Vault<T0>>(&v4),
        };
        (v4, v5)
    }

    public fun account_id<T0>(arg0: &Vault<T0>) : 0x2::object::ID {
        arg0.account_id
    }

    public fun allocate_margin<T0>(arg0: &Vault<T0>, arg1: &OwnerCap, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg4: u64) {
        owner<T0>(arg0, arg1);
        check<T0>(arg0, arg2);
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(arg3) == arg0.market_id, 3);
        assert!(arg4 > 0 && arg4 <= 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::collateral_balance<T0>(arg2), 4);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::allocate_collateral<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg3, &arg0.admin, arg2, arg4);
    }

    public fun assert_owner<T0>(arg0: &Vault<T0>, arg1: &OwnerCap) {
        owner<T0>(arg0, arg1);
    }

    public fun balance<T0>(arg0: &Vault<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>) : u64 {
        check<T0>(arg0, arg1);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::collateral_balance<T0>(arg1)
    }

    fun check<T0>(arg0: &Vault<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>) {
        assert!(arg0.account_id == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>>(arg1), 1);
    }

    public fun configure_margin<T0>(arg0: &Vault<T0>, arg1: &OwnerCap, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg4: u64) {
        owner<T0>(arg0, arg1);
        check<T0>(arg0, arg2);
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(arg3) == arg0.market_id, 3);
        assert!(arg4 <= 10000 && (arg4 as u256) * 100000000000000 >= 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::margin_ratio_initial(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg3)), 4);
        if (!0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T0>(arg3, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg2))) {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::create_market_position<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg3, &arg0.admin, arg2);
        };
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::set_position_initial_margin_ratio<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg3, &arg0.admin, arg2, (arg4 as u256) * 100000000000000);
    }

    public fun deposit<T0>(arg0: &Vault<T0>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: 0x2::coin::Coin<T0>) {
        check<T0>(arg0, arg1);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::deposit_collateral<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, &arg0.admin, arg2, arg3);
    }

    public fun market_id<T0>(arg0: &Vault<T0>) : 0x2::object::ID {
        arg0.market_id
    }

    fun owner<T0>(arg0: &Vault<T0>, arg1: &OwnerCap) {
        assert!(arg1.vault == 0x2::object::id<Vault<T0>>(arg0), 2);
    }

    public fun set_paused<T0>(arg0: &mut Vault<T0>, arg1: &OwnerCap, arg2: bool) {
        owner<T0>(arg0, arg1);
        arg0.paused = arg2;
    }

    public fun share<T0>(arg0: Vault<T0>) {
        0x2::transfer::share_object<Vault<T0>>(arg0);
    }

    public fun trade<T0>(arg0: &Vault<T0>, arg1: &OwnerCap, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: bool, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::SessionSummary) {
        owner<T0>(arg0, arg1);
        check<T0>(arg0, arg2);
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(&arg3) == arg0.market_id, 3);
        let v0 = if (!arg0.paused) {
            if (arg7 > 0) {
                arg7 <= arg0.max_order_size
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 4);
        if (!0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T0>(&arg3, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg2))) {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::create_market_position<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut arg3, &arg0.admin, arg2);
        };
        let v1 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::start_session<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg3, &arg0.admin, arg2, arg4, arg5, 0x1::option::none<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::IntegratorInfo>(), arg9, arg10);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_market_order<T0>(&mut v1, arg6, arg7, arg8);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::end_session<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(v1, &arg0.admin, arg2, true, true)
    }

    public fun withdraw<T0>(arg0: &Vault<T0>, arg1: &OwnerCap, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        owner<T0>(arg0, arg1);
        check<T0>(arg0, arg2);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::withdraw_collateral<T0>(arg2, &arg0.admin, arg3, arg4, arg5)
    }

    // decompiled from Move bytecode v7
}

