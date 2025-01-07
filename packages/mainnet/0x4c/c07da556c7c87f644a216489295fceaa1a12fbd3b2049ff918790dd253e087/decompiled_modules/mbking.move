module 0x4cc07da556c7c87f644a216489295fceaa1a12fbd3b2049ff918790dd253e087::mbking {
    struct MBKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBKING>(arg0, 9, b"MBKING", b"FCB", b"A Token To get you Up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2b9d8f9e-67e8-4ae7-a8a8-51a097aad043.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MBKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

