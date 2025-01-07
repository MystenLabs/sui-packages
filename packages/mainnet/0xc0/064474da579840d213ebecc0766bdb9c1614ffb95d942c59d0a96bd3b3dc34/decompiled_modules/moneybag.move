module 0xc0064474da579840d213ebecc0766bdb9c1614ffb95d942c59d0a96bd3b3dc34::moneybag {
    struct MONEYBAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONEYBAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONEYBAG>(arg0, 9, b"MONEYBAG", b"Money Bag", b"MONEYBAG IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/893/320/large/danil-mishatkin-color.jpg?1728834863")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MONEYBAG>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONEYBAG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONEYBAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

