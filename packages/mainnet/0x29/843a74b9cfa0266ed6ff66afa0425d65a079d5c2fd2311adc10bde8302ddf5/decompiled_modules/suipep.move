module 0x29843a74b9cfa0266ed6ff66afa0425d65a079d5c2fd2311adc10bde8302ddf5::suipep {
    struct SUIPEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPEP>(arg0, 6, b"SUIPEP ", b"SUIPEP", b"SUIPEP", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPEP>>(v1);
        0x2::coin::mint_and_transfer<SUIPEP>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIPEP>>(v2);
    }

    // decompiled from Move bytecode v6
}

