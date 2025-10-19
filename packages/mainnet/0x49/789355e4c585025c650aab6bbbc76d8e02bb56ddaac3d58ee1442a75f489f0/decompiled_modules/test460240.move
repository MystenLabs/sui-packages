module 0x49789355e4c585025c650aab6bbbc76d8e02bb56ddaac3d58ee1442a75f489f0::test460240 {
    struct TEST460240 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST460240, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST460240>(arg0, 9, b"TEST460240", b"Test Token 460240", b"Token for testing complete lifecycle", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST460240>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST460240>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

