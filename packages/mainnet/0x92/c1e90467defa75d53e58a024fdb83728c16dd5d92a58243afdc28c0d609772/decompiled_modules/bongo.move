module 0x92c1e90467defa75d53e58a024fdb83728c16dd5d92a58243afdc28c0d609772::bongo {
    struct BONGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONGO>(arg0, 6, b"BONGO", b"Bongo Cat", x"57656c636f6d6520746f20426f6e676f20436174200a4a6f696e206f7572204d616769632042616e64210a0a424f4e474f204341542048454144454420464f52204d494c4c494f4e53", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_08_21_04_16_23_9b533fae08.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

