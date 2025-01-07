module 0x4869d7ac29b52ced54730764f3e073e2c43932f5cbdf4509a6a72cd1360559ce::sonicdrippy {
    struct SONICDRIPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONICDRIPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONICDRIPPY>(arg0, 6, b"SonicDrippy", b"Sonic Drippy on Sui", b"SonnyDrippy is an innovative project built on the Sui blockchain, combining cutting-edge technology with a user-friendly ecosystem to deliver decentralized solutions. SonnyDrippy aims to revolutionize the way users interact with blockchain technology, offering secure and fast transactions, unique digital assets", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7310_10c59c3432.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONICDRIPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SONICDRIPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

