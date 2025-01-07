module 0xd4fe7c5e45bd14e8e9b892f80e165b2ed258091f4eecf8306edb2a8b662a5dd3::pjsjsjs {
    struct PJSJSJS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PJSJSJS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PJSJSJS>(arg0, 9, b"PJSJSJS", b"Jshshs", b"Ksksjsjndbd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e53bf5dd-6d10-48a0-b034-8460e1b9749d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PJSJSJS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PJSJSJS>>(v1);
    }

    // decompiled from Move bytecode v6
}

