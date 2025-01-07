module 0x77aebd32fd477d2742064cfd3bdc674db39c406eb114adaa3d434ccb67de7f30::suiamese {
    struct SUIAMESE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAMESE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAMESE>(arg0, 6, b"SUIAMESE", b"SIAMESE CAT ON SUI", b"Meet the king cat, The SUI-perstar of SUI Chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0491_754be4680b_8c428728a7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAMESE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIAMESE>>(v1);
    }

    // decompiled from Move bytecode v6
}

