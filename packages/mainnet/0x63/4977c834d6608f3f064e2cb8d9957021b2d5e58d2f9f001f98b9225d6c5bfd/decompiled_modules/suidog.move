module 0x634977c834d6608f3f064e2cb8d9957021b2d5e58d2f9f001f98b9225d6c5bfd::suidog {
    struct SUIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOG>(arg0, 6, b"SUIDOG", b"Sui Dog", b"A one-of-a-kind, dog-themed meme coin on the Sui blockchain! We're aiming to be the top dog on #Sui. Get in early with SUIDOGE and join the pack! OG SuiDOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic76teg6y5fp5bgvntzdsdjpbc7gvzcqbfly4prpgelyrklajaroe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

