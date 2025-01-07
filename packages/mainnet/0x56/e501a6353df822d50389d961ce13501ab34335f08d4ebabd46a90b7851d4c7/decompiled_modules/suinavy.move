module 0x56e501a6353df822d50389d961ce13501ab34335f08d4ebabd46a90b7851d4c7::suinavy {
    struct SUINAVY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINAVY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINAVY>(arg0, 6, b"SUINAVY", b"SuiNAVY", b"The first Naval force on the Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000660_a7412e80ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINAVY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINAVY>>(v1);
    }

    // decompiled from Move bytecode v6
}

