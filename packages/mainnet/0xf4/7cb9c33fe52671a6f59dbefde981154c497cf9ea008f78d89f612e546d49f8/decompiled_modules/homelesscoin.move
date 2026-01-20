module 0xf47cb9c33fe52671a6f59dbefde981154c497cf9ea008f78d89f612e546d49f8::homelesscoin {
    struct HOMELESSCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOMELESSCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOMELESSCOIN>(arg0, 6, b"HomelessCoin", b"Homeless Sui", b"From the streets to the Moon on Sui! Join the homeless army. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0021_57dd1fd132.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOMELESSCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOMELESSCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

