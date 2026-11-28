module 0x383a340474c492140e6b4e1be0e18fbe01a3af5fe4c508c4f69a1564020fe538::xant {
    struct XANT has drop {
        dummy_field: bool,
    }

    struct TreasuryLock has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<XANT>,
    }

    fun init(arg0: XANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XANT>(arg0, 9, b"xANT", b"xANT", b"Fixed-supply xANT token on Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XANT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<XANT>>(0x2::coin::mint<XANT>(&mut v2, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        let v3 = TreasuryLock{
            id           : 0x2::object::new(arg1),
            treasury_cap : v2,
        };
        0x2::transfer::public_freeze_object<TreasuryLock>(v3);
    }

    // decompiled from Move bytecode v7
}

