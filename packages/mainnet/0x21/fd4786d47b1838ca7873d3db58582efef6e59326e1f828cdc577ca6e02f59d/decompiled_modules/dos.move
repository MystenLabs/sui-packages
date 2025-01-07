module 0x21fd4786d47b1838ca7873d3db58582efef6e59326e1f828cdc577ca6e02f59d::dos {
    struct DOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOS>(arg0, 6, b"DOS", b"DORKLORD On Sui", x"5072657061726520796f757273656c662c20796f756e67205061646177616e2c20666f7220746865206d6f73742065706963206d656d65636f696e20696e2074686520245355492067616c6178793a20444f524b4c4f524421200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DOKRLOR_047ecb48c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

