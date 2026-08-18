module 0xf2c1e2755e57d62f98a8f564dbdef0b230ff4b34b6b1c17bfaa41ee4ab63bfde::ffffffffffff {
    struct FFFFFFFFFFFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFFFFFFFFFFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFFFFFFFFFFF>(arg0, 6, b"FFFFFFFFFFFF", b"asdff", b"ffff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FFFFFFFFFFFF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFFFFFFFFFFF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

