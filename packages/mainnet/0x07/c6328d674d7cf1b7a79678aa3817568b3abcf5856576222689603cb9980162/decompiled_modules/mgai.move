module 0x7c6328d674d7cf1b7a79678aa3817568b3abcf5856576222689603cb9980162::mgai {
    struct MGAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MGAI>(arg0, 6, b"MGAI", b"Massive Gains AI", b"Massive Gains AI ($MGAI) is a next-gen Sui memecoin blending AI hype with unstoppable gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738415263179.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MGAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

