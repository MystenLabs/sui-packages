module 0x4d7b4d657ea07424195d71473203e90f7db40b1e88bc683b044b77feccd9424e::dogmatic {
    struct DOGMATIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGMATIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGMATIC>(arg0, 9, b"DOGMATIC", b"Dogwifmask", b"Just a dog with mask", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e715d410-0207-4e10-8ee7-5997f616184f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGMATIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGMATIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

