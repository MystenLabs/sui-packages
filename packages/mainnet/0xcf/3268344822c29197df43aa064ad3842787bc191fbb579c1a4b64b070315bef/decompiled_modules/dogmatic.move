module 0xcf3268344822c29197df43aa064ad3842787bc191fbb579c1a4b64b070315bef::dogmatic {
    struct DOGMATIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGMATIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGMATIC>(arg0, 9, b"DOGMATIC", b"Dogwifmask", b"Just a dog with mask", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cb9cef57-c8e1-443b-8ff7-abe1d75f4fc1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGMATIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGMATIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

