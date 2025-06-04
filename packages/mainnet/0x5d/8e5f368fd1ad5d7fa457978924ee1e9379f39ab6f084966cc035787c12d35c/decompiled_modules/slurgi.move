module 0x5d8e5f368fd1ad5d7fa457978924ee1e9379f39ab6f084966cc035787c12d35c::slurgi {
    struct SLURGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLURGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLURGI>(arg0, 6, b"SLURGI", b"Slurgi on Sui", b"Official SLURGI The slimiest meme coin on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidcrp3v2r4jdmbdmxn6drf5upxigtnp2zu7mzba3ryjhnitjqz7aa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLURGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SLURGI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

