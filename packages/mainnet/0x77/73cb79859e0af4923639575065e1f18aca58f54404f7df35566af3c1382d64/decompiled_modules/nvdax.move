module 0x7773cb79859e0af4923639575065e1f18aca58f54404f7df35566af3c1382d64::nvdax {
    struct NVDAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: NVDAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NVDAX>(arg0, 9, b"NVDAX", b"NvdaX", b"ZO Virtual Coin for Nvidia X Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NVDAX>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NVDAX>>(v0);
    }

    // decompiled from Move bytecode v6
}

