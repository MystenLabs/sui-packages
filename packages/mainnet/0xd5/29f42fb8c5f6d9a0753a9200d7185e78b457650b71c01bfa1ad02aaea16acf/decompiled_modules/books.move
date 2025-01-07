module 0xd529f42fb8c5f6d9a0753a9200d7185e78b457650b71c01bfa1ad02aaea16acf::books {
    struct BOOKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOKS>(arg0, 6, b"Books", b"Book of Trump", b"First Book of Trump on sui Win today With Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9117_eae3737de5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

