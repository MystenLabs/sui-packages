module 0xf0a8712da53258f7ff34ddcda4d4c54bb5a423566755ed242a39263e4311dac9::sim {
    struct SIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIM>(arg0, 6, b"SIM", b"Simpson", x"53696d70736f6e206f6e20486f702046756e200a0a5472616465206f6e20537569207573696e6720486f70", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730951674643.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

