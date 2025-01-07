module 0x9ce1a6ffc764284fb2300dce800b6ac5210b9772697f79061a1ebd7684d44eb2::man {
    struct MAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAN>(arg0, 9, b"MAN", b"Free", b"Freeman", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/55150b9f-05b5-4624-a063-4128a995e0a1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

