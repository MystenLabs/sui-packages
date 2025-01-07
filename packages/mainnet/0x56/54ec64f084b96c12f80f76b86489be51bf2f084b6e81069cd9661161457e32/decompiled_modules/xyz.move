module 0x5654ec64f084b96c12f80f76b86489be51bf2f084b6e81069cd9661161457e32::xyz {
    struct XYZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: XYZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XYZ>(arg0, 6, b"XYZ", b"xyz", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/memene.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XYZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XYZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

