module 0xc3074c311b5fbc5563f9f3a9ca71e23a20c2b7a6855ad56e3e7fb34b82648386::js_swap {
    struct LSP<phantom T0, phantom T1, phantom T2> has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        coinA: 0x2::balance::Balance<T1>,
        coinB: 0x2::balance::Balance<T2>,
        lsp_supply: 0x2::balance::Supply<LSP<T0, T1, T2>>,
        fee_percent: u64,
    }

    entry fun add_liquidity<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: 0x2::coin::Coin<T2>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = add_liquidity_<T0, T1, T2>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<LSP<T0, T1, T2>>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun add_liquidity_<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: 0x2::coin::Coin<T2>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LSP<T0, T1, T2>> {
        assert!(0x2::coin::value<T1>(&arg1) > 0 && 0x2::coin::value<T2>(&arg2) > 0, 0);
        let v0 = 0x2::coin::into_balance<T1>(arg1);
        let v1 = 0x2::coin::into_balance<T2>(arg2);
        let (v2, v3, v4) = get_amounts<T0, T1, T2>(arg0);
        assert!(0x2::balance::join<T1>(&mut arg0.coinA, v0) < 1844674407370955, 4);
        assert!(0x2::balance::join<T2>(&mut arg0.coinB, v1) < 1844674407370955, 4);
        0x2::coin::from_balance<LSP<T0, T1, T2>>(0x2::balance::increase_supply<LSP<T0, T1, T2>>(&mut arg0.lsp_supply, 0x1::u64::min(0x2::balance::value<T1>(&v0) * v4 / v2, 0x2::balance::value<T2>(&v1) * v4 / v3)), arg3)
    }

    public fun coin_a_price<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: u64) : u64 {
        let (v0, v1, _) = get_amounts<T0, T1, T2>(arg0);
        get_input_price(arg1, v1, v0, arg0.fee_percent)
    }

    public fun coin_b_price<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: u64) : u64 {
        let (v0, v1, _) = get_amounts<T0, T1, T2>(arg0);
        get_input_price(arg1, v0, v1, arg0.fee_percent)
    }

    public fun create_pool<T0: drop, T1, T2>(arg0: T0, arg1: 0x2::coin::Coin<T1>, arg2: 0x2::coin::Coin<T2>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LSP<T0, T1, T2>> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        let v1 = 0x2::coin::value<T2>(&arg2);
        assert!(v0 > 0 && v1 > 0, 0);
        assert!(v0 < 1844674407370955 && v1 < 1844674407370955, 4);
        assert!(arg3 >= 0 && arg3 < 10000, 1);
        let v2 = LSP<T0, T1, T2>{dummy_field: false};
        let v3 = 0x2::balance::create_supply<LSP<T0, T1, T2>>(v2);
        let v4 = Pool<T0, T1, T2>{
            id          : 0x2::object::new(arg4),
            coinA       : 0x2::coin::into_balance<T1>(arg1),
            coinB       : 0x2::coin::into_balance<T2>(arg2),
            lsp_supply  : v3,
            fee_percent : arg3,
        };
        0x2::transfer::share_object<Pool<T0, T1, T2>>(v4);
        0x2::coin::from_balance<LSP<T0, T1, T2>>(0x2::balance::increase_supply<LSP<T0, T1, T2>>(&mut v3, 0x1::u64::sqrt(v0) * 0x1::u64::sqrt(v1)), arg4)
    }

    public fun get_amounts<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : (u64, u64, u64) {
        (0x2::balance::value<T1>(&arg0.coinA), 0x2::balance::value<T2>(&arg0.coinB), 0x2::balance::supply_value<LSP<T0, T1, T2>>(&arg0.lsp_supply))
    }

    public fun get_input_price(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = (arg0 as u128) * (10000 - (arg3 as u128));
        ((v0 * (arg2 as u128) / ((arg1 as u128) * 10000 + v0)) as u64)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    entry fun remove_liquidity<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<LSP<T0, T1, T2>>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = remove_liquidity_<T0, T1, T2>(arg0, arg1, arg2);
        let v2 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v1, v2);
    }

    public fun remove_liquidity_<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<LSP<T0, T1, T2>>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        let v0 = 0x2::coin::value<LSP<T0, T1, T2>>(&arg1);
        assert!(v0 > 0, 0);
        let (v1, v2, v3) = get_amounts<T0, T1, T2>(arg0);
        0x2::balance::decrease_supply<LSP<T0, T1, T2>>(&mut arg0.lsp_supply, 0x2::coin::into_balance<LSP<T0, T1, T2>>(arg1));
        (0x2::coin::take<T1>(&mut arg0.coinA, v1 * v0 / v3, arg2), 0x2::coin::take<T2>(&mut arg0.coinB, v2 * v0 / v3, arg2))
    }

    entry fun swap_exact_a_for_b<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_exact_a_for_b_<T0, T1, T2>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun swap_exact_a_for_b_<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(0x2::coin::value<T1>(&arg1) > 0, 0);
        let v0 = 0x2::coin::into_balance<T1>(arg1);
        let (v1, v2, _) = get_amounts<T0, T1, T2>(arg0);
        assert!(v1 > 0 && v2 > 0, 2);
        0x2::balance::join<T1>(&mut arg0.coinA, v0);
        0x2::coin::take<T2>(&mut arg0.coinB, get_input_price(0x2::balance::value<T1>(&v0), v1, v2, arg0.fee_percent), arg2)
    }

    entry fun swap_exact_b_for_a<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_exact_b_for_a_<T0, T1, T2>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun swap_exact_b_for_a_<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::coin::value<T2>(&arg1) > 0, 0);
        let v0 = 0x2::coin::into_balance<T2>(arg1);
        let (v1, v2, _) = get_amounts<T0, T1, T2>(arg0);
        assert!(v1 > 0 && v2 > 0, 2);
        0x2::balance::join<T2>(&mut arg0.coinB, v0);
        0x2::coin::take<T1>(&mut arg0.coinA, get_input_price(0x2::balance::value<T2>(&v0), v2, v1, arg0.fee_percent), arg2)
    }

    // decompiled from Move bytecode v6
}

