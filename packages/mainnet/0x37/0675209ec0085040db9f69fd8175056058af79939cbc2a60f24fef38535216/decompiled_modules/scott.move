module 0x370675209ec0085040db9f69fd8175056058af79939cbc2a60f24fef38535216::scott {
    struct SCOTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCOTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCOTT>(arg0, 9, b"SCOTT", b"Scott", x"4920616e6420612020776972652068616972656420506f727475677565736520706f64656e676f2c206d79206e616d652069732053636f747420616e6420492077616e7420746f206d616b6520757320616c6c20f09f98832e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9b1a9c16-b319-4aec-a907-19367159c325.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCOTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCOTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

