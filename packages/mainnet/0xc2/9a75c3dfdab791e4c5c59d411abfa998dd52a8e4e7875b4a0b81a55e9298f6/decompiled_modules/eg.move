module 0xc29a75c3dfdab791e4c5c59d411abfa998dd52a8e4e7875b4a0b81a55e9298f6::eg {
    struct EG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EG>(arg0, 9, b"EG", b"Egwu(fear)", b"The Fear Of The Enemies ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/59a5af66-9574-45d7-b811-2b1a23d8f019.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EG>>(v1);
    }

    // decompiled from Move bytecode v6
}

