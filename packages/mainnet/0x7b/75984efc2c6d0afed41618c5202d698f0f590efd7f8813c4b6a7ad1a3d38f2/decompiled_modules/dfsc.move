module 0x7b75984efc2c6d0afed41618c5202d698f0f590efd7f8813c4b6a7ad1a3d38f2::dfsc {
    struct DFSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFSC>(arg0, 6, b"DFSC", b"Defi Scape", b"The Text Based RuneScape like blockchain game on $Sui. Train skills, fight bosses and gather rare items!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifwtlsusr5kylffrlopxhirxg5kcy574kqyhuzenldk5qf3qxuw7q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFSC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DFSC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

