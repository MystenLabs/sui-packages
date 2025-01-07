module 0x547e218ceab873ea83b0bbbe01f3d09dbbb96724d0d67f1016f140128ea58f0f::sui2100 {
    struct SUI2100 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI2100, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI2100>(arg0, 6, b"SUI2100", b"SUI MSTR 2100", x"244d5354523a20323130302043727970746f20656e7468757369617374732c206c6564206279206120626f6c642043454f2c2020737461636b656420746865697220736174732c20616e642063726f776e656420697420746865206b696e67206f662063727970746f2073746f636b732e0a0a506f7274616c203a2068747470733a2f2f742e6d652f4d53545232313030506f7274616c0a0a57656273697465203a2068747470733a2f2f6d737472323130302e636f6d0a0a547769747465722028202029203a2068747470733a2f2f782e636f6d2f4d53545232313030", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3500_72d27f5ce6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI2100>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI2100>>(v1);
    }

    // decompiled from Move bytecode v6
}

