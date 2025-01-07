module 0x2cc5a24e5191c9007eeda364d6f6d33eaf4c333d8a09b6102f82f810b8b33089::sbonk {
    struct SBONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBONK>(arg0, 6, b"SBONK", b"Bonk on SUI", b"Bonk is the social layer and community meme coin of Solana, now on Sui, with deep integrations as a utility token across a wide base of applications and protocols within the Web3 ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732060322469.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBONK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBONK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

