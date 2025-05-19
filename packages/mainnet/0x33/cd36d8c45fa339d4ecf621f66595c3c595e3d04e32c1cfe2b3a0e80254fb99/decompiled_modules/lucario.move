module 0x33cd36d8c45fa339d4ecf621f66595c3c595e3d04e32c1cfe2b3a0e80254fb99::lucario {
    struct LUCARIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCARIO>(arg0, 6, b"LUCARIO", b"Lucario Pokemon Battle", b"Lucario builds pokemon battle game on @SuiNetwork .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihzpim5ezy5d4htrdul6vygsbtqb67czsl6u2gz57gr5dvxoca72e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCARIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LUCARIO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

