module 0x816b7fe84a31130811ebb173df2b13948790b7fdeece1043e21f8e8f489d1841::squibee {
    struct SQUIBEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIBEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIBEE>(arg0, 6, b"SQUIBEE", b"Squid Bee", b"READY TO KILL SOME POKE COINS?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidaw2we56y5bgyfxbngdfc5lxry4qdzxr7rlzwdvaxoy5eokkqitq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIBEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SQUIBEE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

