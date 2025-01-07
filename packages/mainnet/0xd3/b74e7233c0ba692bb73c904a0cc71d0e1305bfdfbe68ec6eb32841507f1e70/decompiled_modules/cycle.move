module 0xd3b74e7233c0ba692bb73c904a0cc71d0e1305bfdfbe68ec6eb32841507f1e70::cycle {
    struct CYCLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYCLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYCLE>(arg0, 6, b"CYCLE", b"Moon Cycle", x"4d4f4f4e4359434c453a20436f6e71756572696e67207370616365206f6e2074776f20776865656c7321204d4f4f4e4359434c453a20526964696e6720612062696b6520737472616967687420746f20746865206d6f6f6e210a4d4f4f4e4359434c453a20506564616c696e6720746f20746865206d6f6f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_ead402ead5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYCLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CYCLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

