module 0xc26af70a53a68e384610f7093eca2888f5708c5422044cf14225a16a3c6d6076::dfdd {
    struct DFDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFDD>(arg0, 6, b"DFDD", b"fdgd", b"dfgdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/p_B27_G7qb_400x400_1_2c401f3926.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DFDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

