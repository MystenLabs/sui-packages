module 0x780d4a3f06d2dbb7afecdc5bb36a8a9c0d756b0f533e7d2805a34e195ba85d3e::dogmatic {
    struct DOGMATIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGMATIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGMATIC>(arg0, 9, b"DOGMATIC", b"Dogwifmask", b"Just a dog with mask", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b1c02ca2-b91e-4c67-88c6-f192e87ab54f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGMATIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGMATIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

