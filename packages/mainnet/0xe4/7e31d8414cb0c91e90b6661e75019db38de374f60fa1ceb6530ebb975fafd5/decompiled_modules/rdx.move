module 0xe47e31d8414cb0c91e90b6661e75019db38de374f60fa1ceb6530ebb975fafd5::rdx {
    struct RDX has drop {
        dummy_field: bool,
    }

    fun init(arg0: RDX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RDX>(arg0, 6, b"RDX", b"Rendex", b"Rendex wird ein neuer Defi Auf Suo Werden Seit Gespannt Weiter Kommt noch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigdaeomjycgzblpxlmr7ngtavz5glc5r7vpj7az3s5yjw2uv52464")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RDX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RDX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

