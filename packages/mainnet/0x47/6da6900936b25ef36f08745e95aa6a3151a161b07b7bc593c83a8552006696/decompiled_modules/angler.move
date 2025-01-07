module 0x476da6900936b25ef36f08745e95aa6a3151a161b07b7bc593c83a8552006696::angler {
    struct ANGLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGLER>(arg0, 6, b"ANGLER", b"SUI ANGLER", b"ANGLER is the token swimming in the deep waters of the SUI ecosystem, designed for those who aren't afraid to cast their nets wide!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_20_22_24_9c8597ebe7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANGLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

