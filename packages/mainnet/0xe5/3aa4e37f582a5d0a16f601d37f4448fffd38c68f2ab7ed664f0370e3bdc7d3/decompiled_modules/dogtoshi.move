module 0xe53aa4e37f582a5d0a16f601d37f4448fffd38c68f2ab7ed664f0370e3bdc7d3::dogtoshi {
    struct DOGTOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGTOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGTOSHI>(arg0, 6, b"DOGTOSHI", b"DOG TOSHi SUI", b"DOG TOSHI SUI BE BETTER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053961_21d82f3285.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGTOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGTOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

