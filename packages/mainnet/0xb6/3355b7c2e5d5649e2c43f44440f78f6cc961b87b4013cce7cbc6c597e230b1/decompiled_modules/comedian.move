module 0xb63355b7c2e5d5649e2c43f44440f78f6cc961b87b4013cce7cbc6c597e230b1::comedian {
    struct COMEDIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMEDIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMEDIAN>(arg0, 9, b"COMEDIAN", b"BAN", b"Banana on the wall", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e3f6ed0f-0899-4d4d-8b1f-4122a635cd6c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMEDIAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COMEDIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

