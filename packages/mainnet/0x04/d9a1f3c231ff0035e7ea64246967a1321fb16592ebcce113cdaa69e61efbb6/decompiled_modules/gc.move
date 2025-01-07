module 0x4d9a1f3c231ff0035e7ea64246967a1321fb16592ebcce113cdaa69e61efbb6::gc {
    struct GC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GC>(arg0, 6, b"GC", b"GODCAT", b"GODCAT A NEW HYPE COIN SOON ..i..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730984712363.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

