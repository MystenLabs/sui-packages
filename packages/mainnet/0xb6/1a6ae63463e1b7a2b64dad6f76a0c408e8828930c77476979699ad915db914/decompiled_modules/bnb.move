module 0xb61a6ae63463e1b7a2b64dad6f76a0c408e8828930c77476979699ad915db914::bnb {
    struct BNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNB>(arg0, 6, b"BNB", b"BNB", b"undefined", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"undefined"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BNB>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BNB>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNB>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

