module 0x486dfdae39de32faee90a09a49c950d16cecadc91318e21aaeacc022c9cd98e2::litcoin {
    struct LITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LITCOIN>(arg0, 6, b"LITCOIN", b"LIT ENERGY", b"LITCOIN is the official token of the energy drink LIT ENERGY. Meet the LIT ENERGY token on the world stage. This is the intergalactic level! 5% of profits from energy drink sales will go towards promoting the token to the next level! Welcome aboard!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_02_13_19_01_35_70a5f58d96.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LITCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LITCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

