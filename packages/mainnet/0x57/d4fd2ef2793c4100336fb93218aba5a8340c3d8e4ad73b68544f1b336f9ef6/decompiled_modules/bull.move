module 0x57d4fd2ef2793c4100336fb93218aba5a8340c3d8e4ad73b68544f1b336f9ef6::bull {
    struct BULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULL>(arg0, 6, b"BULL", b"SBULL", x"5342554c4c20697320696e7370697265642062792074686520737472656e67746820616e6420636861726d206f66206120637574652062756c6c2e205765277265206861726e657373696e672074686520706f776572206f66206f75722064656469636174656420636f6d6d756e69747920746f206675656c206f757220726973652c2061696d696e6720746f206265636f6d6520746865206d6f737420726573696c69656e7420616e642062656c6f76656420746f6b656e20696e207468652063727970746f2073706163652e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suibull_4_dcb9db4059.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

