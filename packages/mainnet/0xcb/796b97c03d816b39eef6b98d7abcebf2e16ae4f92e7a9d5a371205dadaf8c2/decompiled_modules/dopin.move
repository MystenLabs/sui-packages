module 0xcb796b97c03d816b39eef6b98d7abcebf2e16ae4f92e7a9d5a371205dadaf8c2::dopin {
    struct DOPIN has drop {
        dummy_field: bool,
    }

    struct ProtectedTreasury has key {
        id: 0x2::object::UID,
    }

    struct TreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut ProtectedTreasury, arg1: 0x2::coin::Coin<DOPIN>) {
        0x2::coin::burn<DOPIN>(borrow_cap_mut(arg0), arg1);
    }

    public fun total_supply(arg0: &ProtectedTreasury) : u64 {
        0x2::coin::total_supply<DOPIN>(borrow_cap(arg0))
    }

    fun borrow_cap(arg0: &ProtectedTreasury) : &0x2::coin::TreasuryCap<DOPIN> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<TreasuryCapKey, 0x2::coin::TreasuryCap<DOPIN>>(&arg0.id, v0)
    }

    fun borrow_cap_mut(arg0: &mut ProtectedTreasury) : &mut 0x2::coin::TreasuryCap<DOPIN> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<DOPIN>>(&mut arg0.id, v0)
    }

    fun init(arg0: DOPIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOPIN>(arg0, 9, b"DOPIN", b"Dopin the Dolphin", x"446f70696e2074686520446f6c7068696e20f09f90ac202d2074686520646f70656420636f6d6d756e69747920636f696e206d616b696e67207761766573206f6e20537569204e6574776f726b2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmYaNGP5RjLHw3KxRihjqY2opwUXp9vcfGRBdUBiXysjyB")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOPIN>>(v1);
        let v3 = ProtectedTreasury{id: 0x2::object::new(arg1)};
        let v4 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<DOPIN>>(&mut v3.id, v4, v2);
        0x2::transfer::share_object<ProtectedTreasury>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<DOPIN>>(0x2::coin::mint<DOPIN>(&mut v2, 9999999999000000000, arg1), @0x7ca745a675233336575f57170051d9c35f90c87ee8e7ba1c8ffda4ef1a8a6815);
    }

    // decompiled from Move bytecode v6
}

