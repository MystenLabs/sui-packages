module 0x4c6859a4c48deda02efcacaec8135e167fe807c0562167d920d475194e942b26::suilaam {
    struct SUILAAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILAAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILAAM>(arg0, 6, b"SUILAAM", b"Suilaam Waleykum", b"The ghost of Osama lives, wandering the NY streets. Hentai Maxi. Boom!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_05_03_26_57_4e86a6ce65.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILAAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILAAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

