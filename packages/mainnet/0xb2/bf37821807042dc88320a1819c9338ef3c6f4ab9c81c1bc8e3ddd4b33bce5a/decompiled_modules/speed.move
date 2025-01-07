module 0xb2bf37821807042dc88320a1819c9338ef3c6f4ab9c81c1bc8e3ddd4b33bce5a::speed {
    struct SPEED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEED>(arg0, 6, b"SPEED", b"ISUISPEED", x"4e554d424552204f4e4520435249535449414e4f20524f4e414c444f2046414e53204c4f5645205355492021212121212121210a435249535449414e4f20524f4e414c444f205345575920212121210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/speed_1_6aad835c8a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPEED>>(v1);
    }

    // decompiled from Move bytecode v6
}

