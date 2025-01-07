module 0xb5eff11290b1853badbc5bb6ce31affd7f64f022885982b6ec99799884256609::blubia {
    struct BLUBIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUBIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUBIA>(arg0, 6, b"BLUBIA", b"Blubia On Sui Network", b"In $BLUBIA, we consistently calculate billion-dollar conversions with precision, ensuring every transaction reflects our commitment to accuracy and value.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037503_c11aeb8e39.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUBIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUBIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

