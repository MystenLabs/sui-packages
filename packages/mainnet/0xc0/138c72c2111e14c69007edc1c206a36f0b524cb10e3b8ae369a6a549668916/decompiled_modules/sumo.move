module 0xc0138c72c2111e14c69007edc1c206a36f0b524cb10e3b8ae369a6a549668916::sumo {
    struct SUMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMO>(arg0, 6, b"SUMO", b"SUMOonSUI", b"Real SUMO on SUI !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sumooooooo_50ca00a173.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

