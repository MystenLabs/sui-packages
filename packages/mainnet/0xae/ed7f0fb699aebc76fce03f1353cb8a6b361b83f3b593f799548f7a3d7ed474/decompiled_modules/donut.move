module 0xaeed7f0fb699aebc76fce03f1353cb8a6b361b83f3b593f799548f7a3d7ed474::donut {
    struct DONUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONUT>(arg0, 6, b"DONUT", b"Donut on Sui", b"The Donut of Sui. The ultimate bite-sized tret.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bonut_88154117fa.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

