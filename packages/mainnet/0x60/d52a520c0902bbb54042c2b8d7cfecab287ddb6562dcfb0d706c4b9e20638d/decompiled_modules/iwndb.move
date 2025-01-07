module 0x60d52a520c0902bbb54042c2b8d7cfecab287ddb6562dcfb0d706c4b9e20638d::iwndb {
    struct IWNDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: IWNDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IWNDB>(arg0, 9, b"IWNDB", b"bxnd", b"jdnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/866e5492-e9d9-4145-9441-b99deeeea12b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IWNDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IWNDB>>(v1);
    }

    // decompiled from Move bytecode v6
}

