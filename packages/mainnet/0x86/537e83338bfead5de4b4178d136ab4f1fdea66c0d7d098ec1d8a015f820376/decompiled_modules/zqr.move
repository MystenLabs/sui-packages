module 0x86537e83338bfead5de4b4178d136ab4f1fdea66c0d7d098ec1d8a015f820376::zqr {
    struct ZQR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZQR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZQR>(arg0, 9, b"ZQR", b"Zhaqor", b"Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/83ec66bf-15f4-4902-a969-a827791a1af9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZQR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZQR>>(v1);
    }

    // decompiled from Move bytecode v6
}

