module 0xda7a4454e86cedb62ae14a0c714667679a850eb47138334d7272b54f6b022790::tekin {
    struct TEKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEKIN>(arg0, 6, b"TEKIN", b"TechnoViking", x"54454b494e472069732061206d656d65636f696e206f6e207468652053554920626c6f636b636861696e20696e73706972656420627920546563686e6f76696b696e672c206f6e65206f662074686520696e7465726e6574277320666972737420766972616c206d656d65732c20696d6d6f7274616c697a6564206174204265726c696e2773204675636b70617261646520696e20323030302e20f09f949768747470733a2f2f74656b696e672e77656262792e66756e2f2020f09f949768747470733a2f2f782e636f6d2f54454b494e47636f696e737569200af09f949768747470733a2f2f742e6d652f54656b696e67436f696e50", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736601376662.u3")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEKIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEKIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

