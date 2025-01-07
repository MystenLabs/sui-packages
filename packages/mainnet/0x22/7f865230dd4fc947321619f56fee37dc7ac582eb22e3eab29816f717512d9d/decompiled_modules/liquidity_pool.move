module 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool {
    struct GlobalStorage has key {
        id: 0x2::object::UID,
        pools: 0x2::object_bag::ObjectBag,
        stable_fee: u64,
        uncorrelated_fee: u64,
        dao_fee: u64,
        dao_account: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LPToken<phantom T0, phantom T1, phantom T2> has drop {
        dummy_field: bool,
    }

    struct FlashLoanReceipt<phantom T0, phantom T1, phantom T2> {
        x_loan: u64,
        y_loan: u64,
    }

    struct LiquidityPool<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        coin_x_reserve: 0x2::balance::Balance<T0>,
        coin_y_reserve: 0x2::balance::Balance<T1>,
        lp_token_supply: 0x2::balance::Supply<LPToken<T0, T1, T2>>,
        fee_percent: u64,
        dao_fee_percent: u64,
        is_locked: bool,
        x_scale: u64,
        y_scale: u64,
    }

    struct EventCreatedGlobalStorage has copy, drop {
        id: 0x2::object::ID,
    }

    struct EventRegisteredPool<phantom T0, phantom T1, phantom T2> has copy, drop {
        creator: address,
        pool_id: 0x2::object::ID,
        coin_x: 0x1::ascii::String,
        coin_y: 0x1::ascii::String,
        curve: 0x1::ascii::String,
    }

    struct EventSwap<phantom T0, phantom T1, phantom T2> has copy, drop {
        who: address,
        x_in: u64,
        x_out: u64,
        x_swapped: u64,
        y_in: u64,
        y_out: u64,
        y_swapped: u64,
    }

    struct EventRemovedLiquidity<phantom T0, phantom T1, phantom T2> has copy, drop {
        returned_x_val: u64,
        returned_y_val: u64,
        lp_tokens_burned: u64,
    }

    struct EventAddedLiquidity<phantom T0, phantom T1, phantom T2> has copy, drop {
        added_x: u64,
        added_y: u64,
        lp_tokens_received: u64,
    }

    struct EventFlashLoan<phantom T0, phantom T1, phantom T2> has copy, drop {
        x_in: u64,
        x_out: u64,
        y_in: u64,
        y_out: u64,
    }

    struct EventCreatedAdminCap has copy, drop {
        id: 0x2::object::ID,
        admin: address,
    }

    struct EventSetGlobalDaoFee has copy, drop {
        new_fee: u64,
    }

    struct EventSetGlobalStableFee has copy, drop {
        new_fee: u64,
    }

    struct EventSetGlobalUncorrelatedFee has copy, drop {
        new_fee: u64,
    }

    struct EventSetPoolFee has copy, drop {
        new_fee: u64,
    }

    struct EventSetPoolDaoFee has copy, drop {
        new_dao_fee: u64,
    }

    struct EventSetDaoAccount has copy, drop {
        new_dao_account: address,
    }

    public fun swap<T0, T1, T2>(arg0: &mut GlobalStorage, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = arg0.dao_account;
        let v1 = borrow_mut_pool<T0, T1, T2>(arg0);
        assert_pool_unlocked<T0, T1, T2>(v1);
        let v2 = 0x2::coin::value<T0>(&arg1);
        let v3 = 0x2::coin::value<T1>(&arg3);
        assert!(v2 > 0 || v3 > 0, 10006);
        let (v4, v5, _) = get_amounts<T0, T1, T2>(v1);
        assert!(v4 < 18446744073709551615 - v2, 10017);
        assert!(v5 < 18446744073709551615 - v3, 10017);
        0x2::balance::join<T0>(&mut v1.coin_x_reserve, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut v1.coin_y_reserve, 0x2::coin::into_balance<T1>(arg3));
        let v7 = 0x2::balance::split<T0>(&mut v1.coin_x_reserve, arg2);
        let v8 = 0x2::balance::split<T1>(&mut v1.coin_y_reserve, arg4);
        let (v9, v10) = new_reserves_after_fee_scaled<T2>(0x2::balance::value<T0>(&v1.coin_x_reserve), 0x2::balance::value<T1>(&v1.coin_y_reserve), v2, v3, v1.fee_percent);
        assert_lp_value_is_increased<T2>(v1.x_scale, v1.y_scale, (v4 as u128), (v5 as u128), v9, v10);
        split_fee_to_dao<T0, T1, T2>(v0, v1, v2, v3, arg5);
        let v11 = EventSwap<T0, T1, T2>{
            who       : 0x2::tx_context::sender(arg5),
            x_in      : v2,
            x_out     : arg2,
            x_swapped : 0x2::balance::value<T0>(&v7),
            y_in      : v3,
            y_out     : arg4,
            y_swapped : 0x2::balance::value<T1>(&v8),
        };
        0x2::event::emit<EventSwap<T0, T1, T2>>(v11);
        (0x2::coin::from_balance<T0>(v7, arg5), 0x2::coin::from_balance<T1>(v8, arg5))
    }

    fun assert_coin_pair_sorted<T0, T1>() {
        assert!(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::helper::is_sorted<T0, T1>() == true, 10002);
    }

    fun assert_lp_value_is_increased<T0>(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128) {
        0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::assert_valid_curve<T0>();
        if (0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::is_uncorrelated<T0>()) {
            assert!((arg4 as u256) * (arg5 as u256) > (arg2 as u256) * (arg3 as u256) * (10000 as u256) * (10000 as u256), 10007);
        } else if (0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::is_stable<T0>()) {
            assert!(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::stable_curve::lp_value(arg4, arg0, arg5, arg1) > 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::stable_curve::lp_value(arg2, arg0, arg3, arg1), 10007);
        };
    }

    fun assert_pool_unlocked<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) {
        assert!(!arg0.is_locked, 10004);
    }

    fun assert_valid_curve_fee(arg0: u64) {
        assert!(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::helper::is_valid_curve_fee(arg0) == true, 10010);
    }

    fun assert_valid_dao_fee(arg0: u64) {
        assert!(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::helper::is_valid_dao_fee(arg0) == true, 10011);
    }

    fun borrow_mut_pool<T0, T1, T2>(arg0: &mut GlobalStorage) : &mut LiquidityPool<T0, T1, T2> {
        0x2::object_bag::borrow_mut<0x1::type_name::TypeName, LiquidityPool<T0, T1, T2>>(&mut arg0.pools, 0x1::type_name::get<LiquidityPool<T0, T1, T2>>())
    }

    public fun borrow_pool<T0, T1, T2>(arg0: &GlobalStorage) : &LiquidityPool<T0, T1, T2> {
        0x2::object_bag::borrow<0x1::type_name::TypeName, LiquidityPool<T0, T1, T2>>(&arg0.pools, 0x1::type_name::get<LiquidityPool<T0, T1, T2>>())
    }

    public fun burn<T0, T1, T2>(arg0: &mut GlobalStorage, arg1: 0x2::coin::Coin<LPToken<T0, T1, T2>>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = borrow_mut_pool<T0, T1, T2>(arg0);
        assert_pool_unlocked<T0, T1, T2>(v0);
        let v1 = 0x2::coin::value<LPToken<T0, T1, T2>>(&arg1);
        let (v2, v3, v4) = get_amounts<T0, T1, T2>(v0);
        let v5 = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::math::mul_div_u128((v1 as u128), (v2 as u128), (v4 as u128));
        let v6 = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::math::mul_div_u128((v1 as u128), (v3 as u128), (v4 as u128));
        assert!(v5 > 0 && v6 > 0, 10005);
        0x2::balance::decrease_supply<LPToken<T0, T1, T2>>(&mut v0.lp_token_supply, 0x2::coin::into_balance<LPToken<T0, T1, T2>>(arg1));
        let v7 = EventRemovedLiquidity<T0, T1, T2>{
            returned_x_val   : v5,
            returned_y_val   : v6,
            lp_tokens_burned : v1,
        };
        0x2::event::emit<EventRemovedLiquidity<T0, T1, T2>>(v7);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.coin_x_reserve, v5), arg2), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v0.coin_y_reserve, v6), arg2))
    }

    public fun flash_loan<T0, T1, T2>(arg0: &mut GlobalStorage, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, FlashLoanReceipt<T0, T1, T2>) {
        assert_coin_pair_sorted<T0, T1>();
        let v0 = borrow_mut_pool<T0, T1, T2>(arg0);
        assert_pool_unlocked<T0, T1, T2>(v0);
        assert!(arg1 > 0 || arg2 > 0, 10012);
        v0.is_locked = true;
        let v1 = FlashLoanReceipt<T0, T1, T2>{
            x_loan : arg1,
            y_loan : arg2,
        };
        (0x2::coin::take<T0>(&mut v0.coin_x_reserve, arg1, arg3), 0x2::coin::take<T1>(&mut v0.coin_y_reserve, arg2, arg3), v1)
    }

    public fun get_amounts<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.coin_x_reserve), 0x2::balance::value<T1>(&arg0.coin_y_reserve), 0x2::balance::supply_value<LPToken<T0, T1, T2>>(&arg0.lp_token_supply))
    }

    public fun get_default_dao_fee(arg0: &GlobalStorage) : u64 {
        arg0.dao_fee
    }

    public fun get_default_fee<T0>(arg0: &GlobalStorage) : u64 {
        0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::assert_valid_curve<T0>();
        if (0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::is_stable<T0>()) {
            arg0.stable_fee
        } else {
            arg0.uncorrelated_fee
        }
    }

    public fun get_fee<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : u64 {
        arg0.fee_percent
    }

    public fun get_fees_config<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u64, u64) {
        (get_fee<T0, T1, T2>(arg0), 10000)
    }

    public fun get_reserves_size<T0, T1, T2>(arg0: &GlobalStorage) : (u64, u64) {
        let (v0, v1, _) = get_amounts<T0, T1, T2>(borrow_pool<T0, T1, T2>(arg0));
        (v0, v1)
    }

    public fun get_scales<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u64, u64) {
        (arg0.x_scale, arg0.y_scale)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalStorage{
            id               : 0x2::object::new(arg0),
            pools            : 0x2::object_bag::new(arg0),
            stable_fee       : 1,
            uncorrelated_fee : 30,
            dao_fee          : 20,
            dao_account      : @0xad383492685d5244f934ee21616dad550263fa74565ec2c456616db494ac4af3,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = EventCreatedGlobalStorage{id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<EventCreatedGlobalStorage>(v2);
        let v3 = EventCreatedAdminCap{
            id    : 0x2::object::uid_to_inner(&v1.id),
            admin : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<EventCreatedAdminCap>(v3);
        0x2::transfer::share_object<GlobalStorage>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun mint<T0, T1, T2>(arg0: &mut GlobalStorage, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LPToken<T0, T1, T2>> {
        assert!(0x2::object_bag::contains<0x1::type_name::TypeName>(&arg0.pools, 0x1::type_name::get<LiquidityPool<T0, T1, T2>>()), 10016);
        let v0 = borrow_mut_pool<T0, T1, T2>(arg0);
        assert_pool_unlocked<T0, T1, T2>(v0);
        let (v1, v2, v3) = get_amounts<T0, T1, T2>(v0);
        let v4 = 0x2::coin::value<T0>(&arg1);
        let v5 = 0x2::coin::value<T1>(&arg2);
        let v6 = if (v3 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<LPToken<T0, T1, T2>>>(0x2::coin::from_balance<LPToken<T0, T1, T2>>(0x2::balance::increase_supply<LPToken<T0, T1, T2>>(&mut v0.lp_token_supply, 1000), arg3), @0x0);
            let v7 = (0x2::math::sqrt_u128(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::math::mul_to_u128(v4, v5)) as u64);
            assert!(v7 > 1000, 10003);
            v7 - 1000
        } else {
            let v8 = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::math::mul_div_u128((v4 as u128), (v3 as u128), (v1 as u128));
            let v9 = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::math::mul_div_u128((v5 as u128), (v3 as u128), (v2 as u128));
            if (v8 < v9) {
                v8
            } else {
                v9
            }
        };
        assert!(v6 > 0, 10003);
        0x2::balance::join<T0>(&mut v0.coin_x_reserve, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut v0.coin_y_reserve, 0x2::coin::into_balance<T1>(arg2));
        let v10 = 0x2::balance::increase_supply<LPToken<T0, T1, T2>>(&mut v0.lp_token_supply, v6);
        let v11 = EventAddedLiquidity<T0, T1, T2>{
            added_x            : v4,
            added_y            : v5,
            lp_tokens_received : 0x2::balance::value<LPToken<T0, T1, T2>>(&v10),
        };
        0x2::event::emit<EventAddedLiquidity<T0, T1, T2>>(v11);
        0x2::coin::from_balance<LPToken<T0, T1, T2>>(v10, arg3)
    }

    fun new_reserves_after_fee_scaled<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u128, u128) {
        0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::assert_valid_curve<T0>();
        if (0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::is_uncorrelated<T0>()) {
            return (0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::math::mul_to_u128(arg0, 10000) - 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::math::mul_to_u128(arg2, arg4), 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::math::mul_to_u128(arg1, 10000) - 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::math::mul_to_u128(arg3, arg4))
        };
        (((arg0 - 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::math::mul_div(arg2, arg4, 10000)) as u128), ((arg1 - 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::math::mul_div(arg3, arg4, 10000)) as u128))
    }

    public fun register<T0, T1, T2>(arg0: &mut GlobalStorage, arg1: &mut 0x2::tx_context::TxContext) {
        assert_coin_pair_sorted<T0, T1>();
        0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::assert_valid_curve<T2>();
        assert!(!0x2::object_bag::contains<0x1::type_name::TypeName>(&arg0.pools, 0x1::type_name::get<LiquidityPool<T0, T1, T2>>()), 10009);
        let v0 = LPToken<T0, T1, T2>{dummy_field: false};
        let v1 = 0;
        let v2 = 0;
        if (0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::is_stable<T2>()) {
            v1 = 0x2::math::pow(10, 9);
            v2 = 0x2::math::pow(10, 9);
        };
        let v3 = LiquidityPool<T0, T1, T2>{
            id              : 0x2::object::new(arg1),
            coin_x_reserve  : 0x2::balance::zero<T0>(),
            coin_y_reserve  : 0x2::balance::zero<T1>(),
            lp_token_supply : 0x2::balance::create_supply<LPToken<T0, T1, T2>>(v0),
            fee_percent     : get_default_fee<T2>(arg0),
            dao_fee_percent : get_default_dao_fee(arg0),
            is_locked       : false,
            x_scale         : v1,
            y_scale         : v2,
        };
        let v4 = EventRegisteredPool<T0, T1, T2>{
            creator : 0x2::tx_context::sender(arg1),
            pool_id : 0x2::object::id<LiquidityPool<T0, T1, T2>>(&v3),
            coin_x  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            coin_y  : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            curve   : 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::get_type_name<T2>(),
        };
        0x2::event::emit<EventRegisteredPool<T0, T1, T2>>(v4);
        0x2::object_bag::add<0x1::type_name::TypeName, LiquidityPool<T0, T1, T2>>(&mut arg0.pools, 0x1::type_name::get<LiquidityPool<T0, T1, T2>>(), v3);
    }

    public fun repay_flash_loan<T0, T1, T2>(arg0: &mut GlobalStorage, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: FlashLoanReceipt<T0, T1, T2>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_coin_pair_sorted<T0, T1>();
        let v0 = arg0.dao_account;
        let v1 = borrow_mut_pool<T0, T1, T2>(arg0);
        let FlashLoanReceipt {
            x_loan : v2,
            y_loan : v3,
        } = arg3;
        let v4 = 0x2::coin::value<T0>(&arg1);
        let v5 = 0x2::coin::value<T1>(&arg2);
        assert!(v4 > 0 || v5 > 0, 10013);
        let (v6, v7, _) = get_amounts<T0, T1, T2>(v1);
        0x2::balance::join<T0>(&mut v1.coin_x_reserve, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut v1.coin_y_reserve, 0x2::coin::into_balance<T1>(arg2));
        let (v9, v10) = new_reserves_after_fee_scaled<T2>(0x2::balance::value<T0>(&v1.coin_x_reserve), 0x2::balance::value<T1>(&v1.coin_y_reserve), v4, v5, v1.fee_percent);
        assert_lp_value_is_increased<T2>(v1.x_scale, v1.y_scale, ((v6 + v2) as u128), ((v7 + v3) as u128), v9, v10);
        split_fee_to_dao<T0, T1, T2>(v0, v1, v4, v5, arg4);
        v1.is_locked = false;
        let v11 = EventFlashLoan<T0, T1, T2>{
            x_in  : v4,
            x_out : v2,
            y_in  : v5,
            y_out : v3,
        };
        0x2::event::emit<EventFlashLoan<T0, T1, T2>>(v11);
    }

    public entry fun set_dao_account(arg0: &AdminCap, arg1: &mut GlobalStorage, arg2: address) {
        assert!(arg1.dao_account != arg2, 10015);
        assert!(arg2 != @0x0, 10018);
        arg1.dao_account = arg2;
        let v0 = EventSetDaoAccount{new_dao_account: arg2};
        0x2::event::emit<EventSetDaoAccount>(v0);
    }

    public entry fun set_dao_fee(arg0: &AdminCap, arg1: &mut GlobalStorage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_valid_dao_fee(arg2);
        arg1.dao_fee = arg2;
        let v0 = EventSetGlobalDaoFee{new_fee: arg2};
        0x2::event::emit<EventSetGlobalDaoFee>(v0);
    }

    public entry fun set_pool_dao_fee<T0, T1, T2>(arg0: &AdminCap, arg1: &mut GlobalStorage, arg2: u64) {
        assert_coin_pair_sorted<T0, T1>();
        0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::assert_valid_curve<T2>();
        assert_valid_dao_fee(arg2);
        borrow_mut_pool<T0, T1, T2>(arg1).dao_fee_percent = arg2;
        let v0 = EventSetPoolDaoFee{new_dao_fee: arg2};
        0x2::event::emit<EventSetPoolDaoFee>(v0);
    }

    public entry fun set_pool_fee<T0, T1, T2>(arg0: &AdminCap, arg1: &mut GlobalStorage, arg2: u64) {
        assert_coin_pair_sorted<T0, T1>();
        0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::assert_valid_curve<T2>();
        assert_valid_curve_fee(arg2);
        borrow_mut_pool<T0, T1, T2>(arg1).fee_percent = arg2;
        let v0 = EventSetPoolFee{new_fee: arg2};
        0x2::event::emit<EventSetPoolFee>(v0);
    }

    public entry fun set_stable_fee(arg0: &AdminCap, arg1: &mut GlobalStorage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_valid_curve_fee(arg2);
        arg1.stable_fee = arg2;
        let v0 = EventSetGlobalStableFee{new_fee: arg2};
        0x2::event::emit<EventSetGlobalStableFee>(v0);
    }

    public entry fun set_uncorrelated_fee(arg0: &AdminCap, arg1: &mut GlobalStorage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_valid_curve_fee(arg2);
        arg1.uncorrelated_fee = arg2;
        let v0 = EventSetGlobalUncorrelatedFee{new_fee: arg2};
        0x2::event::emit<EventSetGlobalUncorrelatedFee>(v0);
    }

    fun split_fee_to_dao<T0, T1, T2>(arg0: address, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 || arg3 > 0, 10014);
        if (arg1.dao_fee_percent == 0) {
            return
        };
        let v0 = arg1.fee_percent;
        let v1 = arg1.dao_fee_percent;
        let v2 = if (v0 * v1 % 100 != 0) {
            v0 * v1 / 100 + 1
        } else {
            v0 * v1 / 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.coin_x_reserve, 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::math::mul_div(arg2, v2, 10000)), arg4), arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.coin_y_reserve, 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::math::mul_div(arg3, v2, 10000)), arg4), arg0);
    }

    // decompiled from Move bytecode v6
}

