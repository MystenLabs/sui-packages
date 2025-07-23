module 0xdec3ccbea44a98173079f0181c33be535ff0a30fd776a66cdf722b5fd08fe48a::clb {
    struct CLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLB>(arg0, 6, b"CLB", b"CELEBI ON SUI", b"Celebi on Sui. The only legendary Pokemon capable of channeling the power of the blockchain. Hard to catch it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiciigf5rhah6e2lyp7izrnpoglq5za7ya6s54kv62a3y6blbsny7a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CLB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

