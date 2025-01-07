module 0x2c0336e74a0b3b34a1118e8cced89c59177635804af3505975e0f6f6f552a0b0::fiora {
    struct FIORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIORA>(arg0, 6, b"FIORA", b"Fiona On Sui", b"First Fiona On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_13_f63a09ca07.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIORA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIORA>>(v1);
    }

    // decompiled from Move bytecode v6
}

