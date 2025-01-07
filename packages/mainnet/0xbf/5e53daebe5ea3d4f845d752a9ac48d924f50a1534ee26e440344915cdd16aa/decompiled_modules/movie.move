module 0x38b21ea81bd5b17e7f19aaa95a92fec6a5b217399fdab541ccb73684de6a6d97::movie {
    struct MOVIE has drop {
        dummy_field: bool,
    }

    struct ProtectedTreasury has key {
        id: 0x2::object::UID,
    }

    struct TreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MintCap has key {
        id: 0x2::object::UID,
    }

    public entry fun burn(arg0: &mut ProtectedTreasury, arg1: 0x2::coin::Coin<MOVIE>) {
        0x2::coin::burn<MOVIE>(borrow_mutable_cap(arg0), arg1);
    }

    public fun total_supply(arg0: &mut ProtectedTreasury) : u64 {
        0x2::coin::total_supply<MOVIE>(borrow_cap(arg0))
    }

    fun borrow_cap(arg0: &ProtectedTreasury) : &0x2::coin::TreasuryCap<MOVIE> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<TreasuryCapKey, 0x2::coin::TreasuryCap<MOVIE>>(&arg0.id, v0)
    }

    fun borrow_mutable_cap(arg0: &mut ProtectedTreasury) : &mut 0x2::coin::TreasuryCap<MOVIE> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<MOVIE>>(&mut arg0.id, v0)
    }

    fun init(arg0: MOVIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVIE>(arg0, 8, b"MOVIE", b"Moviecoin", b"Decentralized Broadcasting", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://kigccum7iejpdox7kp72f6u7iq4xw5aw2f722hkiqiko7u2fvrwq.arweave.net/UgwhUZ9BEvG6_1P_ovqfRDl7dBbRf60dSIIU79NFrG0"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOVIE>>(v1);
        let v3 = ProtectedTreasury{id: 0x2::object::new(arg1)};
        0x2::coin::mint_and_transfer<MOVIE>(&mut v2, 12000000000000000000, @0xbad7acf2df03487279c0a4b7f0bccc885233067c190dc096e4ef7457439ffccf, arg1);
        let v4 = MintCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MintCap>(v4, @0xbad7acf2df03487279c0a4b7f0bccc885233067c190dc096e4ef7457439ffccf);
        let v5 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<MOVIE>>(&mut v3.id, v5, v2);
        0x2::transfer::share_object<ProtectedTreasury>(v3);
    }

    public entry fun mint(arg0: &MintCap, arg1: &mut ProtectedTreasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_mutable_cap(arg1);
        assert!(0x2::coin::total_supply<MOVIE>(v0) + arg2 * 100000000 <= 12000000000000000000, 5);
        0x2::coin::mint_and_transfer<MOVIE>(v0, arg2 * 100000000, @0xbad7acf2df03487279c0a4b7f0bccc885233067c190dc096e4ef7457439ffccf, arg3);
    }

    public entry fun transfer_mint_cap(arg0: MintCap) {
        let MintCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

