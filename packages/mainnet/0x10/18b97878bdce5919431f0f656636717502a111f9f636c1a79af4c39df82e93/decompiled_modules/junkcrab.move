module 0x1018b97878bdce5919431f0f656636717502a111f9f636c1a79af4c39df82e93::junkcrab {
    struct JUNKCRAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUNKCRAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUNKCRAB>(arg0, 9, b"JUNKCRAB", b"Junk Crab", b"JUNK CRAB IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/273/391/large/jack-yan-d.jpg?1727162902")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JUNKCRAB>(&mut v2, 30000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUNKCRAB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUNKCRAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

