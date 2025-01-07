module 0x82a99aa5400af1269ce846ccc261d4052f44fb4514dc4fa2d6b2806bf5352330::tweeterhead {
    struct TWEETERHEAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWEETERHEAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWEETERHEAD>(arg0, 9, b"TWEETERHEAD", b"Sorceress Legends - Tweeterhead", b"TWEETERHEAD IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/826/666/large/tiago-zenobini-tweeterhex-sorceress-gallery-final-13-branded-scaled.jpg?1728606458")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TWEETERHEAD>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWEETERHEAD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWEETERHEAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

