module 0xe81ede6d9151103bf273a2fbdf0e7ca06f55551358f791f8b2a9c9269091a7f4::werts {
    struct WERTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WERTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WERTS>(arg0, 6, b"WERTS", b"aaaaaaaaaaaaa", b"asddasdasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Batman_65a64fbcae.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WERTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WERTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

