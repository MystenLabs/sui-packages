module 0x791defac82caf8be5bb22794ff9539a2e16a301beec5a54a797e3cb275b053da::riftwalker {
    struct RIFTWALKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIFTWALKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIFTWALKER>(arg0, 9, b"riftwalker", b"The Riftwalker", b"RIFTWALKER IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/079/872/063/large/pablo-munoz-gomez-spirit-walker-colour-closeup.jpg?1726049245")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RIFTWALKER>(&mut v2, 500000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIFTWALKER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIFTWALKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

