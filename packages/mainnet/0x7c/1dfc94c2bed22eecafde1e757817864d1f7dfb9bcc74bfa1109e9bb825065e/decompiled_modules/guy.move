module 0x7c1dfc94c2bed22eecafde1e757817864d1f7dfb9bcc74bfa1109e9bb825065e::guy {
    struct GUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUY>(arg0, 9, b"GUY", b"Guy", b"GUY IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/864/535/large/nkta-photo-2024-10-12-14-07-30.jpg?1728731516")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GUY>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

