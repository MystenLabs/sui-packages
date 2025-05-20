module 0xfc3591b6c57f41078561b84312590a776af2a7927863b0a45464734c63d95eb7::fofo {
    struct FOFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOFO>(arg0, 6, b"FOFO", b"Fofo The Alien", b"Fofo is a meme coin on Sui Blockchain with 0/0 tax on buy and sells. sits alongside its meme coin mates Psyduck and Lofi, sparking giggles in the financial playground and makes a lot of millionaires without actually bringing much to the table in terms of practical use.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicxzzhndzng4cgpya5ttia7mpuwrtyfs5ojcla72mhzd6au2vzkmm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOFO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FOFO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

