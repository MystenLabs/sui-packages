module 0x34456ce73c4fd49abaa6c71b12440457778f07e7e7e2a43040ea1da0c6474f0c::rappit {
    struct RAPPIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAPPIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAPPIT>(arg0, 9, b"RAPPIT", b"MC Rappit", b"RAPPIT IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/478/894/large/emmanuel-luiz-rappit.jpg?1727701739")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RAPPIT>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAPPIT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAPPIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

