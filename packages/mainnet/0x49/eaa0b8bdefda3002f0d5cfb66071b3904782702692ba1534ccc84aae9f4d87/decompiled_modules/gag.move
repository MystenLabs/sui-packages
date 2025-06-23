module 0x49eaa0b8bdefda3002f0d5cfb66071b3904782702692ba1534ccc84aae9f4d87::gag {
    struct GAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAG>(arg0, 6, b"GaG", b"Grow A Garden", b"Buy seeds, Grow plants, sell fruits for more shekels", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiacb2pcepm5wlvzhmycvqpta3u5qvdsc3iqejfcdccqmsfjtvm3pa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GAG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

