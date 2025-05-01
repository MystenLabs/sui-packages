module 0x65a63a647010c79c7c0ccf6c53433939150900714026dd7e34f3a7b68cba8ee5::ducke {
    struct DUCKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKE>(arg0, 6, b"Ducke", b"Ducke Sui", b"$Ducke  The Corporate Blue Duck Is Here!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1746130729_839592_5_ECC_80_C5_BCF_3_4_AF_8_B7_E5_48_F076973_C76_dfffe07c69.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

