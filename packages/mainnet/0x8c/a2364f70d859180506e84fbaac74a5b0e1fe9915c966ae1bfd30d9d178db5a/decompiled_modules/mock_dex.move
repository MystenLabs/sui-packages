module 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::mock_dex {
    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        curve_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        tokens: 0x2::balance::Balance<T0>,
        sui_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        token_fees: 0x2::balance::Balance<T0>,
        lp_supply: u64,
        lp_burned: bool,
    }

    struct LpBurnProof<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        curve_id: 0x2::object::ID,
        lp_amount: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        curve_id: 0x2::object::ID,
        sui_amount: u64,
        token_amount: u64,
        lp_burned: u64,
    }

    struct Swapped has copy, drop {
        pool_id: 0x2::object::ID,
        is_buy: bool,
        sui_amount: u64,
        token_amount: u64,
        fee_amount: u64,
    }

    public fun coin_type<T0>(arg0: &Pool<T0>) : 0x1::ascii::String {
        arg0.coin_type
    }

    public fun curve_id<T0>(arg0: &Pool<T0>) : 0x2::object::ID {
        arg0.curve_id
    }

    public fun collect_fees<T0>(arg0: &mut Pool<T0>, arg1: &LpBurnProof<T0>, arg2: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::fees::FeeVault, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::uid_to_inner(&arg0.id), 3);
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::router::deposit_pool_fees<T0>(arg2, arg0.curve_id, arg0.coin_type, 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::fees::creator_of(arg2, arg0.curve_id), 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui_fees), 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.token_fees), arg4), arg3);
    }

    public fun is_lp_burned<T0>(arg0: &Pool<T0>) : bool {
        arg0.lp_burned
    }

    public fun lp_supply<T0>(arg0: &Pool<T0>) : u64 {
        arg0.lp_supply
    }

    public fun migrate<T0>(arg0: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::migration::MigrationVault<T0>, arg1: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::MigrationCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : LpBurnProof<T0> {
        let v0 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::migration::curve_id<T0>(arg0);
        let (v1, v2) = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::migration::redeem<T0>(arg0, arg1);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&v4);
        let v6 = 0x2::balance::value<T0>(&v3);
        assert!(v5 > 0 && v6 > 0, 0);
        let v7 = (sqrt_u128((v5 as u128) * (v6 as u128)) as u64);
        let v8 = Pool<T0>{
            id         : 0x2::object::new(arg3),
            curve_id   : v0,
            coin_type  : 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::migration::coin_type<T0>(arg0),
            sui        : v4,
            tokens     : v3,
            sui_fees   : 0x2::balance::zero<0x2::sui::SUI>(),
            token_fees : 0x2::balance::zero<T0>(),
            lp_supply  : v7,
            lp_burned  : true,
        };
        let v9 = 0x2::object::uid_to_inner(&v8.id);
        let v10 = PoolCreated{
            pool_id      : v9,
            curve_id     : v0,
            sui_amount   : v5,
            token_amount : v6,
            lp_burned    : v7,
        };
        0x2::event::emit<PoolCreated>(v10);
        let v11 = LpBurnProof<T0>{
            id        : 0x2::object::new(arg3),
            pool_id   : v9,
            curve_id  : v0,
            lp_amount : v7,
        };
        0x2::transfer::share_object<Pool<T0>>(v8);
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::migration::confirm<T0>(arg0, arg1, v9, 0x1::option::some<0x2::object::ID>(0x2::object::uid_to_inner(&v11.id)), arg2);
        v11
    }

    public fun migrate_and_share<T0>(arg0: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::migration::MigrationVault<T0>, arg1: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::MigrationCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<LpBurnProof<T0>>(migrate<T0>(arg0, arg1, arg2, arg3));
    }

    public fun pending_fees<T0>(arg0: &Pool<T0>) : (u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_fees), 0x2::balance::value<T0>(&arg0.token_fees))
    }

    public fun proof_curve_id<T0>(arg0: &LpBurnProof<T0>) : 0x2::object::ID {
        arg0.curve_id
    }

    public fun proof_pool_id<T0>(arg0: &LpBurnProof<T0>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun reserves<T0>(arg0: &Pool<T0>) : (u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui), 0x2::balance::value<T0>(&arg0.tokens))
    }

    fun sqrt_u128(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = v0 + arg0 / v0;
            v0 = v1 / 2;
        };
        arg0
    }

    public fun swap_sui_for_token<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 2);
        let v1 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::math::mul_bps(v0, 30);
        let v2 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::math::tokens_out(0x2::balance::value<0x2::sui::SUI>(&arg0.sui), 0x2::balance::value<T0>(&arg0.tokens), v0 - v1);
        assert!(v2 >= arg2, 1);
        assert!(v2 < 0x2::balance::value<T0>(&arg0.tokens), 0);
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_fees, 0x2::balance::split<0x2::sui::SUI>(&mut v3, v1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, v3);
        let v4 = Swapped{
            pool_id      : 0x2::object::uid_to_inner(&arg0.id),
            is_buy       : true,
            sui_amount   : v0,
            token_amount : v2,
            fee_amount   : v1,
        };
        0x2::event::emit<Swapped>(v4);
        0x2::coin::take<T0>(&mut arg0.tokens, v2, arg3)
    }

    public fun swap_token_for_sui<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        let v1 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::math::mul_bps(v0, 30);
        let v2 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::math::sui_out(0x2::balance::value<0x2::sui::SUI>(&arg0.sui), 0x2::balance::value<T0>(&arg0.tokens), v0 - v1);
        assert!(v2 >= arg2, 1);
        assert!(v2 < 0x2::balance::value<0x2::sui::SUI>(&arg0.sui), 0);
        let v3 = 0x2::coin::into_balance<T0>(arg1);
        0x2::balance::join<T0>(&mut arg0.token_fees, 0x2::balance::split<T0>(&mut v3, v1));
        0x2::balance::join<T0>(&mut arg0.tokens, v3);
        let v4 = Swapped{
            pool_id      : 0x2::object::uid_to_inner(&arg0.id),
            is_buy       : false,
            sui_amount   : v2,
            token_amount : v0,
            fee_amount   : v1,
        };
        0x2::event::emit<Swapped>(v4);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui, v2, arg3)
    }

    // decompiled from Move bytecode v7
}

