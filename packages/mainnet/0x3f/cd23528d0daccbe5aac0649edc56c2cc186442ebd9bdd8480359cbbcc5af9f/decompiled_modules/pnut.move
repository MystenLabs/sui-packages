module 0x3fcd23528d0daccbe5aac0649edc56c2cc186442ebd9bdd8480359cbbcc5af9f::pnut {
    struct PNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUT>(arg0, 9, b"PNUT", b"Pnut", b"Pnnuter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6400ae59-9514-43cf-bc8c-4d32db9beea3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

