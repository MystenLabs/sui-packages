module 0xa720665d19e158ce7f5361cbef2f1db2632b1e22955807c587308273183e6ba8::pzq {
    struct LSP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        token_a: 0x2::balance::Balance<T0>,
        token_b: 0x2::balance::Balance<T1>,
        lsp_supply: 0x2::balance::Supply<LSP<T0, T1>>,
    }

    entry fun create_pool<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = create_pool_inner<T0, T1>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<LSP<T0, T1>>>(v0, 0x2::tx_context::sender(arg2));
    }

    fun create_pool_inner<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LSP<T0, T1>> {
        let v0 = LSP<T0, T1>{dummy_field: false};
        let v1 = 0x2::balance::create_supply<LSP<T0, T1>>(v0);
        let v2 = Pool<T0, T1>{
            id         : 0x2::object::new(arg2),
            token_a    : 0x2::coin::into_balance<T0>(arg0),
            token_b    : 0x2::coin::into_balance<T1>(arg1),
            lsp_supply : v1,
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v2);
        0x2::coin::from_balance<LSP<T0, T1>>(0x2::balance::increase_supply<LSP<T0, T1>>(&mut v1, 0x2::math::sqrt(0x2::coin::value<T0>(&arg0)) * 0x2::math::sqrt(0x2::coin::value<T1>(&arg1))), arg2)
    }

    public fun get_amounts<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.token_a), 0x2::balance::value<T1>(&arg0.token_b), 0x2::balance::supply_value<LSP<T0, T1>>(&arg0.lsp_supply))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    entry fun swap_a_to_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_a_to_b_inner<T0, T1>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg2));
    }

    fun swap_a_to_b_inner<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 0);
        0x2::balance::join<T0>(&mut arg0.token_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::coin::take<T1>(&mut arg0.token_b, 1, arg2)
    }

    entry fun swap_b_to_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_b_to_a_inner<T0, T1>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    fun swap_b_to_a_inner<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::balance::join<T1>(&mut arg0.token_b, 0x2::coin::into_balance<T1>(arg1));
        0x2::coin::take<T0>(&mut arg0.token_a, 1, arg2)
    }

    // decompiled from Move bytecode v6
}

