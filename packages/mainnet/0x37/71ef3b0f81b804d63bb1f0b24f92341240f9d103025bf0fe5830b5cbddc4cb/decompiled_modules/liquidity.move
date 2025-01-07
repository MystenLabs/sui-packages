module 0x3771ef3b0f81b804d63bb1f0b24f92341240f9d103025bf0fe5830b5cbddc4cb::liquidity {
    struct LP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        coin_x: 0x2::balance::Balance<T0>,
        coin_y: 0x2::balance::Balance<T1>,
        lsp_supply: 0x2::balance::Supply<LP<T0, T1>>,
        fee_percent: u64,
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = add_liquidity_inner<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<LP<T0, T1>>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun add_liquidity_inner<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LP<T0, T1>> {
        assert!(0x2::coin::value<T0>(&arg1) > 0 && 0x2::coin::value<T1>(&arg2) > 0, 0);
        let (v0, v1, v2) = get_amounts<T0, T1>(arg0);
        assert!(v0 > 0 && v1 > 0, 2);
        let v3 = 0x2::coin::into_balance<T0>(arg1);
        let v4 = 0x2::coin::into_balance<T1>(arg2);
        assert!(0x2::balance::join<T0>(&mut arg0.coin_x, v3) < 1844674407370955 && 0x2::balance::join<T1>(&mut arg0.coin_y, v4) < 1844674407370955, 4);
        0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lsp_supply, 0x2::math::min(0x2::balance::value<T0>(&v3) * v2 / v0, 0x2::balance::value<T1>(&v4) * v2 / v1)), arg3)
    }

    public fun calcualte_output_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = (arg1 as u128);
        let v1 = (arg2 as u128);
        ((v1 - v0 * v1 / (v0 + (arg0 as u128) * 10000 / (10000 - (arg3 as u128)))) as u64)
    }

    public fun create_pool_inner<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LP<T0, T1>> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0 && v1 > 0, 0);
        assert!(v0 < 1844674407370955 && v1 < 1844674407370955, 4);
        let v2 = LP<T0, T1>{dummy_field: false};
        let v3 = 0x2::balance::create_supply<LP<T0, T1>>(v2);
        let v4 = Pool<T0, T1>{
            id          : 0x2::object::new(arg2),
            coin_x      : 0x2::coin::into_balance<T0>(arg0),
            coin_y      : 0x2::coin::into_balance<T1>(arg1),
            lsp_supply  : v3,
            fee_percent : (30 as u64),
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v4);
        0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::increase_supply<LP<T0, T1>>(&mut v3, 0x2::math::sqrt(v0) * 0x2::math::sqrt(v1)), arg2)
    }

    public fun get_amounts<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.coin_x), 0x2::balance::value<T1>(&arg0.coin_y), 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lsp_supply))
    }

    public fun new_pool<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = create_pool_inner<T0, T1>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<LP<T0, T1>>>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = remove_liquidity_inner<T0, T1>(arg0, arg1, arg2);
        let v2 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v2);
    }

    public fun remove_liquidity_inner<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<LP<T0, T1>>(&arg1);
        assert!(v0 > 0, 0);
        let (v1, v2, v3) = get_amounts<T0, T1>(arg0);
        0x2::balance::decrease_supply<LP<T0, T1>>(&mut arg0.lsp_supply, 0x2::coin::into_balance<LP<T0, T1>>(arg1));
        (0x2::coin::take<T0>(&mut arg0.coin_x, v1 * v0 / v3, arg2), 0x2::coin::take<T1>(&mut arg0.coin_y, v2 * v0 / v3, arg2))
    }

    public fun sell_token_a<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        let (v0, v1, _) = get_amounts<T0, T1>(arg0);
        calcualte_output_amount(arg1, v0, v1, arg0.fee_percent)
    }

    public fun sell_token_b<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        let (v0, v1, _) = get_amounts<T0, T1>(arg0);
        calcualte_output_amount(arg1, v1, v0, arg0.fee_percent)
    }

    public entry fun swap_a_to_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_a_to_b_inner<T0, T1>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun swap_a_to_b_inner<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 0);
        let (v0, v1, _) = get_amounts<T0, T1>(arg0);
        assert!(v0 > 0 && v1 > 0, 2);
        0x2::balance::join<T0>(&mut arg0.coin_x, 0x2::coin::into_balance<T0>(arg1));
        0x2::coin::take<T1>(&mut arg0.coin_y, sell_token_a<T0, T1>(arg0, v0), arg2)
    }

    entry fun swap_b_to_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_b_to_a_inner<T0, T1>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    fun swap_b_to_a_inner<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T1>(&arg1) > 0, 0);
        let (v0, v1, _) = get_amounts<T0, T1>(arg0);
        assert!(v0 > 0 && v1 > 0, 2);
        0x2::balance::join<T1>(&mut arg0.coin_y, 0x2::coin::into_balance<T1>(arg1));
        0x2::coin::take<T0>(&mut arg0.coin_x, sell_token_b<T0, T1>(arg0, v1), arg2)
    }

    // decompiled from Move bytecode v6
}

