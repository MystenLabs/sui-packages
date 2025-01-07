module 0xa6c70dcd1129c748db2f9ce66d98cbaa4ae00ab17b0a4f571b16b93c4afab36d::fos {
    struct FOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOS>(arg0, 9, b"FOS", b"Front ", b"The first thing I noticed when ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e279836e-5d13-4d7d-bc88-890ba737fdc8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

