module 0x161a42d117a83b9dd048564426e1f8bc0073a6c742b6e6d1d1cb4b30be3d67f8::bukuru_30 {
    struct BUKURU_30 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUKURU_30, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUKURU_30>(arg0, 9, b"BUKURU_30", b"Bukuru ", b"Just for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c042aaa8-b4b4-402b-9d4c-f1bd14d8bbc1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUKURU_30>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUKURU_30>>(v1);
    }

    // decompiled from Move bytecode v6
}

