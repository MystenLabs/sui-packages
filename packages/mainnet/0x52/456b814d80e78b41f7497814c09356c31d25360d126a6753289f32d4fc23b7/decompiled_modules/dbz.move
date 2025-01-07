module 0x52456b814d80e78b41f7497814c09356c31d25360d126a6753289f32d4fc23b7::dbz {
    struct DBZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBZ>(arg0, 9, b"DBZ", b"Goku", b"Just take it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4f5a9d77-ed8a-408e-bb33-b548dd43f233.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DBZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

