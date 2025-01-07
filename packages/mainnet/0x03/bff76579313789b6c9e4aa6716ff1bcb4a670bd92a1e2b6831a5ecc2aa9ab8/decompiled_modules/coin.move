module 0x3bff76579313789b6c9e4aa6716ff1bcb4a670bd92a1e2b6831a5ecc2aa9ab8::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<COIN>(arg0, 6, b"MAGA", b"MAGA", b"Make Sui Great Again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://207.148.66.213:4137/uploads/10k_863aeae5e0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

