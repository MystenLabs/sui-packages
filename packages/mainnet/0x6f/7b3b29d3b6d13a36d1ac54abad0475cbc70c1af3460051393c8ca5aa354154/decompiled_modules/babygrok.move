module 0x6f7b3b29d3b6d13a36d1ac54abad0475cbc70c1af3460051393c8ca5aa354154::babygrok {
    struct BABYGROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYGROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BABYGROK>(arg0, 9, b"Baby Grok", b"BabyGrok", b"One Of the best memes on BSC, Strong team behind", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BABYGROK>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYGROK>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYGROK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BABYGROK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

