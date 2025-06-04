module 0x417388ef04948871ccfbcae9fb3a10f6480cda9830eb58133102e7f9b5f53203::skel {
    struct SKEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKEL>(arg0, 6, b"SKEL", b"SKELETON", x"54686520556e646561642050756c7365206f66207468652053554920426c6f636b636861696e2e0a0a5768657468657220796f75277265207374616b696e6720796f757220636c61696d20696e20746865206372797074206f722074726164696e6720696e2074686520756e646572776f726c642c20534b454c2074687269766573207768657265206f746865727320726f74", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749032438784.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKEL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKEL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

