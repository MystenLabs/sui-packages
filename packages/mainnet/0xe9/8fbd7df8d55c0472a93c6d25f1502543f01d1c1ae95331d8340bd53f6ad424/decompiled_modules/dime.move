module 0xe98fbd7df8d55c0472a93c6d25f1502543f01d1c1ae95331d8340bd53f6ad424::dime {
    struct DIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIME>(arg0, 9, b"DIME", b"Dime", b"Dime th", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d6bf68b-0545-46b1-b5af-fa0e6c071ca1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

