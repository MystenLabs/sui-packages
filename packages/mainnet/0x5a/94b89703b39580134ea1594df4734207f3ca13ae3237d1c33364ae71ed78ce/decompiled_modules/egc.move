module 0x5a94b89703b39580134ea1594df4734207f3ca13ae3237d1c33364ae71ed78ce::egc {
    struct EGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGC>(arg0, 6, b"EGC", b"Eagle Coin", b"Eagle has always been a symbol of power for different cultures throughout history.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732225616861.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EGC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

