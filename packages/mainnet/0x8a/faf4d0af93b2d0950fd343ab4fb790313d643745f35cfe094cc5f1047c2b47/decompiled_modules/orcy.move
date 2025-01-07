module 0x8afaf4d0af93b2d0950fd343ab4fb790313d643745f35cfe094cc5f1047c2b47::orcy {
    struct ORCY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORCY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORCY>(arg0, 6, b"ORCY", b"Orcy", x"4865792074686572652c2049276d20244f5243592120596f757220756c74696d617465206d656d6520746f6b656e2c206d616b696e6720776176657320696e20746865205355492065636f73797374656d2e204c657473206469766520696e20616e6420636f6e7175657220746865206f6365616e20746f676574686572210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Orcy_Logo_937530e699_4c9788e44c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORCY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORCY>>(v1);
    }

    // decompiled from Move bytecode v6
}

