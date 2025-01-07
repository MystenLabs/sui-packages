module 0x54eb541aab8c5a0e15fe5022a7b1a7924febe20ae8cd609718026b67a329fb73::suiman {
    struct SUIMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAN>(arg0, 6, b"SUIMAN", b"Suiman", b"Suiman - The Original Suiman. Suiman is the Superhero of the Sui Blockchain, ready to save Sui and help it achieve it's position as the #1 Blockchain in Crypto. There is another Suiman on Sui, but it's just an imitator! Suppoman is the original Superhero of the Sui Blockchain. As one of the first YouTubers to talk about it, he promoted it heavily in the bear market, allowing his followers and himself to scoop it up at 0.35c. Be part of the Suiman revolution.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000046140_dfb7920faa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

