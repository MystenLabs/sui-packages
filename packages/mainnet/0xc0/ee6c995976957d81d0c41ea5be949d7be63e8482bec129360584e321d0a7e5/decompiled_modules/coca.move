module 0xc0ee6c995976957d81d0c41ea5be949d7be63e8482bec129360584e321d0a7e5::coca {
    struct COCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCA>(arg0, 9, b"COCA", b"Coca", b"CoCa coind", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/15d3cb50-6fa4-4146-8d5e-69cd90583182.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

