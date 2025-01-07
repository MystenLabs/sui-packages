module 0x1fb841c335661ab8e64dbd5c6092acb025cdae3d8fe77c60a6c990e7e051506::beth {
    struct BETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BETH>(arg0, 6, b"BETH", b"BeethovenAI", b"$BETH  | Transforming $SUI charts into Beethoven-inspired symphonies.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2025_01_06_11_50_14_875da5afa8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BETH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BETH>>(v1);
    }

    // decompiled from Move bytecode v6
}

