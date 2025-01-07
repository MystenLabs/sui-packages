module 0xf3db8e41a11fca1719af21a24683772d6655c293aacc9aab349b225afae53412::cam {
    struct CAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAM>(arg0, 9, b"CAM", b"camera", b"CAMERA ROLL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7b6e7472-466d-420b-90ff-10b2552f5ebb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

