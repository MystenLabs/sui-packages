module 0x9b2b74dfbbc93fbcfa74c98a5e6ea156cabf76b055f77c7a673fa805cc370a09::despoiler {
    struct DESPOILER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DESPOILER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DESPOILER>(arg0, 9, b"despoiler", b"Abaddon the Despoiler", b"DESPOILER IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/850/131/large/alexei-konev-1.jpg?1728673719")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DESPOILER>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DESPOILER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DESPOILER>>(v1);
    }

    // decompiled from Move bytecode v6
}

