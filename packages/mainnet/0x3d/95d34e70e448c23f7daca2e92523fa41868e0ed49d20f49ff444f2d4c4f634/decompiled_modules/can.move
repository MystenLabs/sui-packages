module 0x3d95d34e70e448c23f7daca2e92523fa41868e0ed49d20f49ff444f2d4c4f634::can {
    struct CAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAN>(arg0, 6, b"Can", b"Jacky", b"If anyone can Jacky can can ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016222_90d97a6b35.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

