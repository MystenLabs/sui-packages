module 0x28965f6c6b78af642c1f3d69471cea93df30e5627620905a2d4f4a1c5958be0d::loperi {
    struct LOPERI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOPERI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOPERI>(arg0, 9, b"LOPERI", b"Loperi", b"LOPERI IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/628/431/large/james-hyun-final-close-3a.jpg?1728065450")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LOPERI>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOPERI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOPERI>>(v1);
    }

    // decompiled from Move bytecode v6
}

