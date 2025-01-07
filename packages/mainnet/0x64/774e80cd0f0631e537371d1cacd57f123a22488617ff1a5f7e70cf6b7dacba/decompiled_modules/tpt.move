module 0x64774e80cd0f0631e537371d1cacd57f123a22488617ff1a5f7e70cf6b7dacba::tpt {
    struct TPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPT>(arg0, 9, b"TPT", b"GOD PORI ", b"We are very sincere", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/98068caf-3fbb-4292-9335-6c47b9bb1f4f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

