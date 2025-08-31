module 0x4e51d0f8f982c47ffde3e46f658342b339748842804b49ca07a445aaebb41580::zbs {
    struct ZBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZBS>(arg0, 6, b"ZBS", b"ZBS", b"undefined", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"undefined"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZBS>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZBS>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZBS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

