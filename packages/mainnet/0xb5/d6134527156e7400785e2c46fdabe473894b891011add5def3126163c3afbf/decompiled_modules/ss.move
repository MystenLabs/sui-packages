module 0xb5d6134527156e7400785e2c46fdabe473894b891011add5def3126163c3afbf::ss {
    struct SS has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SS>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SS>>(arg0, arg1);
    }

    fun init(arg0: SS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SS>(arg0, 9, b"SS", b"sss", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.interestprotocol.com")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SS>(&mut v2, 20000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SS>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SS>>(v1);
    }

    // decompiled from Move bytecode v6
}

