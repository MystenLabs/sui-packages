module 0xd9e0d571792bb0f8cbacd4e3e8d5d98cc099cc0865421ffc93748892cf76c28d::zui {
    struct ZUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUI>(arg0, 6, b"Zui", b"Zuug", x"5a55492074686520616c69656e2c206865206c616e64656420696e20746865206f6365616e20616e6420776173686564207570206f6e205375692073686f726573200a0a546720616e6420736f6369616c7320636f6d696e6720617420626f6e6420", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4885_bf90ddb703.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

