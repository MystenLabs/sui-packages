module 0xb1619ce6da9fca03335e7cdf557f09d235fe63b62252b535197b28960b032948::burn {
    struct BURN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURN>(arg0, 6, b"Burn", b"Sui Burn", b"HODL DEX BURN MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fire_and_Water2_6bc6d6f66a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BURN>>(v1);
    }

    // decompiled from Move bytecode v6
}

