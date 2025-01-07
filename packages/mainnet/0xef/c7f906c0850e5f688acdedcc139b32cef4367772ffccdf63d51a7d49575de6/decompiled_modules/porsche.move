module 0xefc7f906c0850e5f688acdedcc139b32cef4367772ffccdf63d51a7d49575de6::porsche {
    struct PORSCHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORSCHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORSCHE>(arg0, 9, b"PORSCHE", b"PORSCHE D.VA", b"PORSCHE IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/784/060/large/pietro-trizzullo-4k-overwatch-2-char-d-va-porsche-4-1.jpg?1728497334")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PORSCHE>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORSCHE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PORSCHE>>(v1);
    }

    // decompiled from Move bytecode v6
}

