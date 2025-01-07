module 0x937b1e777cbda423822f65725d89b88d8953bf2636134806cff40e611c1317a2::gundam {
    struct GUNDAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUNDAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUNDAM>(arg0, 9, b"GUNDAM", b"RobotGD", b"Capturing the awe-inspiring presence of a Generates a Gundam", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7eead961-28d7-4236-b738-211b380ce395.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUNDAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUNDAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

