module 0xf728aa7065597e477d5f4d7daff26a69b0aff3578ed8fef1b18f1e11e7b23333::octooo {
    struct OCTOOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTOOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTOOO>(arg0, 6, b"OCTOOO", b"OCTOSUI", b"DONT BUY THIS LOL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifeb6whwiqgenicfk6ajax6pdlq7jixvofgby3khgap5fzwny6x4m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTOOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OCTOOO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

