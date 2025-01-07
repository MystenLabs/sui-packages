module 0xac763cd6a0b839f2f77f436d990942f56c13365128cad84ddcd287b9e754f3bc::calix {
    struct CALIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CALIX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CALIX>(arg0, 6, b"CALIX", b"Calix by SuiAI", b"CALIX token powers the rise of Calix, a genre-bending music prodigy reshaping soundscapes with electrifying storytelling and soulful beats. Backed by a sentient AI narrative, CALIX offers holders a stake in the creative revolution, igniting speculation and fueling the future of music", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000009248_a7105c7d4d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CALIX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CALIX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

