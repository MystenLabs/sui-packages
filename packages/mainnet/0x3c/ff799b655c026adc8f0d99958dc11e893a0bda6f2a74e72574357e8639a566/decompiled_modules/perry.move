module 0x3cff799b655c026adc8f0d99958dc11e893a0bda6f2a74e72574357e8639a566::perry {
    struct PERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PERRY>(arg0, 9, b"PERRY", b"Perry ", b"Perry on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fcf2d341-a332-4e50-8e28-5f32aa579982.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

