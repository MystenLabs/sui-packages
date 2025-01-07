module 0x84a42d50a3fd496d5a3dd909eda83ef784c374a179ab6a9e540f0219f3044633::blumje {
    struct BLUMJE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUMJE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUMJE>(arg0, 9, b"BLUMJE", b"Blum", b"Je", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/91c23f9b-7745-46f0-8ee7-987e7f005347.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUMJE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUMJE>>(v1);
    }

    // decompiled from Move bytecode v6
}

