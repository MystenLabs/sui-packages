module 0x535963d21b3589d85929b931821bea824d1673bf6bb58bd52fb4cd21ce72f411::avaos {
    struct AVAOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVAOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVAOS>(arg0, 6, b"AVAOS", b"AVA on SUI", b"no social", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000683_4fa747b901.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVAOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AVAOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

