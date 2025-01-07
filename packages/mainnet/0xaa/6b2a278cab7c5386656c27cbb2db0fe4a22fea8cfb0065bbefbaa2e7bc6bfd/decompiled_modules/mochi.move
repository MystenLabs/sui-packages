module 0xaa6b2a278cab7c5386656c27cbb2db0fe4a22fea8cfb0065bbefbaa2e7bc6bfd::mochi {
    struct MOCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCHI>(arg0, 6, b"Mochi", b"MOCHI", b"Mochi is a token built on the Sui network, designed to capture the spirit of community-driven fun while supporting a meaningful cause. With an adorable cat icon as its mascot, Mochi not only brings excitement to its holders but also commits to donating a portion of its transaction proceeds to cat rescue organizations and animal shelters worldwide.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241009_105813_97c35b8c33.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

