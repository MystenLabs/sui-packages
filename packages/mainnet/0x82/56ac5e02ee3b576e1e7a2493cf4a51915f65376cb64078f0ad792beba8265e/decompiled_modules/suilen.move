module 0x8256ac5e02ee3b576e1e7a2493cf4a51915f65376cb64078f0ad792beba8265e::suilen {
    struct SUILEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILEN>(arg0, 9, b"SUILEN", b"Sui LEN", b"Memecoin Bitcoin creator and founder in Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/73f6b35e-0642-4505-80ce-38d15796a0db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUILEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

