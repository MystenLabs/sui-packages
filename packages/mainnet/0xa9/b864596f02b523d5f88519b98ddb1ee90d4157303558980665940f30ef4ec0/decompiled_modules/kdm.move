module 0xa9b864596f02b523d5f88519b98ddb1ee90d4157303558980665940f30ef4ec0::kdm {
    struct KDM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KDM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KDM>(arg0, 6, b"KDM", b"Kang Dedi Mulyadi Ai", x"746865206c656164657220697320636c65616e2c20686f6e6573742c207472757374776f7274687920616e642070726f746563747320746865206c6974746c652070656f706c650a0a46726f6d2077657374204a61766120496e646f6e657369616e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1753768114380.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KDM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KDM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

