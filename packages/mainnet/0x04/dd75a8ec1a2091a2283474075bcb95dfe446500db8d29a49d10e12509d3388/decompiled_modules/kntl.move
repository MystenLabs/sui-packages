module 0x4dd75a8ec1a2091a2283474075bcb95dfe446500db8d29a49d10e12509d3388::kntl {
    struct KNTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: KNTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KNTL>(arg0, 9, b"KNTL", b"Kontolbo", b"KNTLasdasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dd24fc85-5c1c-478b-b5a8-9630a478f1bd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KNTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KNTL>>(v1);
    }

    // decompiled from Move bytecode v6
}

