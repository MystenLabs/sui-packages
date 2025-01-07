module 0x56623efc3ddc433bafec3067ce9354956df18fdf9701625b6cb61a8662038197::suitoro {
    struct SUITORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITORO>(arg0, 9, b"Suitoro", b"Suitoro", b"SUITORO IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FSuitoro_twitter_profile_a1460d11c2.png&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUITORO>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITORO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITORO>>(v1);
    }

    // decompiled from Move bytecode v6
}

