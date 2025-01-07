module 0xe2d5e8ac1d209e97db9df42edb11aea04a9dba5793427d7d06939afbb5121b7b::TEST {
    struct TEST has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEST>, arg1: 0x2::coin::Coin<TEST>) {
        0x2::coin::burn<TEST>(arg0, arg1);
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 1, b"TEST", b"TEST", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(v1);
        0x2::coin::mint_and_transfer<TEST>(&mut v2, 50000000000000000, @0x3fd830b0f7db7e6b36f589ba2fdc6acc4934a1b4c3ba2b4a7622fc22df7cdc59, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v2, @0x3fd830b0f7db7e6b36f589ba2fdc6acc4934a1b4c3ba2b4a7622fc22df7cdc59);
    }

    // decompiled from Move bytecode v6
}

