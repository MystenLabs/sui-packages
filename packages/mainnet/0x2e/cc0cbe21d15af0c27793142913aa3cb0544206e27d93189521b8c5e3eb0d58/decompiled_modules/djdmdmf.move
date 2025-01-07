module 0x2ecc0cbe21d15af0c27793142913aa3cb0544206e27d93189521b8c5e3eb0d58::djdmdmf {
    struct DJDMDMF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJDMDMF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJDMDMF>(arg0, 9, b"DJDMDMF", b"Kdhrkk", b"Ckfkckckk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c281762b-f857-4565-b577-4c9457ddde40.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJDMDMF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DJDMDMF>>(v1);
    }

    // decompiled from Move bytecode v6
}

