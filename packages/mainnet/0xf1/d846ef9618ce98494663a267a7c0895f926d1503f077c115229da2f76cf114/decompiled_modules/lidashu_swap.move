module 0xf1d846ef9618ce98494663a267a7c0895f926d1503f077c115229da2f76cf114::lidashu_swap {
    struct LSP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct LidashuPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        ratio_base: u64,
        ratio_quote: u64,
        lsp_supply: 0x2::balance::Supply<LSP<T0, T1>>,
        base_balance: 0x2::balance::Balance<T0>,
        quote_balance: 0x2::balance::Balance<T1>,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut LidashuPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let v1 = 0x2::coin::into_balance<T1>(arg2);
        0x2::balance::join<T0>(&mut arg0.base_balance, v0);
        0x2::balance::join<T1>(&mut arg0.quote_balance, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<LSP<T0, T1>>>(0x2::coin::from_balance<LSP<T0, T1>>(0x2::balance::increase_supply<LSP<T0, T1>>(&mut arg0.lsp_supply, (0x2::balance::value<T0>(&v0) / arg0.ratio_base + 0x2::balance::value<T1>(&v1) / arg0.ratio_quote) / 2), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun create_pool<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = LSP<T0, T1>{dummy_field: false};
        let v1 = 0x2::balance::create_supply<LSP<T0, T1>>(v0);
        let v2 = LidashuPool<T0, T1>{
            id            : 0x2::object::new(arg4),
            ratio_base    : arg2,
            ratio_quote   : arg3,
            lsp_supply    : v1,
            base_balance  : 0x2::coin::into_balance<T0>(arg0),
            quote_balance : 0x2::coin::into_balance<T1>(arg1),
        };
        0x2::transfer::share_object<LidashuPool<T0, T1>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<LSP<T0, T1>>>(0x2::coin::from_balance<LSP<T0, T1>>(0x2::balance::increase_supply<LSP<T0, T1>>(&mut v1, (0x2::coin::value<T0>(&arg0) / arg2 + 0x2::coin::value<T1>(&arg1) / arg3) / 2), arg4), 0x2::tx_context::sender(arg4));
    }

    public fun remove_liquidity_inner<T0, T1>(arg0: &mut LidashuPool<T0, T1>, arg1: 0x2::coin::Coin<LSP<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<LSP<T0, T1>>(&arg1);
        0x2::balance::decrease_supply<LSP<T0, T1>>(&mut arg0.lsp_supply, 0x2::coin::into_balance<LSP<T0, T1>>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.base_balance, v0 * arg0.ratio_base, arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.quote_balance, v0 * arg0.ratio_quote, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun swap_base<T0, T1>(arg0: &mut LidashuPool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.base_balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, arg2, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.quote_balance, arg2 * arg0.ratio_quote / arg0.ratio_base, arg3), 0x2::tx_context::sender(arg3));
    }

    public fun swap_quote<T0, T1>(arg0: &mut LidashuPool<T0, T1>, arg1: &mut 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T1>(&mut arg0.quote_balance, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg1, arg2, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.base_balance, arg2 * arg0.ratio_base / arg0.ratio_quote, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

