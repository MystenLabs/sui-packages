module 0xa5d744806e462e1078794fa8ab8ac823362448a033f18af026d40fe77c8b7aec::bigred {
    struct BIGRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGRED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGRED>(arg0, 9, b"bigred", b"Big Red", b"BIGRED IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/603/851/large/adam-baines-scribsbots3a.jpg?1727996365")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BIGRED>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGRED>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIGRED>>(v1);
    }

    // decompiled from Move bytecode v6
}

