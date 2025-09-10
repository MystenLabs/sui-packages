module 0x931739984670bc9d1af4f1f1a9f5a4445066f591f8776ca148a55fe406d82929::xp_share {
    struct XP_SHARE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<XP_SHARE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<XP_SHARE>>(0x2::coin::mint<XP_SHARE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: XP_SHARE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XP_SHARE>(arg0, 0, b"T_XP_Share", b"XP Shares Test", b"XP Shares Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/31462.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XP_SHARE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XP_SHARE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

