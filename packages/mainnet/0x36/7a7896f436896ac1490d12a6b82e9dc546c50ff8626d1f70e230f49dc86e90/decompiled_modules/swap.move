module 0x367a7896f436896ac1490d12a6b82e9dc546c50ff8626d1f70e230f49dc86e90::swap {
    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        coin_balance: 0x2::balance::Balance<T0>,
        suis_balance: 0x2::balance::Balance<0x367a7896f436896ac1490d12a6b82e9dc546c50ff8626d1f70e230f49dc86e90::suis::SUIS>,
        exchange_rate: u64,
    }

    public fun create_pool<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<0x367a7896f436896ac1490d12a6b82e9dc546c50ff8626d1f70e230f49dc86e90::suis::SUIS>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        let v0 = Pool<T0>{
            id            : 0x2::object::new(arg3),
            coin_balance  : 0x2::coin::into_balance<T0>(arg0),
            suis_balance  : 0x2::coin::into_balance<0x367a7896f436896ac1490d12a6b82e9dc546c50ff8626d1f70e230f49dc86e90::suis::SUIS>(arg1),
            exchange_rate : arg2,
        };
        0x2::transfer::share_object<Pool<T0>>(v0);
    }

    public fun swap_coin_to_suis<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x367a7896f436896ac1490d12a6b82e9dc546c50ff8626d1f70e230f49dc86e90::suis::SUIS> {
        let v0 = 0x2::coin::value<T0>(&arg1) / arg0.exchange_rate;
        assert!(0x2::balance::value<0x367a7896f436896ac1490d12a6b82e9dc546c50ff8626d1f70e230f49dc86e90::suis::SUIS>(&arg0.suis_balance) >= v0, 0);
        0x2::balance::join<T0>(&mut arg0.coin_balance, 0x2::coin::into_balance<T0>(arg1));
        0x2::coin::from_balance<0x367a7896f436896ac1490d12a6b82e9dc546c50ff8626d1f70e230f49dc86e90::suis::SUIS>(0x2::balance::split<0x367a7896f436896ac1490d12a6b82e9dc546c50ff8626d1f70e230f49dc86e90::suis::SUIS>(&mut arg0.suis_balance, v0), arg2)
    }

    public fun swap_suis_to_coin<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<0x367a7896f436896ac1490d12a6b82e9dc546c50ff8626d1f70e230f49dc86e90::suis::SUIS>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<0x367a7896f436896ac1490d12a6b82e9dc546c50ff8626d1f70e230f49dc86e90::suis::SUIS>(&arg1) * arg0.exchange_rate;
        assert!(0x2::balance::value<T0>(&arg0.coin_balance) >= v0, 0);
        0x2::balance::join<0x367a7896f436896ac1490d12a6b82e9dc546c50ff8626d1f70e230f49dc86e90::suis::SUIS>(&mut arg0.suis_balance, 0x2::coin::into_balance<0x367a7896f436896ac1490d12a6b82e9dc546c50ff8626d1f70e230f49dc86e90::suis::SUIS>(arg1));
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_balance, v0), arg2)
    }

    // decompiled from Move bytecode v6
}

