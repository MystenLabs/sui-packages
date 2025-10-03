module 0x9e71c63ec30d6cacfd0b56889cde4b7933c86f1ea602e17fac2dd3448ab9bbf9::myym {
    struct MYYM has drop {
        dummy_field: bool,
    }

    struct TreasuryCapHolder<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<T0>,
    }

    public entry fun burn_tokens(arg0: &mut TreasuryCapHolder<MYYM>, arg1: 0x2::coin::Coin<MYYM>) {
        0x2::coin::burn<MYYM>(&mut arg0.treasury, arg1);
    }

    fun init(arg0: MYYM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYYM>(arg0, 9, b"MYYM", b"theMYYM", b"Testing coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYYM>>(v1);
        let v2 = TreasuryCapHolder<MYYM>{
            id       : 0x2::object::new(arg1),
            treasury : v0,
        };
        0x2::transfer::public_transfer<TreasuryCapHolder<MYYM>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_tokens(arg0: &mut TreasuryCapHolder<MYYM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<MYYM>(&arg0.treasury) + arg1 <= 1000000000000000000, 1);
        0x2::coin::mint_and_transfer<MYYM>(&mut arg0.treasury, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

