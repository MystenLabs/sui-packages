module 0x6c470818516c92efb70ae5d9e6ee3bee8de75db99b7e0c83b4cdf2b906ccef1c::crhd {
    struct CRHD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRHD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRHD>(arg0, 6, b"CRHD", b"Crazy Head", b"In a world full of copy paste tokens, Crazy Heads comes swinging with no filter, no brakes, and no apologies.  Were the voice of the chaotic, the misunderstood, the terminally online degenerates who see the charts as a playground and memes as religion.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifxnrnrsz7zgtg77mwa22lvabzmxmtgs3nx6vcdqo6eehltl6vs7i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRHD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CRHD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

