module 0xca0297d609f984fba0f77c9446f4927aeb0e4fc6f8a596068a484b1d5d16935e::wukong {
    struct WUKONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUKONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUKONG>(arg0, 6, b"WUKONG", b"WUKONG ON SUI!", b"$WUKONG is a powerful token on Sui, inspired by the legendary Monkey King, Wukong. With unmatched strength, speed, and wisdom, $WUKONG aims to conquer the Sui realm, just as the Monkey King rules the skies and the earth. Join the adventure and harness the power of $WUKONG!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WUKONG_e64865a41a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUKONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUKONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

