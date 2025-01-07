module 0xeb0895aba72be58faff7c6d86e2cec706b5ac4b3ef1904fab0252ec1188f0c0f::linh {
    struct LINH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LINH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LINH>(arg0, 9, b"LINH", b"linhcan", b"CANCAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d5e34a85-b52b-440c-9f12-5a776ab79b6a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LINH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LINH>>(v1);
    }

    // decompiled from Move bytecode v6
}

