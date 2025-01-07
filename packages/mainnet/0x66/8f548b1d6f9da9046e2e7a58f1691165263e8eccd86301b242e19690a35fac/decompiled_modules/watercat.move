module 0x668f548b1d6f9da9046e2e7a58f1691165263e8eccd86301b242e19690a35fac::watercat {
    struct WATERCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATERCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATERCAT>(arg0, 6, b"WATERCAT", b"watercat", b"Dive into the perfect meme token on the Sui Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731000765063.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WATERCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATERCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

