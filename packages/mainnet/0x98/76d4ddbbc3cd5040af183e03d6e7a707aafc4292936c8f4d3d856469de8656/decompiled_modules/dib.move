module 0x9876d4ddbbc3cd5040af183e03d6e7a707aafc4292936c8f4d3d856469de8656::dib {
    struct DIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIB>(arg0, 6, b"DIB", b"duckinbag", x"796f7520666f72676f7420796f75722062616720616761696e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GP_36_Viabs_A_Aip_Ok_1_54c5713202.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

