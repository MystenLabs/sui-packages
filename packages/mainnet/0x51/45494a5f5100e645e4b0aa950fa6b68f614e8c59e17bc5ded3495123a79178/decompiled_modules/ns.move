module 0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns {
    struct NS has drop {
        dummy_field: bool,
    }

    struct ProtectedTreasury has key {
        id: 0x2::object::UID,
    }

    struct TreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun total_supply(arg0: &ProtectedTreasury) : u64 {
        0x2::coin::total_supply<NS>(borrow_cap(arg0))
    }

    fun borrow_cap(arg0: &ProtectedTreasury) : &0x2::coin::TreasuryCap<NS> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<TreasuryCapKey, 0x2::coin::TreasuryCap<NS>>(&arg0.id, v0)
    }

    fun create_coin(arg0: NS, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (ProtectedTreasury, 0x2::coin::Coin<NS>) {
        let (v0, v1) = 0x2::coin::create_currency<NS>(arg0, 6, b"NS", b"SuiNS Token", b"The native token for the SuiNS Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://token-image.suins.io/icon.svg")), arg2);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NS>>(v1);
        let v3 = ProtectedTreasury{id: 0x2::object::new(arg2)};
        let v4 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<NS>>(&mut v3.id, v4, v2);
        (v3, 0x2::coin::mint<NS>(&mut v2, arg1, arg2))
    }

    fun init(arg0: NS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_coin(arg0, 500000000000000, arg1);
        0x2::transfer::share_object<ProtectedTreasury>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<NS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

