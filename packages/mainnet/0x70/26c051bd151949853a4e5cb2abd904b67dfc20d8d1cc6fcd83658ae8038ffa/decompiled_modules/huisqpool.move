module 0x7026c051bd151949853a4e5cb2abd904b67dfc20d8d1cc6fcd83658ae8038ffa::huisqpool {
    struct LSP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        tokenA: 0x2::balance::Balance<T0>,
        tokenB: 0x2::balance::Balance<T1>,
        lsp_supply: 0x2::balance::Supply<LSP<T0, T1>>,
        fee_percent: u64,
    }

    entry fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = add_liquidity_internal<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<LSP<T0, T1>>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun add_liquidity_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LSP<T0, T1>> {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 0);
        assert!(0x2::coin::value<T1>(&arg2) > 0, 0);
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let v1 = 0x2::coin::into_balance<T1>(arg2);
        let (v2, v3, v4) = get_amounts<T0, T1>(arg0);
        assert!(0x2::balance::join<T0>(&mut arg0.tokenA, v0) < 1844674407370955, 4);
        assert!(0x2::balance::join<T1>(&mut arg0.tokenB, v1) < 1844674407370955, 4);
        0x2::coin::from_balance<LSP<T0, T1>>(0x2::balance::increase_supply<LSP<T0, T1>>(&mut arg0.lsp_supply, 0x2::math::min(0x2::balance::value<T0>(&v0) * v4 / v2, 0x2::balance::value<T1>(&v1) * v4 / v3)), arg3)
    }

    public entry fun create_pool<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0 && v1 > 0, 0);
        assert!(v0 < 1844674407370955 && v1 < 1844674407370955, 4);
        let v2 = LSP<T0, T1>{dummy_field: false};
        let v3 = 0x2::balance::create_supply<LSP<T0, T1>>(v2);
        let v4 = Pool<T0, T1>{
            id          : 0x2::object::new(arg3),
            tokenA      : 0x2::coin::into_balance<T0>(arg0),
            tokenB      : 0x2::coin::into_balance<T1>(arg1),
            lsp_supply  : v3,
            fee_percent : arg2,
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<LSP<T0, T1>>>(0x2::coin::from_balance<LSP<T0, T1>>(0x2::balance::increase_supply<LSP<T0, T1>>(&mut v3, 0x2::math::sqrt(v0) * 0x2::math::sqrt(v1)), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun get_amounts<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.tokenA), 0x2::balance::value<T1>(&arg0.tokenB), 0x2::balance::supply_value<LSP<T0, T1>>(&arg0.lsp_supply))
    }

    public fun get_input_price(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = (arg0 as u128) * (10000 - (arg3 as u128));
        ((v0 * (arg2 as u128) / ((arg1 as u128) * 10000 + v0)) as u64)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LSP<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<LSP<T0, T1>>(&arg1);
        assert!(v0 > 0, 0);
        let (v1, v2, v3) = get_amounts<T0, T1>(arg0);
        0x2::balance::decrease_supply<LSP<T0, T1>>(&mut arg0.lsp_supply, 0x2::coin::into_balance<LSP<T0, T1>>(arg1));
        (0x2::coin::take<T0>(&mut arg0.tokenA, v1 * v0 / v3, arg2), 0x2::coin::take<T1>(&mut arg0.tokenB, v2 * v0 / v3, arg2))
    }

    entry fun remove_liquidity_<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LSP<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = remove_liquidity<T0, T1>(arg0, arg1, arg2);
        let v2 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v2);
    }

    entry fun swap_A_to_B<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_A_to_B_internal<T0, T1>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun swap_A_to_B_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 0);
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let (v1, v2, _) = get_amounts<T0, T1>(arg0);
        assert!(v1 > 0 && v2 > 0, 2);
        0x2::balance::join<T0>(&mut arg0.tokenA, v0);
        0x2::coin::take<T1>(&mut arg0.tokenB, get_input_price(0x2::balance::value<T0>(&v0), v1, v2, arg0.fee_percent), arg2)
    }

    entry fun swap_B_to_A<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_B_to_A_internal<T0, T1>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun swap_B_to_A_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T1>(&arg1) > 0, 0);
        let v0 = 0x2::coin::into_balance<T1>(arg1);
        let (v1, v2, _) = get_amounts<T0, T1>(arg0);
        assert!(v1 > 0 && v2 > 0, 2);
        0x2::balance::join<T1>(&mut arg0.tokenB, v0);
        0x2::coin::take<T0>(&mut arg0.tokenA, get_input_price(0x2::balance::value<T1>(&v0), v2, v1, arg0.fee_percent), arg2)
    }

    public fun tokenA_price<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        let (v0, v1, _) = get_amounts<T0, T1>(arg0);
        get_input_price(arg1, v1, v0, arg0.fee_percent)
    }

    public fun tokenB_price<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        let (v0, v1, _) = get_amounts<T0, T1>(arg0);
        get_input_price(arg1, v0, v1, arg0.fee_percent)
    }

    // decompiled from Move bytecode v6
}

