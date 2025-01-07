module 0x6db4c51574567c0c3307621e9c4dcf11b26c1990316b5c65f9e852cc90d4989a::capt {
    struct CAPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPT>(arg0, 6, b"CAPT", b"CAPTWIN PEPE", b"This token is on a mission, no dev, just pure drive and community power. Get in early, the Captwin is charting a course to the moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ACCB_9_E97_3_DD_7_49_A8_9_E37_AA_4_E51_FF_2811_15959c704a.WEBP")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

