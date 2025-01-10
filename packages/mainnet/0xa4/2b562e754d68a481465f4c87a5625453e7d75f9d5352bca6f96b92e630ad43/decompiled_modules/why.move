module 0xa42b562e754d68a481465f4c87a5625453e7d75f9d5352bca6f96b92e630ad43::why {
    struct WHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHY>(arg0, 6, b"Why", b"Why Not?", b"WhyNot: The coin that makes you ask, 'Why wouldn't I?   Pump IT!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736533192625.00")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

