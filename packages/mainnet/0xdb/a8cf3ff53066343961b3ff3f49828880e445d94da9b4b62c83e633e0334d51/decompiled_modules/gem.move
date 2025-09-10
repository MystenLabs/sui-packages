module 0xdba8cf3ff53066343961b3ff3f49828880e445d94da9b4b62c83e633e0334d51::gem {
    struct GEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<GEM>(arg0, 9, b"T_GEM", b"GEM", b"GEM Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/2537.png")), true, arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEM>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<GEM>>(v1, 0x2::tx_context::sender(arg1));
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

