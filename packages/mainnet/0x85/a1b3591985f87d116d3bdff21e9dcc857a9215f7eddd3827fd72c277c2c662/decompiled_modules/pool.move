module 0x85a1b3591985f87d116d3bdff21e9dcc857a9215f7eddd3827fd72c277c2c662::pool {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<T0>,
        coin_b: 0x2::balance::Balance<T1>,
        protocol_fees_a: u64,
        protocol_fees_b: u64,
        last_oracle_price: u64,
        oracle: address,
        fee: u32,
        fee_protocol: u32,
        liquidity: u128,
    }

    fun swap<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T0>(arg0);
        if (v0 == 0) {
            return arg1
        };
        let v1 = 0x2::balance::split<T0>(arg0, 0x1::u64::min(arg2, v0));
        0x2::balance::join<T0>(&mut v1, arg1);
        v1
    }

    public fun deploy_pool<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0xb641fb987b573c2bab7694ad2c07f098389df1b4ec8390b1f86e612b4440728a, 1);
        let v0 = Pool<T0, T1>{
            id                : 0x2::object::new(arg0),
            coin_a            : 0x2::balance::zero<T0>(),
            coin_b            : 0x2::balance::zero<T1>(),
            protocol_fees_a   : 88819341,
            protocol_fees_b   : 4639345618,
            last_oracle_price : 137491223846,
            oracle            : @0xb641fb987b573c2bab7694ad2c07f098389df1b4ec8390b1f86e612b4440728a,
            fee               : 300,
            fee_protocol      : 0,
            liquidity         : 4618239556104543967,
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v0);
    }

    public fun provide_liquidity_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.coin_a, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun provide_liquidity_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        0x2::balance::join<T1>(&mut arg0.coin_b, 0x2::coin::into_balance<T1>(arg1));
    }

    public fun set_oracle<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xb641fb987b573c2bab7694ad2c07f098389df1b4ec8390b1f86e612b4440728a, 1);
        arg0.oracle = arg1;
    }

    public fun swap_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(0x2::tx_context::sender(arg3) == arg0.oracle, 1);
        let v0 = &mut arg0.coin_a;
        swap<T0>(v0, arg1, arg2)
    }

    public fun swap_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: u64, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert!(0x2::tx_context::sender(arg3) == arg0.oracle, 1);
        let v0 = &mut arg0.coin_b;
        swap<T1>(v0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

