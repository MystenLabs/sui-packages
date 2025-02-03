module 0xccf0ae5bc16f36e45d97683ace44bb5b2a50955615ad932c6ad96c07ba8b2c53::bfc {
    struct BFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFC>(arg0, 9, b"BFC", b"Bullshit Fantasy Coin", b"Bullshit fantasy technology", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVtHtbQtwVJ8ZogA6r8LuLqByDXZ4Gwrh6cMzy87Qz5bm")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BFC>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFC>>(v2, @0x7acf3b01e25b25ece7bb4ed80226d7b20d861f5aa65085da8fdbfee4487a7c9d);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

