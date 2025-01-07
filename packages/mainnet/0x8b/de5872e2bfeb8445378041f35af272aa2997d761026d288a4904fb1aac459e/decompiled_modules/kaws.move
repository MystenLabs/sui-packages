module 0x8bde5872e2bfeb8445378041f35af272aa2997d761026d288a4904fb1aac459e::kaws {
    struct KAWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAWS>(arg0, 6, b"KAWS", b"The Kaws Club", b"Meet $KAWS, the cornerstone of the Kaws Club, a thriving crypto community! Kaws Club is more than just a token; it's a vibrant ecosystem where members can engage in Play-to-Earn gaming, access exclusive NFT collections", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_16_at_17_40_07_fe38d65d2a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

