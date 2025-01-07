module 0xf178333fa40d661343aef534048f812ffcd4329ee654abc728aa905e0e4310e8::pufi {
    struct PUFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFI>(arg0, 9, b"PUFI", b"The Puffer", b"Puffer fish are cute and funny but have terrible self-defense.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2d54d969-8a51-4109-9b4d-322a85bc8b6c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

