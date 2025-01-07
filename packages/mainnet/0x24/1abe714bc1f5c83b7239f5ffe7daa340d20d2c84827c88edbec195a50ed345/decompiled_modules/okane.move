module 0x241abe714bc1f5c83b7239f5ffe7daa340d20d2c84827c88edbec195a50ed345::okane {
    struct OKANE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKANE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OKANE>(arg0, 6, b"OKANE", b"OKANE SUI", b"2021 Vibes, Community, Friends and $Okane (Money). The Vibe is what its all about, Come hang out and chill with the $Okane Gang. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_01_at_00_53_17_2e7d069f_a88a24f701.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OKANE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OKANE>>(v1);
    }

    // decompiled from Move bytecode v6
}

