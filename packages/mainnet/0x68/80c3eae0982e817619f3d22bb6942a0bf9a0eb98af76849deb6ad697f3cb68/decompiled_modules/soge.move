module 0x6880c3eae0982e817619f3d22bb6942a0bf9a0eb98af76849deb6ad697f3cb68::soge {
    struct SOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOGE>(arg0, 6, b"SOGE", b"Sui Soge", b"Born in a lab on Sui, SOGE is the genetic clone of DOGE with a blue twist.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cropped_logo_boge_300x300_e7733cb47b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

