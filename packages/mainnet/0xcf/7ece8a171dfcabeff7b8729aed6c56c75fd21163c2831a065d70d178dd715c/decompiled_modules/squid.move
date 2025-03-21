module 0xcf7ece8a171dfcabeff7b8729aed6c56c75fd21163c2831a065d70d178dd715c::squid {
    struct SQUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUID>(arg0, 6, b"SQUID", b"SUISQUID", b"Welcome to the world of SuiSquid, the friendliest memecoin on the Sui Chain! SuiSquid is a unique and vibrant cryptocurrency that features a charming blue squid, symbolizing cheerfulness and community spirit. Our mission is to bring a wave of fun and excitement to the crypto space while fostering a sense of camaraderie among our holders. With SuiSquid, every transaction feels like a playful splash in the ocean of possibilities. Join our growing school of SuiSquid enthusiasts and dive into a sea of innovative opportunities and delightful rewards. Let's make waves together with SuiSquid!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suisquid_040ecd39ea.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUID>>(v1);
    }

    // decompiled from Move bytecode v6
}

