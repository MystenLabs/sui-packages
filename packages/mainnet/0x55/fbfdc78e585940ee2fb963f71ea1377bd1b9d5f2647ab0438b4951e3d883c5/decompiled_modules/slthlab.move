module 0x55fbfdc78e585940ee2fb963f71ea1377bd1b9d5f2647ab0438b4951e3d883c5::slthlab {
    struct SLTHLAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLTHLAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLTHLAB>(arg0, 6, b"SLTHLAB", b"The Sloths NFT Lab", x"53747261696768742066726f6d20536f6c616e610a4e465420436f6c6c656374696f6e0a476f7665726e616e636520546f6b656e0a4f6e20547572626f732e46756e206a75737420666f7220746865206d656d650a46696e64207573206f6e205820616e6420446973636f7264", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733596635349.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLTHLAB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLTHLAB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

