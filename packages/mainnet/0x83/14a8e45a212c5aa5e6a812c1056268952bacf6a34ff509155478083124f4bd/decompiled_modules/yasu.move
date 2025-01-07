module 0x8314a8e45a212c5aa5e6a812c1056268952bacf6a34ff509155478083124f4bd::yasu {
    struct YASU has drop {
        dummy_field: bool,
    }

    fun init(arg0: YASU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YASU>(arg0, 9, b"YASU", b"Ton Yasu", b"YASU IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/848/549/large/toh-yasu-20241013.jpg?1728669833")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YASU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YASU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YASU>>(v1);
    }

    // decompiled from Move bytecode v6
}

