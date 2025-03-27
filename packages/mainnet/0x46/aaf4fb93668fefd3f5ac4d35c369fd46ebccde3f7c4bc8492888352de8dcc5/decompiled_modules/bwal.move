module 0x46aaf4fb93668fefd3f5ac4d35c369fd46ebccde3f7c4bc8492888352de8dcc5::bwal {
    struct BWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWAL>(arg0, 6, b"BWAL", b"Baby Walrus", b"Welcome to the next generation of memes. The most secure, efficient, and cute baby Walrus ever to launch on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_03_27_01_26_00_dbfd820419.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

