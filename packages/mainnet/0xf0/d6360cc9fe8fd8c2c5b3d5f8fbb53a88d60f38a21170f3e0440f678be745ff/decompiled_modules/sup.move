module 0xf0d6360cc9fe8fd8c2c5b3d5f8fbb53a88d60f38a21170f3e0440f678be745ff::sup {
    struct SUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUP>(arg0, 9, b"SUP", b"SUIPEANUTS", b"memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUP>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

