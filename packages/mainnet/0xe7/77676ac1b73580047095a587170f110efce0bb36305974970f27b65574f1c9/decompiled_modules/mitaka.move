module 0xe777676ac1b73580047095a587170f110efce0bb36305974970f27b65574f1c9::mitaka {
    struct MITAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MITAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MITAKA>(arg0, 9, b"MITAKA", b"Asa Mitaka", b"MITAKA IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/667/715/large/marcel-werder-asa-env04.jpg?1728208821")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MITAKA>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MITAKA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MITAKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

