module 0xcc2e189b898d4737b1e0e8247e532f5e9e882d14b9ae56c673cb6b78b6a2f601::prediction {
    struct PREDICTION has drop {
        dummy_field: bool,
    }

    fun init(arg0: PREDICTION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PREDICTION>(arg0, 9, b"PREDICTION", b"PREDICTION", b"This is description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PREDICTION>(&mut v2, 18000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PREDICTION>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PREDICTION>>(v2);
    }

    // decompiled from Move bytecode v6
}

