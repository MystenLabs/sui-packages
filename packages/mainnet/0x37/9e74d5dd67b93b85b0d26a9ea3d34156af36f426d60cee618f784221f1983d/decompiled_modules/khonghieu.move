module 0x379e74d5dd67b93b85b0d26a9ea3d34156af36f426d60cee618f784221f1983d::khonghieu {
    struct KHONGHIEU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHONGHIEU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHONGHIEU>(arg0, 9, b"KHONGHIEU", b"Milkmilkxi", x"42c3a9204d696c6b2078696e68206e676f616e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4dbba9b6-7119-4874-9d02-0bdc3ca5dd96.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHONGHIEU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KHONGHIEU>>(v1);
    }

    // decompiled from Move bytecode v6
}

