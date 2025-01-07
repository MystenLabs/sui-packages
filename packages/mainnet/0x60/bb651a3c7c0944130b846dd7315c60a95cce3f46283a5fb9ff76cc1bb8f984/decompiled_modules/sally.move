module 0x60bb651a3c7c0944130b846dd7315c60a95cce3f46283a5fb9ff76cc1bb8f984::sally {
    struct SALLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALLY>(arg0, 9, b"SALLY", b"Salma", b"Crypto ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a07cafef-42f1-441f-869b-35c2af21507d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SALLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

