module 0xb7013b747a85c36b28ddc16d279a290f1f3bb16beaec97561a5d843c4f62ce3e::suietf {
    struct SUIETF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIETF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIETF>(arg0, 6, b"SUIETF", b"Sui ETF", b"Every Trades Fucked", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicxi2enfqhnyvsadjtkoq5lfy5oo4zhjhbvnod5nxebquv6qzaqaq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIETF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIETF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

