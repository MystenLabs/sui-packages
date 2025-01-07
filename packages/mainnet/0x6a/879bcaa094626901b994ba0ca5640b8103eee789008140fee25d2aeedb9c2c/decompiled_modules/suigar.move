module 0x6a879bcaa094626901b994ba0ca5640b8103eee789008140fee25d2aeedb9c2c::suigar {
    struct SUIGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGAR>(arg0, 9, b"SUIGAR", b"Suigar", b"SUIGAR IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FSUIGAR_PROFIL_b3088c58db.jpg&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIGAR>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGAR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

