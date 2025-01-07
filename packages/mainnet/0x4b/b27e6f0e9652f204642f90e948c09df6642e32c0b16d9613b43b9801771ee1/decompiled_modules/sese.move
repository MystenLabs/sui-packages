module 0x4bb27e6f0e9652f204642f90e948c09df6642e32c0b16d9613b43b9801771ee1::sese {
    struct SESE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SESE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SESE>(arg0, 9, b"SESE", b"Sese", b"Sese coin is symbol of semiconductor in A.I. and blockchain circumstance and it will be used as world top semiconductor player's company introduction with their new products as highly skillful sales and marketing purposes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.sunpump.meme/public/logo/Sese_TVoQ5d_LKlFTpzUlY3D.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SESE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SESE>>(v1);
    }

    // decompiled from Move bytecode v6
}

