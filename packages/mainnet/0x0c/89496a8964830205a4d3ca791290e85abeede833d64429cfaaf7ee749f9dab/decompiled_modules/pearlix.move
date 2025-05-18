module 0xc89496a8964830205a4d3ca791290e85abeede833d64429cfaaf7ee749f9dab::pearlix {
    struct PEARLIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEARLIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEARLIX>(arg0, 6, b"Pearlix", b"Pearlix Sui", b"Pearlix the Dragon has awakened from the deep", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeib45cmgxwbfdwr4yeqmm3gjccsxq52lhxvikaz5igpjdyjpyrqdji")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEARLIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEARLIX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

