module 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::lock {
    struct LpLock<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        token: 0x2::balance::Balance<T0>,
        quote: 0x2::balance::Balance<T1>,
        beneficiary: address,
        unlock_ms: u64,
    }

    public fun beneficiary<T0, T1>(arg0: &LpLock<T0, T1>) : address {
        arg0.beneficiary
    }

    public fun claim_lp<T0, T1>(arg0: &mut LpLock<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.unlock_ms, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::still_locked());
        assert!(0x2::tx_context::sender(arg2) == arg0.beneficiary, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::not_beneficiary());
        let v0 = 0x2::balance::value<T0>(&arg0.token);
        let v1 = 0x2::balance::value<T1>(&arg0.quote);
        assert!(v0 > 0 || v1 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::nothing_to_claim());
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_lp_claim(0x2::object::id<LpLock<T0, T1>>(arg0), arg0.pool_id, 0x2::tx_context::sender(arg2), v0, v1);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token, v0), arg2), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.quote, v1), arg2))
    }

    public fun lock_graduated_lp<T0, T1>(arg0: &mut 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pool::Pool<T0, T1>, arg1: &0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pool::Pool<T0, T1>>(arg0);
        let v1 = 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pool::creator<T0, T1>(arg0);
        let (v2, v3) = 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pool::take_reserves_for_lock<T0, T1>(arg0);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::clock::timestamp_ms(arg2) + 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::lp_lock_ms(arg1);
        let v7 = LpLock<T0, T1>{
            id          : 0x2::object::new(arg3),
            pool_id     : v0,
            token       : v5,
            quote       : v4,
            beneficiary : v1,
            unlock_ms   : v6,
        };
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_lock(0x2::object::id<LpLock<T0, T1>>(&v7), v0, v1, v6, 0x2::balance::value<T0>(&v5), 0x2::balance::value<T1>(&v4));
        0x2::transfer::share_object<LpLock<T0, T1>>(v7);
    }

    public fun pool_id<T0, T1>(arg0: &LpLock<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun quote_value<T0, T1>(arg0: &LpLock<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.quote)
    }

    public fun token_value<T0, T1>(arg0: &LpLock<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.token)
    }

    public fun unlock_ms<T0, T1>(arg0: &LpLock<T0, T1>) : u64 {
        arg0.unlock_ms
    }

    // decompiled from Move bytecode v7
}

