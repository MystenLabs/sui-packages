module 0xc5a7e3c4eeb4ac1de7edfe84b44dc4babd5ba3f0f5c66bf38c089f3614ee44bc::itirnino {
    struct ITIRNINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITIRNINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ITIRNINO>(arg0, 9, b"ITIRNINO", b"Itirnino Guardian of the Desert Salamander Eggs", b"ITIRNINO IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/079/053/828/large/marcus-rovn-1.jpg?1723823204")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ITIRNINO>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITIRNINO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ITIRNINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

