module 0xf205c925e3fa18dec73adecc9fecbaa6f886d9eeccf3addd4a4c94ca618865a7::onekill {
    struct ONEKILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONEKILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONEKILL>(arg0, 9, b"onekill", b"One Hit One KIll", b"ONEKILL IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/591/763/large/tony-silva-robotgirl-pose2-half.jpg?1727971088")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ONEKILL>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONEKILL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONEKILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

