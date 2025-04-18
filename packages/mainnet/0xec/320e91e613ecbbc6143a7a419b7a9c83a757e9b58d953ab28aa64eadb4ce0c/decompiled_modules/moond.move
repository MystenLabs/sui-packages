module 0xec320e91e613ecbbc6143a7a419b7a9c83a757e9b58d953ab28aa64eadb4ce0c::moond {
    struct MOOND has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOND>(arg0, 6, b"MOOND", b"Moon Dog", b"Meme coin inspired by the brave space pup on a mission to take the internet and your portfolio to the moon. No utility? No problem. Just vibes, velocity, and a whole lot of doggo energy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigzhxdkef2jgubw5pec2alkz5eq6xvwddqkkabz3r2qvtgkqwdaia")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOOND>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

