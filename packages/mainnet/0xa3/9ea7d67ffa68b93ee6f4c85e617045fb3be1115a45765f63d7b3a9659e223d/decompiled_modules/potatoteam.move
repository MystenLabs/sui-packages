module 0xa39ea7d67ffa68b93ee6f4c85e617045fb3be1115a45765f63d7b3a9659e223d::potatoteam {
    struct POTATOTEAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: POTATOTEAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POTATOTEAM>(arg0, 9, b"POTATOTEAM", b"Potato", x"4e657720616476656e7475726573206f6620706f7461746f65730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e0a5d621-27e8-4354-bb2b-133ba9d7c47b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POTATOTEAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POTATOTEAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

