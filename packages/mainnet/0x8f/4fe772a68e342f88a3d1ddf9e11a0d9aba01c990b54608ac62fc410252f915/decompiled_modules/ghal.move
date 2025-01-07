module 0x8f4fe772a68e342f88a3d1ddf9e11a0d9aba01c990b54608ac62fc410252f915::ghal {
    struct GHAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHAL>(arg0, 6, b"GHAL", b"Ghost Halloween", x"47686f73742048616c6c6f7765656e20244748414c20636f6d696e6720746f205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730955570816.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GHAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

