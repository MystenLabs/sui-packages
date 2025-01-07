module 0xcbc0c896690d350c785f46047bb80280296c1cf10e53cb8513e3449173aac7e7::train {
    struct TRAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRAIN>(arg0, 6, b"TRAIN", b"TRAIN ON SUI", b"TRAIN ON SU CHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ergegerg_9b07d2e61d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

