module 0xecf8d99dfc61b50eb28a9864a979bb1f4e1d7c925e2b45eccfbe5fd15dbf4cbf::pnt {
    struct PNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNT>(arg0, 9, b"PNT", b"Point", b" see point portocol on future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a9822c58-3e9d-4e33-bde4-99fcc67f56b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

