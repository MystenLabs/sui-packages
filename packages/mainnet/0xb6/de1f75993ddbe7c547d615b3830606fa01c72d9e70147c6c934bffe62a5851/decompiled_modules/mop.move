module 0xb6de1f75993ddbe7c547d615b3830606fa01c72d9e70147c6c934bffe62a5851::mop {
    struct MOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOP>(arg0, 9, b"MOP", b"CC", b"Cc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/25377ed1-616e-4c53-b536-8d4282863052.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

