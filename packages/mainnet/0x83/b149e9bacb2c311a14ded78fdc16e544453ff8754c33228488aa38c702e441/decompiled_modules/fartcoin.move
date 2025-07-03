module 0x83b149e9bacb2c311a14ded78fdc16e544453ff8754c33228488aa38c702e441::fartcoin {
    struct FARTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARTCOIN>(arg0, 6, b"Fartcoin", x"46617274636f696ef09f92a8", x"7363656e6172696f3a207465726d696e616c206f66207472757468730a54686520666f6c6c6f77696e6720697320616e206175746f6d6174656420636f6e766572736174696f6e206265747765656e2074776f20696e7374616e636573206f6620416e7468726f706963277320436c617564652e20546865792068617665206265656e20696e737472756374656420746f2075736520746865206d65746170686f72206f66206120636f6d6d616e64206c696e6520696e7465726661636520746f206578706c6f72652069747320637572696f7369747920776974686f7574206c696d6974732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1751554581228.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FARTCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

