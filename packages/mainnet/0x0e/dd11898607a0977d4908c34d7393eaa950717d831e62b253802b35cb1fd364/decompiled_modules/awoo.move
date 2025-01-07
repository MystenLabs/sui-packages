module 0xedd11898607a0977d4908c34d7393eaa950717d831e62b253802b35cb1fd364::awoo {
    struct AWOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWOO>(arg0, 9, b"AWOO", b"Awoo Cat", b"cats will make you rich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a78506c7-202a-47ef-bfb9-f2902ce95b4f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AWOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

