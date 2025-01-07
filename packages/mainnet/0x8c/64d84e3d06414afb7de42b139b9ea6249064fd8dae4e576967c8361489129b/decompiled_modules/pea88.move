module 0x8c64d84e3d06414afb7de42b139b9ea6249064fd8dae4e576967c8361489129b::pea88 {
    struct PEA88 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEA88, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEA88>(arg0, 9, b"PEA88", b"Peanut", b"Leanut is the extremely cute puppy of a young billionaire.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fc3ff8d0-66d9-48c6-9037-7c69e039d51c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEA88>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEA88>>(v1);
    }

    // decompiled from Move bytecode v6
}

