module 0xd323517cffe6c6d4c64a0b5c508a2c0b029694fa3b92ecaf19a4271d8bcc5e9d::jeeter {
    struct JEETER has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEETER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEETER>(arg0, 6, b"JEETER", b"FAKE PUMP JEETER vs JEETER", b"Jeeter is our Culture", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/JEETER_b85bbe4e13.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEETER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JEETER>>(v1);
    }

    // decompiled from Move bytecode v6
}

