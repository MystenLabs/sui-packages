module 0x9b24701174c21258c5aa829d6de404f673752d9961ca958512259133b3191f8::yoshimitsu {
    struct YOSHIMITSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOSHIMITSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOSHIMITSU>(arg0, 9, b"YOSHIMITSU", b"Yoshimitsu", b"YOSHIMITSU IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/540/638/large/carlos-suzara-yoshimitsu-beauty-2-min.jpg?1727847477")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YOSHIMITSU>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOSHIMITSU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOSHIMITSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

