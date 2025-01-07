module 0x3353f67a3f762c977e158fa1b60f7128d1559887f88a41ba8e12c401849a459b::dolim {
    struct DOLIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLIM>(arg0, 9, b"dolim", b"Dolim Girl", b"DOLIM IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/443/452/large/dohyun-park-highresscreenshot00332.jpg?1727607899")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOLIM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLIM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

