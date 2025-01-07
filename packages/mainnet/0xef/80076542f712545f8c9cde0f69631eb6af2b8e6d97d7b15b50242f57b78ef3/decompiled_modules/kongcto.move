module 0xef80076542f712545f8c9cde0f69631eb6af2b8e6d97d7b15b50242f57b78ef3::kongcto {
    struct KONGCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KONGCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KONGCTO>(arg0, 6, b"KongCto", b"Kong Cto", x"546865204b6f6e67206f662074686520537569204e6574776f726b2e43746f0a0a68747470733a2f2f7777772e6b6f6e676f6e7375692e6f72672f0a68747470733a2f2f782e636f6d2f6b6f6e676f6e7375690a68747470733a2f2f742e6d652f4b6f6e676f6e7375690a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000051002_d38012e9a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KONGCTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KONGCTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

