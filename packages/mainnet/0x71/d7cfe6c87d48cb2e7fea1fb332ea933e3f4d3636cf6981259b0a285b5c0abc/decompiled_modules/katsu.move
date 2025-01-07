module 0x71d7cfe6c87d48cb2e7fea1fb332ea933e3f4d3636cf6981259b0a285b5c0abc::katsu {
    struct KATSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KATSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KATSU>(arg0, 6, b"KATSU", b"KATSU SUI", b"Katsu is an experiment in decentralized community driven", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x856297944d3abf775a707f2e6f029ad66128ad9dedf9e5f08b03844ee75e592e_katsu_katsu_44776ccf26.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KATSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KATSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

