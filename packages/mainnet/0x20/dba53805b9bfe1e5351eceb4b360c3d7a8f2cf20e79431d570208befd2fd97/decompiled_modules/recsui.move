module 0x20dba53805b9bfe1e5351eceb4b360c3d7a8f2cf20e79431d570208befd2fd97::recsui {
    struct RECSUI has drop {
        dummy_field: bool,
    }

    struct GlobalStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<RECSUI>,
    }

    public(friend) fun borrow_mut_supply(arg0: &mut GlobalStorage) : &mut 0x2::balance::Supply<RECSUI> {
        &mut arg0.supply
    }

    fun init(arg0: RECSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RECSUI>(arg0, 9, b"recSUI", b"ReceiptSUI Token", b"recSUI is a receipt for BaySwap's IDO. recSUI can be used to convert to BSWT when the mainnet launches.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.bayswap.io/recsui.png")), arg1);
        let v2 = GlobalStorage{
            id     : 0x2::object::new(arg1),
            supply : 0x2::coin::treasury_into_supply<RECSUI>(v0),
        };
        0x2::transfer::share_object<GlobalStorage>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RECSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

