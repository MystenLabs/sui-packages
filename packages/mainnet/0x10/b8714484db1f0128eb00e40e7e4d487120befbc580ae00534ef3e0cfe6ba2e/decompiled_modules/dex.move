module 0x10b8714484db1f0128eb00e40e7e4d487120befbc580ae00534ef3e0cfe6ba2e::dex {
    struct LSP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        token: 0x2::balance::Balance<T1>,
        lsp_supply: 0x2::balance::Supply<LSP<T0, T1>>,
        fee_percent: u64,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LSP<T0, T1>> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 0);
        assert!(0x2::coin::value<T1>(&arg2) > 0, 0);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        let v1 = 0x2::coin::into_balance<T1>(arg2);
        let (v2, v3, v4) = get_amounts<T0, T1>(arg0);
        assert!(0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, v0) < 1844674407370955, 4);
        assert!(0x2::balance::join<T1>(&mut arg0.token, v1) < 1844674407370955, 4);
        0x2::coin::from_balance<LSP<T0, T1>>(0x2::balance::increase_supply<LSP<T0, T1>>(&mut arg0.lsp_supply, 0x2::math::min(0x2::balance::value<0x2::sui::SUI>(&v0) * v4 / v2, 0x2::balance::value<T1>(&v1) * v4 / v3)), arg3)
    }

    entry fun add_liquidity_<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = add_liquidity<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<LSP<T0, T1>>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun create_pool<T0: drop, T1>(arg0: T0, arg1: 0x2::coin::Coin<T1>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LSP<T0, T1>> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v1 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0 && v1 > 0, 0);
        assert!(v0 < 1844674407370955 && v1 < 1844674407370955, 4);
        assert!(arg3 >= 0 && arg3 < 10000, 1);
        let v2 = LSP<T0, T1>{dummy_field: false};
        let v3 = 0x2::balance::create_supply<LSP<T0, T1>>(v2);
        let v4 = Pool<T0, T1>{
            id          : 0x2::object::new(arg4),
            sui         : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
            token       : 0x2::coin::into_balance<T1>(arg1),
            lsp_supply  : v3,
            fee_percent : arg3,
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v4);
        0x2::coin::from_balance<LSP<T0, T1>>(0x2::balance::increase_supply<LSP<T0, T1>>(&mut v3, 0x2::math::sqrt(v0) * 0x2::math::sqrt(v1)), arg4)
    }

    public fun get_amounts<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui), 0x2::balance::value<T1>(&arg0.token), 0x2::balance::supply_value<LSP<T0, T1>>(&arg0.lsp_supply))
    }

    public fun get_input_price(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = (arg0 as u128) * (10000 - (arg3 as u128));
        ((v0 * (arg2 as u128) / ((arg1 as u128) * 10000 + v0)) as u64)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LSP<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<LSP<T0, T1>>(&arg1);
        assert!(v0 > 0, 0);
        let (v1, v2, v3) = get_amounts<T0, T1>(arg0);
        0x2::balance::decrease_supply<LSP<T0, T1>>(&mut arg0.lsp_supply, 0x2::coin::into_balance<LSP<T0, T1>>(arg1));
        (0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui, v1 * v0 / v3, arg2), 0x2::coin::take<T1>(&mut arg0.token, v2 * v0 / v3, arg2))
    }

    entry fun remove_liquidity_<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LSP<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = remove_liquidity<T0, T1>(arg0, arg1, arg2);
        let v2 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v2);
    }

    public fun sui_price<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        let (v0, v1, _) = get_amounts<T0, T1>(arg0);
        get_input_price(arg1, v1, v0, arg0.fee_percent)
    }

    public fun swap_sui<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 0);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        let (v1, v2, _) = get_amounts<T0, T1>(arg0);
        assert!(v1 > 0 && v2 > 0, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, v0);
        0x2::coin::take<T1>(&mut arg0.token, get_input_price(0x2::balance::value<0x2::sui::SUI>(&v0), v1, v2, arg0.fee_percent), arg2)
    }

    entry fun swap_sui_<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_sui<T0, T1>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun swap_token<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::value<T1>(&arg1) > 0, 0);
        let v0 = 0x2::coin::into_balance<T1>(arg1);
        let (v1, v2, _) = get_amounts<T0, T1>(arg0);
        assert!(v1 > 0 && v2 > 0, 2);
        0x2::balance::join<T1>(&mut arg0.token, v0);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui, get_input_price(0x2::balance::value<T1>(&v0), v2, v1, arg0.fee_percent), arg2)
    }

    entry fun swap_token_<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_token<T0, T1>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun token_price<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        let (v0, v1, _) = get_amounts<T0, T1>(arg0);
        get_input_price(arg1, v0, v1, arg0.fee_percent)
    }

    // decompiled from Move bytecode v6
}

