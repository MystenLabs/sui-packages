module 0xa25a0664b1f06e18e8eb244cbd57397f722be662b1a718ecb280ee45096c380::pugs {
    struct PUGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGS>(arg0, 6, b"PUGS", b"PUGS ON SUI", b"Finding my home...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_06_20_42_42_61c49122bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

