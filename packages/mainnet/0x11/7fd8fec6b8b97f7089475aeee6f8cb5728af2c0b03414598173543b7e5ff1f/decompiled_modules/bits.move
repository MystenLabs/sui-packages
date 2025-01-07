module 0x117fd8fec6b8b97f7089475aeee6f8cb5728af2c0b03414598173543b7e5ff1f::bits {
    struct BITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITS>(arg0, 6, b"BITS", b"Bitscoin", b"Bitscoin is a Bitcoin substitute for lightning fast transactions with low transfer fees.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735446258576.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

