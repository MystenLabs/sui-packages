module 0x12864bec7544c8e4ce1ccd03e4dcb17c69fd083c0f10bc3e7819cbc81c9b2d7f::beautidog {
    struct BEAUTIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAUTIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAUTIDOG>(arg0, 6, b"BeautiDog", b"the most beautiful dog", b"the most beautiful dog on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/thmb_6d27518991.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAUTIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEAUTIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

