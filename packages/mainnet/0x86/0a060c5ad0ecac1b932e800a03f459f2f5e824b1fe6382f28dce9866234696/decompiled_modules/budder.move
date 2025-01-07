module 0x860a060c5ad0ecac1b932e800a03f459f2f5e824b1fe6382f28dce9866234696::budder {
    struct BUDDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUDDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUDDER>(arg0, 6, b"BUDDER", b"Budder Dawg", x"4d6565742042757474657273636f7463682053686962612c20746865206675727279207068656e6f6d656e6f6e20626f726e2066726f6d2050656172676f7227732063726561746976652067656e6975732e205374617274696e67206173207468652073746172206f662074686520766972616c20224e6f204d757474204e6f76656d6265722220766964656f2c2042757474657273636f74636820717569636b6c7920776f6e206865617274732e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6a5_746bd218cb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUDDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUDDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

