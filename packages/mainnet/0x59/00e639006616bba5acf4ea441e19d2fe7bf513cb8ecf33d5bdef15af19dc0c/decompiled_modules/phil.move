module 0x5900e639006616bba5acf4ea441e19d2fe7bf513cb8ecf33d5bdef15af19dc0c::phil {
    struct PHIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHIL>(arg0, 6, b"PHIL", b"SUIPHIL", b"PHIL ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/phil_logo_new_a5deaf999a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

