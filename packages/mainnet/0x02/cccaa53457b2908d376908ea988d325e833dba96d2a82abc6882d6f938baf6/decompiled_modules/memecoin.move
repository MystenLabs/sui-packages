module 0x2cccaa53457b2908d376908ea988d325e833dba96d2a82abc6882d6f938baf6::memecoin {
    struct MEMECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MEMECOIN>(arg0, 6, b"DOGAI", b"DOGAI", b"First AI-driven memecoin dog ever.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://node1.irys.xyz/55zWHav-jQbBLV1FHX-kEM8tJougBOFmJlwOS_kMuo8"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MEMECOIN>(&mut v3, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMECOIN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMECOIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MEMECOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

