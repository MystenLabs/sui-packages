module 0x64ff258e7c6c17ef4685cdef5dcedb8d72ac919272d00f779855f7c0b4b16337::gl {
    struct GL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GL>(arg0, 9, b"GL", b"GALE", b"GALE is a cutting-edge cryptocurrency token designed for fast transactions and low fees, aimed at enhancing the seamless exchange of digital assets. Built on a secure and scalable blockchain, GALE offers innovative solutions for global financial services.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a2fa5210-8036-4fb8-84e7-57c923e5c642.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GL>>(v1);
    }

    // decompiled from Move bytecode v6
}

