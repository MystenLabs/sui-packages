module 0x7f79ba22516a0a6d5a80aa9682b0cc7e8888fbc8270a291c8282866b2ad11ee2::tmn {
    struct TMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMN>(arg0, 9, b"TMN", b"TIMMYTon", b"San", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/191e4a4a-748c-4b66-b77e-0769458cf8a4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

