module 0xf56b143d887525e16685b58e60baced18836ef0576f0737d7d96e661a4b06c68::kings {
    struct KINGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGS>(arg0, 6, b"KINGS", b"Sui king", b"King sui haakfnd fcsadkfsdm, fdmlsf sdmfndsm fdsmsf sdlnsdm fsdm ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suidog_2b84630343.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KINGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

