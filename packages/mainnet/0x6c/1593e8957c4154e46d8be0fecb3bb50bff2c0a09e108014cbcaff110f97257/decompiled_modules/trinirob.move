module 0x6c1593e8957c4154e46d8be0fecb3bb50bff2c0a09e108014cbcaff110f97257::trinirob {
    struct TRINIROB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRINIROB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRINIROB>(arg0, 9, b"TRINIROB", b"Trinirob", b"TRINIROB IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/241/101/large/gui-wenlong-untitled01-logo.jpg?1727083340")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRINIROB>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRINIROB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRINIROB>>(v1);
    }

    // decompiled from Move bytecode v6
}

