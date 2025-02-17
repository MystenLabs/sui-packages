module 0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal {
    struct WAL has drop {
        dummy_field: bool,
    }

    struct ProtectedTreasury has key {
        id: 0x2::object::UID,
    }

    struct TreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut ProtectedTreasury, arg1: 0x2::coin::Coin<WAL>) {
        0x2::coin::burn<WAL>(borrow_cap_mut(arg0), arg1);
    }

    public fun total_supply(arg0: &ProtectedTreasury) : u64 {
        0x2::coin::total_supply<WAL>(borrow_cap(arg0))
    }

    fun borrow_cap(arg0: &ProtectedTreasury) : &0x2::coin::TreasuryCap<WAL> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<TreasuryCapKey, 0x2::coin::TreasuryCap<WAL>>(&arg0.id, v0)
    }

    fun borrow_cap_mut(arg0: &mut ProtectedTreasury) : &mut 0x2::coin::TreasuryCap<WAL> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<WAL>>(&mut arg0.id, v0)
    }

    fun init(arg0: WAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAL>(arg0, 9, b"WAL", b"WAL Token", b"The native token for the Walrus Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.walrus.xyz/wal-icon.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAL>>(v1);
        let v3 = ProtectedTreasury{id: 0x2::object::new(arg1)};
        let v4 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<WAL>>(&mut v3.id, v4, v2);
        0x2::transfer::share_object<ProtectedTreasury>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<WAL>>(0x2::coin::mint<WAL>(&mut v2, 5000000000 * 0x1::u64::pow(10, 9), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

