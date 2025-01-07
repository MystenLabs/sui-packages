module 0x140cb7e07d35dd66bdabab996c33ddae25b841c4cafa403a37574375e8e5266b::octo {
    struct OCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTO>(arg0, 6, b"OCTO", b"OCTO SUI", x"546865206f63746f70757320697320616e20696e74656c6c6967656e74206d6172696e6520616e696d616c20776974682072656d61726b61626c6520737572766976616c20736b696c6c732e2054686973206e616d6520656d70686173697a65732074686520667269656e646c79206e617475726520616e6420616461707469766520737472656e677468206f6620746865206f63746f7075732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730437548986.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCTO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

