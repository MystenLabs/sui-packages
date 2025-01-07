module 0x476512a9f428a6449854883b33153e130c96b4a27543a0af57b6c553ef3a9a3d::bir {
    struct BIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIR>(arg0, 6, b"BIR", x"42697463682049e280996d2052696368", x"42697463682c2049e280996d2052696368", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732463901222.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

