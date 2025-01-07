module 0x852262a466b1ce6aef8f77bbb9fa567e768a1f29a66a3577bf959f2a111db78f::really {
    struct REALLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: REALLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REALLY>(arg0, 9, b"REALLY", b"Really???", b"Babiboo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e610eff6-c91e-4412-b808-3d9bbb1c5680.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REALLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REALLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

