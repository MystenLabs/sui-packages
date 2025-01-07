module 0x87cc95fce61143ccb8ff647f9cbb37d94c922e81442822f6874a273e43c90e46::xex {
    struct XEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XEX>(arg0, 9, b"XEX", b"Rex", b"Esd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/26ee78dd-8215-454b-b33b-9d42f8e652b8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

