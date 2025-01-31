module 0xf111d7b74f809bfc7b050df4b1974e861fab2b2c2d4228caf62998e853ebbea0::buttcoin {
    struct BUTTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUTTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUTTCOIN>(arg0, 6, b"BUTTCOIN", b"BUTT COIN", b"The new bitcoin, on sui! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6059_2b7d055ec6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUTTCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUTTCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

