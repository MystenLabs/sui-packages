module 0x12201b0ce66a2e282959e43358dac969e8c461ba2cd6e4f652a2cab6cdf265ac::rise {
    struct RISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RISE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RISE>(arg0, 6, b"RISE", b"NASA ZGI Moon Mascot", b"https://x.com/SuiRises", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigj6ite2jryxqvmvzjla3we2tujpdilnwhwtcor27oa25h7jnzz2m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RISE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RISE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

