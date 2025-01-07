module 0xc2a61824405f7085557e6da504a190eb447859acc47476d5c535b2e7ba3aa1c5::degtq {
    struct DEGTQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGTQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGTQ>(arg0, 9, b"DEGTQ", b"kloy", x"c4916667646667", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a8598c26-b27b-4917-b9cf-91bb70f3fa00.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGTQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEGTQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

