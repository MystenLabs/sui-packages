module 0xabf20da0e08e88be2585a0ac9e4fa34a65847d7c24dce0ba2646f37f258b47c7::pepesui {
    struct PEPESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPESUI>(arg0, 6, b"PEPESUI", b"Pepe Sui", x"5468652074727565206d656d65206b696e67202450455045206973206e6f77206f6e2023535549200a0a68747470733a2f2f782e636f6d2f50657065537569782f7374617475732f313833383835343531353230373837323734393f743d556b4c387357474f3877697852676936626b6933774126733d3335", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026540_9648a77def.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

