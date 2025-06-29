module 0x655ba6b9fd4c866931e11dac613c93a977629e6138842170953c1e5513c49ed2::node {
    struct NODE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NODE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NODE>(arg0, 8, b"NODE", b"NodeOps", x"546865206c656164696e672041492d706f776572656420446550494e204f726368657374726174696f6e204c617965722e204465706c6f792061206e6f64653a2068747470733a2f2f636f6e736f6c652e6e6f64656f70732e6e6574776f726b2e2047657420636f6d707574653a20466f6c6c6f77200a404275696c644f6e4e6f64654f7073", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/d4476dfb-9813-40a4-87f9-7cc7a58e0ed7.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NODE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NODE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NODE>>(v1);
    }

    // decompiled from Move bytecode v6
}

