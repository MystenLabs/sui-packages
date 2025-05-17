module 0xdb1a3b71ed2961a41dad7768343acb3d4f8dc9d5b2bcc47d2b61a3f80c75b5ac::dseek {
    struct DSEEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSEEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSEEK>(arg0, 6, b"DSEEK", b"Deepseek Sui", x"232323202a2af09f9a802024445345454b20e28093205468652041492d506f7765726564204d656d6520436f696e206f6e20537569212a2a200a2a2a225365656b2c204d656d652c20436f6e7175657221222a2a200a2a2af09f948d20576861742069732024445345454b3f2a2a200a24445345454b20697320746865202a2a756e6f6666696369616c2c20746f74616c6c79206162737572642a2a206d656d6520636f696e20696e73706972656420627920446565705365656b204149e2809462656361757365206576656e206172746966696369616c20696e74656c6c6967656e6365206e656564732061206c6974746c65206368616f7321204275696c740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747522356255.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSEEK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSEEK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

