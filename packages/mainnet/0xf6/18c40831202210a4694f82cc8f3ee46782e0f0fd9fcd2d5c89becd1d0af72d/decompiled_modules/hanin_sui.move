module 0xf618c40831202210a4694f82cc8f3ee46782e0f0fd9fcd2d5c89becd1d0af72d::hanin_sui {
    struct HANIN_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANIN_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANIN_SUI>(arg0, 9, b"haninSUI", b"Hanin02 Staked SUI", b"Hanin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/795d73ca-2834-4130-93ee-e2bc28594007/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANIN_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANIN_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

