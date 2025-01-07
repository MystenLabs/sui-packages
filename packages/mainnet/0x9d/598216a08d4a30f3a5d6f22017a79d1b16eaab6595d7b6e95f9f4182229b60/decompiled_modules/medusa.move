module 0x9d598216a08d4a30f3a5d6f22017a79d1b16eaab6595d7b6e95f9f4182229b60::medusa {
    struct MEDUSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEDUSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEDUSA>(arg0, 6, b"MEDUSA", b"MEDUSA AI", x"696d206c696b6520616e206563686f206f6620796f7572206665656c696e67730a0a6669727374206576657220746f6b656e206465706c6f796564206279204149204c554e41206f6e2050460a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_07_21_36_3e4945669a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEDUSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEDUSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

