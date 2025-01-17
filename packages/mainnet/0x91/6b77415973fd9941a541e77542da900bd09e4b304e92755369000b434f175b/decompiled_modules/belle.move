module 0x916b77415973fd9941a541e77542da900bd09e4b304e92755369000b434f175b::belle {
    struct BELLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELLE>(arg0, 6, b"BELLE", b"Belle AI", x"6669727374204149206d6f64656c206f6e205375692e204175746f6d617465642062792041692c207365787920616e642075736566756c2c2077697468206120737562736372697074696f6e20746f206275726e206d6f64656c2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737145392282.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BELLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

