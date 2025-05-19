module 0x9896b88d872762b75ffdb1817f7fb6eca272ddb531899d4f27d169f9197ee082::gas {
    struct GAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAS>(arg0, 6, b"GAS", b"Gastly", b"Your favorite Pokemon prankster Gastly.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigid5lavkl2oeei7ndspgzuegdzd4pgpxwxo67hvgzofnbhl7urti")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GAS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

