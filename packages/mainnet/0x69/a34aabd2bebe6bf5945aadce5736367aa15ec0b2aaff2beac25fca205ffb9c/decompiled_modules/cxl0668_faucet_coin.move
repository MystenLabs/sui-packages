module 0x69a34aabd2bebe6bf5945aadce5736367aa15ec0b2aaff2beac25fca205ffb9c::cxl0668_faucet_coin {
    struct CXL0668_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CXL0668_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CXL0668_FAUCET_COIN>(arg0, 8, b"CXL0668_FAUCET_COIN", b"CXL0668_FAUCET_COIN", b"This is my faucet coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/138219491")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CXL0668_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CXL0668_FAUCET_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

