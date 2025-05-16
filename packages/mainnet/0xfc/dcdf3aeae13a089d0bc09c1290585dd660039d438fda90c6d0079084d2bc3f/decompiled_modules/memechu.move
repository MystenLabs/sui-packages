module 0xfcdcdf3aeae13a089d0bc09c1290585dd660039d438fda90c6d0079084d2bc3f::memechu {
    struct MEMECHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMECHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMECHU>(arg0, 6, b"MEMECHU", b"MEMECHU ON SUI", b"Memechu is what happens when a meme zaps itself with 10,000 volts of internet energy. Half meme, half Pikachu, 100% chaos. Cute, charged, and ready to go viral.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicdvwmujih6m5u3xcxeyijva64cyat6e3vjdcggbqjfgaoh62y6pm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMECHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEMECHU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

