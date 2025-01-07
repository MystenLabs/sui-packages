module 0xb5bffdb2d6d04ab2a70d5b3b9ccc3858202af5b12a7e164f13ff7c3ca1a990bd::dogat {
    struct DOGAT has drop {
        dummy_field: bool,
    }

    public fun add_addr_to_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DOGAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<DOGAT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: DOGAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<DOGAT>(arg0, 9, b"doge cat", b"DOGAT", x"e2809c536f20736f6d656f6e6520746f6c64206d652049206861766520746865206361742076657273696f6e206f662074686520646f6765206d656d65e2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/5pQSTDfeUppb6tV415RWygL8n3ctyakBTV7QzBn5pump.png?size=xl&key=578d76")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<DOGAT>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGAT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGAT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DOGAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DOGAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<DOGAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

