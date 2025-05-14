module 0xd58a313e3afaa83364bd78ec55e7f76e5dc7d3d27ae9b43a8c1e557607d03736::din {
    struct DIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIN>(arg0, 6, b"Din", b"DinDin", b"The DINDIN project, which leads the new trend of Sui-based meme projects, will change the paradigm of memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibcw3v5jxsh7qtovhfp7om62e44dne6fjymbvmbede76nmno7hxde")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

