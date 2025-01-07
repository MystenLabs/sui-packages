module 0x74639f328aab5c41eac6eba5ee0150bb7bccd8b2c460f22ed9b097fb6726a21e::dogmatic {
    struct DOGMATIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGMATIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGMATIC>(arg0, 9, b"DOGMATIC", b"Dogwifmask", b"Just a dog with mask", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/22945926-baa2-4a17-bd3d-795e26b26aa1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGMATIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGMATIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

