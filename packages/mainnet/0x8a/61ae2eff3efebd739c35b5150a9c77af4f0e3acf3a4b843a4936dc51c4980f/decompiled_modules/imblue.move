module 0x8a61ae2eff3efebd739c35b5150a9c77af4f0e3acf3a4b843a4936dc51c4980f::imblue {
    struct IMBLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMBLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IMBLUE>(arg0, 6, b"IMBLUE", b"I'm Blue Da ba dee da ba di", b"Let's go back to the 90s, where everything was blue! IMBLUE, Inspired by the iconic track A Decade in Blue (Da Ba Dee).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_bcfe578edb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IMBLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IMBLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

