module 0x1a5cb1b9b3f9a586079780b9a62ec3aed0a889a1e9c359ff9781d33317e6f561::quantimania {
    struct QUANTIMANIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUANTIMANIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUANTIMANIA>(arg0, 9, b"QUANTIMANIA", b"Quantimania", b"JETPACKER IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/251/612/large/jerx-s-marantz-gozar-9-sketch.jpg?1727103944")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<QUANTIMANIA>(&mut v2, 5000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUANTIMANIA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUANTIMANIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

