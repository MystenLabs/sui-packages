module 0x442e3107e33857d4e72f4f19226acb917c056803dc85a76c0a0e785f8699da00::ggi {
    struct GGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGI>(arg0, 6, b"GGI", b"GregoireGibier", b"The Most big Zgeg on the Ocean Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2205_a1ad0e3b46.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

