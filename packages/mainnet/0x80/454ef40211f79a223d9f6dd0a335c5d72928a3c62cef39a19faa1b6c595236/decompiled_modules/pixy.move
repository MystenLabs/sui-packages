module 0x80454ef40211f79a223d9f6dd0a335c5d72928a3c62cef39a19faa1b6c595236::pixy {
    struct PIXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIXY>(arg0, 9, b"PIXY", b"Pixel girl", b"Pixel girl token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bd4a2f5f-18f9-4977-be03-7b41411a94fe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIXY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

