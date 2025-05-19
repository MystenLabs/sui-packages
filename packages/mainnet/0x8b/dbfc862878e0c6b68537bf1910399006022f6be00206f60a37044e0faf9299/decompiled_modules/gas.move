module 0x8bdbfc862878e0c6b68537bf1910399006022f6be00206f60a37044e0faf9299::gas {
    struct GAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAS>(arg0, 6, b"Gas", b"Gastly", x"596f7572206661766f7269746520506f6bc3a96d6f6e207072616e6b7374657220476173746c792c204a6f696e207573206173207765206275696c64207468652062696767657374206d6f7374206d697363686965766f757320506f6bc3a96d6f6e2020636f6d6d756e6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigid5lavkl2oeei7ndspgzuegdzd4pgpxwxo67hvgzofnbhl7urti")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GAS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

