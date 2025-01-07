module 0x9b258db277d529ad08998897bfdc6761a20ba6147151387dd46f322e76921125::marika {
    struct MARIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARIKA>(arg0, 9, b"MARIKA", b"Marika", b"MARIKA IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/820/531/large/ricardo-augusto-1.jpg?1728587422")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MARIKA>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARIKA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

