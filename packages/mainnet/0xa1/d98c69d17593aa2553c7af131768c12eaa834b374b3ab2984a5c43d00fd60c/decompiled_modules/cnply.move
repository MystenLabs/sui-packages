module 0xa1d98c69d17593aa2553c7af131768c12eaa834b374b3ab2984a5c43d00fd60c::cnply {
    struct CNPLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CNPLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CNPLY>(arg0, 6, b"CNPLY", b"Cronopoly Sui", b"Roll the dice, it's paradise. But if you fail, you go to jail", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000025050_6e50e2485f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CNPLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CNPLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

