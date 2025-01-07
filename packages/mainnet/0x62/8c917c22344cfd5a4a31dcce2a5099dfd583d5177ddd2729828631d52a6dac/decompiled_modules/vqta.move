module 0x628c917c22344cfd5a4a31dcce2a5099dfd583d5177ddd2729828631d52a6dac::vqta {
    struct VQTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VQTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VQTA>(arg0, 9, b"VQTA", b"Vaquita", x"4920616d20746865206d6f7374202072617265207370656369657320696e2074686520776f726c642e2e6a7573742031302072656d61696e696e6720696e207468652077696c642e43616e20796f752068656c70206d6520746f20696e637265617365206d792066616d696c7920f09f9295", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/baa5a630-b8f6-4f93-8d28-f63ecb651c79.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VQTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VQTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

