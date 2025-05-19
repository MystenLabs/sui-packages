module 0x3ead5976af8e162d7df2e3680cfd7d22c4e7b000932d51b65d3de8d1f5d067fe::lucario {
    struct LUCARIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCARIO>(arg0, 6, b"LUCARIO", b"Lucario Pokemon Battle", b"Lucario Pokemon Battle is the first pokemon battle game on Sui Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihzpim5ezy5d4htrdul6vygsbtqb67czsl6u2gz57gr5dvxoca72e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCARIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LUCARIO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

