module 0x5bad851d3131d5663ad292a04b7f7d96872bce277f87183c4787ea7123c3d149::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 6, b"TEST", b"TEST COIN", b"TEST COIN ON SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmNbm298Tu3H1BmuVytxD6HSYCjmhk4j8bMwCNubtaHaCK"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

