module 0x659695c9dc82fdfadf5add22062477ec48d23259f68114263985a64b5a40ce74::suimer {
    struct SUIMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMER>(arg0, 6, b"SUIMER", b"Suimer or Dog", b"Missed out on $SOG? No worries Meet Suimer Dog - MOG of SUI chain. Same rule as $SOG - buy and hold. Create memes, shill X space. TG, X, website to follow upon bonding. LFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A08381_E3_5588_46_B1_8_ACA_64_D1_F2410_A6_A_c1590d6a5a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

