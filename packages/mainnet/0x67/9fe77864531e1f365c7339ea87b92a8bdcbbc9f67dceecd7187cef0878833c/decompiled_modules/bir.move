module 0x679fe77864531e1f365c7339ea87b92a8bdcbbc9f67dceecd7187cef0878833c::bir {
    struct BIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIR>(arg0, 6, b"BIR", x"42697463682049e280996d205269636820", x"497420646f65736ee2809974206d6174746572207768617420796f75207361792e2054686520616e7377657220697320616c7761797320e2809c42697463682c2049e280996d2052696368e2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731960279528.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

