module 0xc9b36bebe0192a41c3ca3e70d44106fbc82d9f6366ba0027a80aba3ef4e3e424::ram {
    struct RAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAM>(arg0, 6, b"RAM", b"Lord Ram", b"Truth is my strength, and righteousness is my weapon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_A758831_B03_C_4265_896_E_127_EF_512172_E_f306a44132.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

