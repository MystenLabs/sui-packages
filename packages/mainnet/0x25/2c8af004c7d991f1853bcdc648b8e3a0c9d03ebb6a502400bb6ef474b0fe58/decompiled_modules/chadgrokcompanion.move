module 0x252c8af004c7d991f1853bcdc648b8e3a0c9d03ebb6a502400bb6ef474b0fe58::chadgrokcompanion {
    struct CHADGROKCOMPANION has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHADGROKCOMPANION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHADGROKCOMPANION>(arg0, 9, b"Chad", b"Chad Grok Companion", b"Twitter: https://x.com/ChadAnichat | Created on: https://bonk.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic5b3no6gqfwz6us4jyllvrvfpvgxihzsq5dcrlyrth7ewu2imvvq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHADGROKCOMPANION>(&mut v2, 1000000000000000000, @0xfa3e6c5e61bf55f576b6500503c1a4d8f64756c44acc510e42e86ad1d1bcc406, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHADGROKCOMPANION>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHADGROKCOMPANION>>(v1);
    }

    // decompiled from Move bytecode v6
}

