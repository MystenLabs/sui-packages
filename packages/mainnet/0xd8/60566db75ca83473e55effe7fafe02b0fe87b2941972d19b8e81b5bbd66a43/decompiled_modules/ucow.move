module 0xd860566db75ca83473e55effe7fafe02b0fe87b2941972d19b8e81b5bbd66a43::ucow {
    struct UCOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: UCOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UCOW>(arg0, 6, b"UCOW", b"Ugly cow", b"The bull market is booming", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/003_a4ce4f0144.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UCOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UCOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

