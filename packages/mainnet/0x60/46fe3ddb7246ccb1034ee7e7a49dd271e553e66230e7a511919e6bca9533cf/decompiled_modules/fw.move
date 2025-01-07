module 0x6046fe3ddb7246ccb1034ee7e7a49dd271e553e66230e7a511919e6bca9533cf::fw {
    struct FW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FW>(arg0, 9, b"FW", b"Farinwata", x"4d656d6520746f6b656e20666f72207468652064616d6e65642c204e6f2076616c756520617420616c6c2c2062757920617420796f7572206f776e207269736b20f09f989c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b6b2dfbc-75f5-437f-ab4f-3d6630f74500.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FW>>(v1);
    }

    // decompiled from Move bytecode v6
}

