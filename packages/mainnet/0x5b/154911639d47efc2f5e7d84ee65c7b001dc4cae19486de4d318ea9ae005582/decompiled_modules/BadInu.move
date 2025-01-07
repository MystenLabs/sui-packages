module 0x5b154911639d47efc2f5e7d84ee65c7b001dc4cae19486de4d318ea9ae005582::BadInu {
    struct BADINU has drop {
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

    public entry fun burn(arg0: &mut ProtectedTreasury, arg1: 0x2::coin::Coin<BADINU>) {
        0x2::coin::burn<BADINU>(borrow_mutable_cap(arg0), arg1);
    }

    public fun total_supply(arg0: &mut ProtectedTreasury) : u64 {
        0x2::coin::total_supply<BADINU>(borrow_cap(arg0))
    }

    fun borrow_cap(arg0: &ProtectedTreasury) : &0x2::coin::TreasuryCap<BADINU> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<TreasuryCapKey, 0x2::coin::TreasuryCap<BADINU>>(&arg0.id, v0)
    }

    fun borrow_mutable_cap(arg0: &mut ProtectedTreasury) : &mut 0x2::coin::TreasuryCap<BADINU> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<BADINU>>(&mut arg0.id, v0)
    }

    fun init(arg0: BADINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADINU>(arg0, 4, b"BADINU", b"Bad Inu", b"Where Other Memecoins Come to Die", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bnv7c2vca7utfq2zvnzeef4i4fiqkjhh2igavtbyoyugdqzir6ua.arweave.net/C2vxaqIH6TLDWatyQheI4VEFJOfSDArMOHYoYcMoj6g"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BADINU>>(v1);
        let v3 = ProtectedTreasury{id: 0x2::object::new(arg1)};
        0x2::coin::mint_and_transfer<BADINU>(&mut v2, 5000000000000000000, @0xf7a2d249309c5a0bdd3e5cd368660d9409cea5c44c3b85eb67a3f9e083ec8a78, arg1);
        let v4 = MintCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MintCap>(v4, @0xf7a2d249309c5a0bdd3e5cd368660d9409cea5c44c3b85eb67a3f9e083ec8a78);
        let v5 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<BADINU>>(&mut v3.id, v5, v2);
        0x2::transfer::share_object<ProtectedTreasury>(v3);
    }

    public entry fun mint(arg0: &MintCap, arg1: &mut ProtectedTreasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_mutable_cap(arg1);
        assert!(0x2::coin::total_supply<BADINU>(v0) + arg2 * 10000 <= 5000000000000000000, 5);
        0x2::coin::mint_and_transfer<BADINU>(v0, arg2 * 10000, @0xf7a2d249309c5a0bdd3e5cd368660d9409cea5c44c3b85eb67a3f9e083ec8a78, arg3);
    }

    // decompiled from Move bytecode v6
}

