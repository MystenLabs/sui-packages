module 0x8ac367864529f12280b9f8f018bf17abc945855db7beb2ead9bf4c9d62a78605::suipiens {
    struct SUIPIENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPIENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPIENS>(arg0, 9, b"SUIPIENS", b"Suipiens Token", b"SUIPIENS IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipiens.com/images/logo/main_logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIPIENS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPIENS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPIENS>>(v1);
    }

    // decompiled from Move bytecode v6
}

