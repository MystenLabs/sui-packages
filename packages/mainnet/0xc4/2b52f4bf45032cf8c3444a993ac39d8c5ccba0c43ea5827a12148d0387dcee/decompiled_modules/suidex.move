module 0xc42b52f4bf45032cf8c3444a993ac39d8c5ccba0c43ea5827a12148d0387dcee::suidex {
    struct SUIDEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDEX>(arg0, 6, b"SUIDEX", b"SUIDEX+", b"Trade Sui perpetuals and explore the future of decentralized liquidity on the SUIDEX platform.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidoqlb3k4qs4lbbu3h52jk3zhrcaeg5yjjy7d4oxcs75qtorjk5ou")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIDEX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

