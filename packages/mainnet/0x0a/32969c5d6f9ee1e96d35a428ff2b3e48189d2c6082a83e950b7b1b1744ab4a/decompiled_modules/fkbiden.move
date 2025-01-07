module 0xa32969c5d6f9ee1e96d35a428ff2b3e48189d2c6082a83e950b7b1b1744ab4a::fkbiden {
    struct FKBIDEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FKBIDEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FKBIDEN>(arg0, 6, b"FKBIDEN", b"FkBiden", x"46726f6d207468652070656f706c652c20666f72207468652070656f706c65210a4d616b65207468652063727970746f206d61726b657420677265617420616761696e2e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004337_2ac2e2a506.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FKBIDEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FKBIDEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

