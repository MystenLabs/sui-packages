module 0x6f013d406d46026358dabd0a1071f97e4d6fde64b24d23472e56198f22df4fb7::suick {
    struct SUICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICK>(arg0, 9, b"SUICK", b"Suck Sui Token", b"DEMONIC IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://thumbs.dreamstime.com/b/pop-art-pin-up-young-sexy-punk-girl-sucks-lollipop-vector-illustration-heart-90309761.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

