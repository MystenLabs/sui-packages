module 0xfcbab28391b7f906d35b2c7eb3e9a2195602833d3b64251ab5df6b8f92ba32f7::oni {
    struct ONI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONI>(arg0, 9, b"ONI", b"Onion", b"Onions are good for health and yet they are in tokens too.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c9c11a0f-be58-47e2-92b3-2bb2faa30f50.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONI>>(v1);
    }

    // decompiled from Move bytecode v6
}

