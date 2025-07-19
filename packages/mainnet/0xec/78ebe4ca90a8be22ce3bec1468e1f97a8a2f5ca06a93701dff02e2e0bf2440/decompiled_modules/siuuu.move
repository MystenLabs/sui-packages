module 0xec78ebe4ca90a8be22ce3bec1468e1f97a8a2f5ca06a93701dff02e2e0bf2440::siuuu {
    struct SIUUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIUUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIUUU>(arg0, 6, b"Siuuu", b"Ronaldo", b"Ronaldo meme token on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifxdjlo2ilewunbffdgborvtu6bccblcerzwokqvfuavawrbxyclu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIUUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SIUUU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

