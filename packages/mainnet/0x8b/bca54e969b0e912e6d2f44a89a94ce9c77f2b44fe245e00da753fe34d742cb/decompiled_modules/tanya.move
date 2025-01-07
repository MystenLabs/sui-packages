module 0x8bbca54e969b0e912e6d2f44a89a94ce9c77f2b44fe245e00da753fe34d742cb::tanya {
    struct TANYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TANYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TANYA>(arg0, 9, b"TANYA", b"Tanya", b"TANYA IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://c.nbsamara.net/sites/nbsamara.net/files/styles/width250px/public/img_6361.jpeg?itok=GvGzvExn")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TANYA>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TANYA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TANYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

