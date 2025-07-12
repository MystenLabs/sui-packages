module 0x281075a757dbeb5bf0ffc5c671062a3cfd15af4109ff66625489bbc6bf3b2903::pela {
    struct PELA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PELA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PELA>(arg0, 6, b"PELA", b"PepeLandia", b"PepeLandia is a magical digital realm where memes don't just exist - they LIVE! Our kingdom is ruled by none other than the legendary Pepe the Frog, and all his meme friends are invited to hop along for the ride.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreietwf2y73kkenplgabqyz4wx34krmoyv62ey5c2hvmayih6iakvtm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PELA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PELA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

