module 0xd01bc77cd283420e33a39450662dc6cedb18227f1072df57a351d0e9bf9c34b7::ofish {
    struct OFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: OFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OFISH>(arg0, 6, b"OFISH", b"Filet-O-Fish", b"The ultimate memecoin tribute to the legendary Filet-O-Fish!  In memory of all the brave fish who were sacrificed, breaded, and deliciously fried to satisfy our cravings, $OFISH stands as a symbol of their savory legacy. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/We_are_live_at_Movepump_5_9eed05bf9f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

