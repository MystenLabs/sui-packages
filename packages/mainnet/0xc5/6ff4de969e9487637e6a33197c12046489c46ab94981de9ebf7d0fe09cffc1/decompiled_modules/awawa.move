module 0xc56ff4de969e9487637e6a33197c12046489c46ab94981de9ebf7d0fe09cffc1::awawa {
    struct AWAWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWAWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWAWA>(arg0, 9, b"AWAWA", b"Nukawa", b"it's very funny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4f376e0f-9f96-46c9-9dd2-103e90217bc9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWAWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AWAWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

