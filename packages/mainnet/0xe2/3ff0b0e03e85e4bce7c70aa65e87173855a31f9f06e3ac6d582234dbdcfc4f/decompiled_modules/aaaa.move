module 0xe23ff0b0e03e85e4bce7c70aa65e87173855a31f9f06e3ac6d582234dbdcfc4f::aaaa {
    struct AAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAA>(arg0, 9, b"AAAA", b"ARB", b"ADCV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dev-file-walletapp.waveonsui.com/images/wave-pumps/3ed62a23-2707-4feb-ad9a-7a42e5923671.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

