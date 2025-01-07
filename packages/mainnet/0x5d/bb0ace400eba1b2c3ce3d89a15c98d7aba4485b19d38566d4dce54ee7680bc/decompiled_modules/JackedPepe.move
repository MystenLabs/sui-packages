module 0x5dbb0ace400eba1b2c3ce3d89a15c98d7aba4485b19d38566d4dce54ee7680bc::JackedPepe {
    struct JACKEDPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JACKEDPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JACKEDPEPE>(arg0, 6, b"JACKEDPEPE", b"JACKEDPEPE", b"JackedPepe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JACKEDPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JACKEDPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

