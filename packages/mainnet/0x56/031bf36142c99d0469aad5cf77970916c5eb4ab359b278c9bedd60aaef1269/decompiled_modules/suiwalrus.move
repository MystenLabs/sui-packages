module 0x56031bf36142c99d0469aad5cf77970916c5eb4ab359b278c9bedd60aaef1269::suiwalrus {
    struct SUIWALRUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWALRUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWALRUS>(arg0, 6, b"SUIWALRUS", b"SUI  Walrus", b"Walrus is faithful", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cnn_5_Kz_C_400x400_e6a60097d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWALRUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWALRUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

