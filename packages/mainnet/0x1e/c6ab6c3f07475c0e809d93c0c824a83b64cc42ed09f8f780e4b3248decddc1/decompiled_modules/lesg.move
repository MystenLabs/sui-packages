module 0x1ec6ab6c3f07475c0e809d93c0c824a83b64cc42ed09f8f780e4b3248decddc1::lesg {
    struct LESG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LESG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LESG>(arg0, 9, b"LESG", b"Lsggoooo", b"To the dust", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/79c6a03f-f345-4fb8-83f9-f8945b846115.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LESG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LESG>>(v1);
    }

    // decompiled from Move bytecode v6
}

