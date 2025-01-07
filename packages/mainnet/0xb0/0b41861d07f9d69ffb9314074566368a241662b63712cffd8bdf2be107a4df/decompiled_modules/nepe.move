module 0xb00b41861d07f9d69ffb9314074566368a241662b63712cffd8bdf2be107a4df::nepe {
    struct NEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEPE>(arg0, 6, b"NEPE", b"NEPE_SUI", x"436f6d62696e65642077652077696c6c207269736520616e64206265636f6d6520746865206e756d626572202331206d656d65636f696e20696e207468652073706163652120200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pp0q_R0_K_400x400_ae4e47b377.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

