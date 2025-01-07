module 0x43c04d23d156613970b5f788445f2c6877c35a17cf1d4770bd0cc135255900ff::jethro_coin {
    struct JETHRO_COIN has drop {
        dummy_field: bool,
    }

    struct TreasuryCapHolder has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<JETHRO_COIN>,
    }

    entry fun mint(arg0: &mut TreasuryCapHolder, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<JETHRO_COIN>>(0x2::coin::mint<JETHRO_COIN>(&mut arg0.treasury_cap, arg1, arg3), arg2);
    }

    fun init(arg0: JETHRO_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JETHRO_COIN>(arg0, 9, b"JETHRO_COIN", b"jethro coin", b"jethro token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JETHRO_COIN>>(v1);
        let v2 = TreasuryCapHolder{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::share_object<TreasuryCapHolder>(v2);
    }

    // decompiled from Move bytecode v6
}

