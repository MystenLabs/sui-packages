module 0x3e69c3cf17056e6119e962c97bf7d03f813e687229075708192a1bcf6fe5b754::beary {
    struct BEARY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEARY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEARY>(arg0, 6, b"BEARY", b"BEARY COIN", b"My name is Beary. I am Pengu best friend but also his worst enemy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic7awrfowmaf5f6go4xonrbwkwjoxxey6wgqxnkyhkiyh3tc5srh4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEARY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BEARY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

