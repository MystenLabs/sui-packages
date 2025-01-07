module 0xdd21111ec27dd80f1ac7d27004fcaf40f3c694cc52f290a614795da719c77cb5::doliti {
    struct DOLITI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLITI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLITI>(arg0, 9, b"doliti", b"Doliti", b"DOLITI IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/576/298/large/w-_press-suv.jpg?1727936579")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOLITI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLITI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLITI>>(v1);
    }

    // decompiled from Move bytecode v6
}

