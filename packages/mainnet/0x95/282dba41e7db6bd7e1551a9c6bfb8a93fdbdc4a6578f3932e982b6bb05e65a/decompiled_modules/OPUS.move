module 0x95282dba41e7db6bd7e1551a9c6bfb8a93fdbdc4a6578f3932e982b6bb05e65a::OPUS {
    struct OPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<OPUS>(arg0, 2, b"OPUS", b"OPUS", b"OPUS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/-cK5r2j2MkdiFoHSy9rnEJOvpIVtHn9MckfeVmtZIAg?ext=png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OPUS>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<OPUS>>(v1, @0x8bcc0e6cadf05f36018b1dff59d669b358a5aad6e5d05ad00bda60873cf0cb5c);
        let v3 = v0;
        0x2::coin::mint_and_transfer<OPUS>(&mut v3, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPUS>>(v3, 0x2::tx_context::sender(arg1));
    }

    entry fun migrate_regulated_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<OPUS>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<OPUS>(arg0, v1)) {
                0x2::coin::deny_list_add<OPUS>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

