module 0xd692e8ed4de19534bf61a01c133f47408ada79c9f6094ae12dfa668a6a36fb8d::lufi {
    struct LUFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUFI>(arg0, 9, b"LUFI", b"Lufi", b"Lufi on Wavewallet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/519bf417-8f4a-4772-b77c-8abdd6ccb429.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

