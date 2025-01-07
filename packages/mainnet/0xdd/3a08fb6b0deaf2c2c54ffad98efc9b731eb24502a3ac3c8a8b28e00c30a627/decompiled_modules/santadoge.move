module 0xdd3a08fb6b0deaf2c2c54ffad98efc9b731eb24502a3ac3c8a8b28e00c30a627::santadoge {
    struct SANTADOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANTADOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANTADOGE>(arg0, 6, b"SANTADOGE", b"SANTA DOGE COIN", b"anta Doge Coin ($SANTADOGE) is a community-driven, holiday-themed crypto built on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_802de95840.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANTADOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANTADOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

