module 0x7dd59e29449585183bc6d22d520d39a092af80455c5ddc0bfa4e59a1074db1ab::oggy {
    struct OGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGGY>(arg0, 6, b"OGGY", b"Sui Oggy", x"4f4747592048454c4c4f2054484520574f524c440a57656c636f6d6520746f204f676779206120636f6d6d756e6974792064726976656e2070726f6a6563740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241009_234555_3cf53ac7e0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

