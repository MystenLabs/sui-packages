module 0x4cd6d57c36bf79720f2901559ee80b4429f2da47c62571fa15cfcea777f28441::kiriko {
    struct KIRIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIRIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIRIKO>(arg0, 9, b"KIRIKO", b"Lifeguard Kiriko", b"KIRIKO IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/693/058/large/nino-zorc-nion-kiriko-lifeguard-char-ingame-03.jpg?1728284174")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KIRIKO>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIRIKO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIRIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

