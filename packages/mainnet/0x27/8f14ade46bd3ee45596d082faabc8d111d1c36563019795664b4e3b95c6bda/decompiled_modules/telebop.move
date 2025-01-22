module 0x278f14ade46bd3ee45596d082faabc8d111d1c36563019795664b4e3b95c6bda::telebop {
    struct TELEBOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TELEBOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TELEBOP>(arg0, 6, b"TELEBOP", b"TELEBOP AI SUI", b"TELEBOP, built on the SUI network, is a groundbreaking crypto coin that combines blockchain innovation with a personalized virtual girlfriend experience. Offering interactive companionship, customizable features, and gamified engagement, TELEBOP merges technology with entertainment in a seamless and fun way. Designed for speed, scalability, and affordability, TELEBOP brings a unique touch to the world of digital assets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250122_161244_988_79a917872e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TELEBOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TELEBOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

