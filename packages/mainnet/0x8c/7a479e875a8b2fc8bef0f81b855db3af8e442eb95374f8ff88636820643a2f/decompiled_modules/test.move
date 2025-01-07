module 0x8c7a479e875a8b2fc8bef0f81b855db3af8e442eb95374f8ff88636820643a2f::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 9, b"TEST", b"test", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<TEST>(&mut v2, 1000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

