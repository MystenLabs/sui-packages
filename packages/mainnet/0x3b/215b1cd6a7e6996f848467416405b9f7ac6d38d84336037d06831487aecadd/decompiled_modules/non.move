module 0x3b215b1cd6a7e6996f848467416405b9f7ac6d38d84336037d06831487aecadd::non {
    struct NON has drop {
        dummy_field: bool,
    }

    fun init(arg0: NON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NON>(arg0, 9, b"NON", b"nonma", b"nothing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/22e567c5-4ddc-4bea-871f-1ba4ab5960d8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NON>>(v1);
    }

    // decompiled from Move bytecode v6
}

