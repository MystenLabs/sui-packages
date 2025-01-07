module 0x3e2910e58c49348b83615881e2241c08303b05994c3accebbaa37bd7be8ff3d2::willy {
    struct WILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILLY>(arg0, 6, b"WILLY", b"WILLY ON SUI", b"\"Willy\" is a fun and vibrant memecoin on the Sui network, symbolized by a colorful whale adorned with quirky and whimsical objects. This playful mascot captures attention with its lively design, making it an ideal representation of a community-driven token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WILLY_1ba61c885f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

