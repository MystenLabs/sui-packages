module 0x1b94b1f78ee697cd69f2ce5723d008ea13cad3aa73a6949eafe2bb63a1f117ef::kris_33 {
    struct KRIS_33 has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRIS_33, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRIS_33>(arg0, 9, b"KRIS_33", b"Kris ", b"Fun play ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5eb54599-f782-4b33-a229-5e2fd0e3f392.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRIS_33>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRIS_33>>(v1);
    }

    // decompiled from Move bytecode v6
}

