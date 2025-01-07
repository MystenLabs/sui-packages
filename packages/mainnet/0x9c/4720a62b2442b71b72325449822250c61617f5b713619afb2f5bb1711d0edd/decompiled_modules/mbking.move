module 0x9c4720a62b2442b71b72325449822250c61617f5b713619afb2f5bb1711d0edd::mbking {
    struct MBKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBKING>(arg0, 9, b"MBKING", b"FCB", b"A Token To get you Up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/99edc668-25dd-4c49-b97c-c85963ed4f8f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MBKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

