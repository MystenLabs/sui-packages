module 0x5e0e3727296d31431526da96b26fa9ca80801d66f1e1d4036bf160c148a3a7c3::smiley {
    struct SMILEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMILEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMILEY>(arg0, 9, b":)", b":)", b"THE OG of the OG memes. | Created on: https://pump.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiccxsh2tqqfoll5paqzdkkb634ajn4zlkxhg6l4oa2aowmnyfvvru")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SMILEY>(&mut v2, 1000000000000000000, @0xfa3e6c5e61bf55f576b6500503c1a4d8f64756c44acc510e42e86ad1d1bcc406, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMILEY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMILEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

