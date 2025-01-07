module 0x67dbe3736247804d0767d8612b54e0f0e80b34f88c0299ebd1b94039477626b1::prox {
    struct PROX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PROX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROX>(arg0, 6, b"PROX", b"SUI GOLD", b"GOLD SU CHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WETC_Dp3p_400x400_97144f2806.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PROX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PROX>>(v1);
    }

    // decompiled from Move bytecode v6
}

