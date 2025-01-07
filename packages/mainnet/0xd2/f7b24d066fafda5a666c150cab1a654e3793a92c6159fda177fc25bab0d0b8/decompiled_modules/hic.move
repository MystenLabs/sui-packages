module 0xd2f7b24d066fafda5a666c150cab1a654e3793a92c6159fda177fc25bab0d0b8::hic {
    struct HIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIC>(arg0, 6, b"HIC", b"HELLOWEENINCOMING", b"prepareforparty", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5c7a4f85_1170_4b19_92a6_b2d58109cc95_6a62c4ac5a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

