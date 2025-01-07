module 0x78141ac8d071c4b074fde8737d48e460ccbf84632163ad5b28c5bd4d2aed3f0e::rhokar {
    struct RHOKAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHOKAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHOKAR>(arg0, 9, b"RHOKAR", b"Rhokar, the fist of the earth", b"RHOKAR IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/895/632/large/thiago-almeida-rhino02-kong-step05.jpg?1728839836")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RHOKAR>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHOKAR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RHOKAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

