module 0x116f2a97bb5a7338ba903a6abfb5b0ad1449721300137f8d3357b3b5cd946c30::uuu {
    struct UUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: UUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UUU>(arg0, 6, b"UUU", b"UUU", b"undefined", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"undefined"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UUU>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<UUU>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UUU>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

