module 0x305eca1378cf87ef7d5e60156d4ceb9d5da73e46d583950701bf6a67fc57a7ef::moof {
    struct MOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOF>(arg0, 6, b"MOOF", b"Moof on Sui", x"4d4f4f46202d204d6f6f206d6f6e65792c206d6f6f2070726f626c656d732c206d6f6f666572666f6f6b65722e200a0a576562736974653a2068747470733a2f2f6d6f6f662e726f636b730a583a2068747470733a2f2f782e636f6d2f6d6f6f66726f636b730a54656c656772616d3a2068747470733a2f2f742e6d652f6d6f6f66726f636b730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241219_213125_693_d49316a2ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

