module 0xa59aa27c7cee362ced1db0fb7b2b375e7101637ec5db7ec15a9e0e1b88aae5d7::etst {
    struct ETST has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETST>(arg0, 9, b"ETST", b"test", b"asdas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Test-Logo.svg/1200px-Test-Logo.svg.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ETST>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETST>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETST>>(v1);
    }

    // decompiled from Move bytecode v6
}

