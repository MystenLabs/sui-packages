module 0xa97cf0607bc458652094741e652458a62175b22281b6be414a03366761eecdd3::test3 {
    struct TEST3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST3>(arg0, 6, b"TEST3", b"TEST TOKEN 3", b"DON'T BUY THIS COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibwpv6xii6ejaejy45onnzszxlfgl67zi3ggootoe3mk3xj6reqs4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST3>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

