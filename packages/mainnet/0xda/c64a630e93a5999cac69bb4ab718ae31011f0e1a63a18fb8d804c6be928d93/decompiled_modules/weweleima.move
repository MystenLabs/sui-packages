module 0xdac64a630e93a5999cac69bb4ab718ae31011f0e1a63a18fb8d804c6be928d93::weweleima {
    struct WEWELEIMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWELEIMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWELEIMA>(arg0, 9, b"WEWELEIMA", b"Leima", b"Leima is a manipuri goddess ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2612d3c8-9fa2-43d7-9aaa-5d4978109c0a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWELEIMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWELEIMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

