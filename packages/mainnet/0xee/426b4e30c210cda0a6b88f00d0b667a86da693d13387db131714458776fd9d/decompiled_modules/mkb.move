module 0xee426b4e30c210cda0a6b88f00d0b667a86da693d13387db131714458776fd9d::mkb {
    struct MKB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MKB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MKB>(arg0, 9, b"MKB", b"Memek Bau", b"nyuyul doang bang", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d861ca32-3227-4d1d-8761-ccbfd90ff923.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MKB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MKB>>(v1);
    }

    // decompiled from Move bytecode v6
}

