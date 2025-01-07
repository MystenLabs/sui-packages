module 0xe03bd20371a9a8ed67e3c6adafd09f79837928284296dd004063fdbae2139c70::bubs {
    struct BUBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBS>(arg0, 9, b"BUBS", b"Bub", b"Buba", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b015479a-4ee0-474c-9158-d7f44fd77358.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

