module 0x72d5d9796bad99f194e3d5006e91b0d4999e79489f1d127d6ee4678e445e0b6::zks {
    struct ZKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZKS>(arg0, 6, b"ZKS", b"zk", b"ZK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732482125831.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZKS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZKS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

