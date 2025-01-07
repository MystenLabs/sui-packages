module 0xc0c39ced6fb80405ed7cb3d67b98a4fadb2440310bb286bf133713fc64626db7::wvp {
    struct WVP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WVP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WVP>(arg0, 9, b"WVP", b"Wave", b"Crypto ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/94613e8e-9224-4ab0-a3fa-eea5b6272b66.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WVP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WVP>>(v1);
    }

    // decompiled from Move bytecode v6
}

