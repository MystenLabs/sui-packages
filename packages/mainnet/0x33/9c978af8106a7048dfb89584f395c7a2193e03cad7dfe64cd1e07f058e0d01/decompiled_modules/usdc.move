module 0x339c978af8106a7048dfb89584f395c7a2193e03cad7dfe64cd1e07f058e0d01::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<USDC>(arg0, 6, b"T_USDC", b"USDC Test", b"USDC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/3408.png")), true, arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDC>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<USDC>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<T0>(arg0, arg1, arg2, arg3);
    }

    public fun pause<T0>(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_enable_global_pause<T0>(arg0, arg1, arg2);
    }

    public fun unpause<T0>(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_disable_global_pause<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

