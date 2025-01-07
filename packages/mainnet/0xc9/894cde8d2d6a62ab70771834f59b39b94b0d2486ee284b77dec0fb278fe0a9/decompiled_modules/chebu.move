module 0xc9894cde8d2d6a62ab70771834f59b39b94b0d2486ee284b77dec0fb278fe0a9::chebu {
    struct CHEBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEBU>(arg0, 6, b"CHEBU", b"CHEBUBEARS", b"The $CHEBU cult needs fresh blood! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5481_c53e10f08f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

