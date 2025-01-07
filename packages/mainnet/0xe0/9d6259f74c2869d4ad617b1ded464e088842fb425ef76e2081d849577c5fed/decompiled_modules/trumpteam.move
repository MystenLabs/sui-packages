module 0xe09d6259f74c2869d4ad617b1ded464e088842fb425ef76e2081d849577c5fed::trumpteam {
    struct TRUMPTEAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPTEAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPTEAM>(arg0, 6, b"TRUMPTEAM", b"TEAM SUI TRUMP", b"Be part of this victorious team!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pixlr_image_generator_c0b0b7ad_6569_4b51_a034_a68effce33b1_70c41a7320.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPTEAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPTEAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

