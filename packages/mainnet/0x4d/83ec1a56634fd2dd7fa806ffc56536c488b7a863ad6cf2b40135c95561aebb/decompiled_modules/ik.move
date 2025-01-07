module 0x4d83ec1a56634fd2dd7fa806ffc56536c488b7a863ad6cf2b40135c95561aebb::ik {
    struct IK has drop {
        dummy_field: bool,
    }

    fun init(arg0: IK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IK>(arg0, 9, b"IK", b"Ikay", b"Just a chill dude, out here to chill and relax.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b5ff0b4a-2cca-4524-951b-70d59bb80368.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IK>>(v1);
    }

    // decompiled from Move bytecode v6
}

