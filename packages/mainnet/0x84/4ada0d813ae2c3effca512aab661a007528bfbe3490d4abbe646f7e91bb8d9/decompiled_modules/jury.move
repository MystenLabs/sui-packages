module 0x844ada0d813ae2c3effca512aab661a007528bfbe3490d4abbe646f7e91bb8d9::jury {
    struct JURY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JURY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JURY>(arg0, 6, b"JURY", b"Cognitio Jury", b"Cognitio is the first AI-powered Meme Jury built on the Solana Network. Unlike typical memecoins that rely only on hype, Cognitio introduces a utility-driven twist: every meme, case, or prediction submitted to the platform is judged by an AI-assisted community jury.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiearhv2b63dgfzmdk4nfkatd6qadnphzg3ktxfsaxegs57d35tamq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JURY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JURY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

