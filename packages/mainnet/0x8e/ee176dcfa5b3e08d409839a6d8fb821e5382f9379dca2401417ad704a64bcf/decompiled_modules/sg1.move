module 0x8eee176dcfa5b3e08d409839a6d8fb821e5382f9379dca2401417ad704a64bcf::sg1 {
    struct SG1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SG1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SG1>(arg0, 6, b"SG1", b"Sui Generis-1/1", b"Sui Generis translates to \"of its own kind\" or \"unique\" in Latin. This perfectly captures the essence of our meme coin, which is unlike any other in the crypto space.Just like the term suggests, Sui Generis is in a league of its own, a one-of-a-kind!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1742077044968.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SG1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SG1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

