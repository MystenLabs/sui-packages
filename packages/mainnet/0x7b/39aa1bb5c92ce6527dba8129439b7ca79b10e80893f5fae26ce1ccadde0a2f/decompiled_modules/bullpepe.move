module 0x7b39aa1bb5c92ce6527dba8129439b7ca79b10e80893f5fae26ce1ccadde0a2f::bullpepe {
    struct BULLPEPE has drop {
        dummy_field: bool,
    }

    struct BULLPEPEStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<BULLPEPE>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct BULLPEPEAdminCap has key {
        id: 0x2::object::UID,
    }

    struct MinterAdded has copy, drop {
        id: 0x2::object::ID,
    }

    struct MinterRemoved has copy, drop {
        id: 0x2::object::ID,
    }

    struct NewAdmin has copy, drop {
        admin: address,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<BULLPEPE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BULLPEPE>>(arg0, arg1);
    }

    public entry fun add_minter(arg0: &BULLPEPEAdminCap, arg1: &mut BULLPEPEStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.minters, arg2);
        let v0 = MinterAdded{id: arg2};
        0x2::event::emit<MinterAdded>(v0);
    }

    public fun burn(arg0: &mut BULLPEPEStorage, arg1: 0x2::coin::Coin<BULLPEPE>) : u64 {
        0x2::balance::decrease_supply<BULLPEPE>(&mut arg0.supply, 0x2::coin::into_balance<BULLPEPE>(arg1))
    }

    fun init(arg0: BULLPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLPEPE>(arg0, 4, b"BULLPEPE", b"BullPepe", b"1000x with $BULLPEPE. Telegram : t.me/bullspepe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmQs3kyGTzTSZ1z7B6an58VngZtEmMWiSaBY6KCNKx7R93?_gl=1*1efu8gg*rs_ga*ODJhNjIwYmEtMWRiOC00MTRlLWIwMDctOTI1NDY2ODFjZGQ2*rs_ga_5RMPXG14TE*MTY4MzQ1MTY0Ni4xMS4xLjE2ODM0NTE2NTkuNDcuMC4w")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<BULLPEPE>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<BULLPEPE>>(0x2::coin::from_balance<BULLPEPE>(0x2::balance::increase_supply<BULLPEPE>(&mut v2, 10000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = BULLPEPEAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<BULLPEPEAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = BULLPEPEStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<BULLPEPEStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULLPEPE>>(v1);
    }

    public fun is_minter(arg0: &BULLPEPEStorage, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.minters, &arg1)
    }

    public fun mint(arg0: &mut BULLPEPEStorage, arg1: &0x2::package::Publisher, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BULLPEPE> {
        assert!(is_minter(arg0, 0x2::object::id<0x2::package::Publisher>(arg1)), 1);
        0x2::coin::from_balance<BULLPEPE>(0x2::balance::increase_supply<BULLPEPE>(&mut arg0.supply, arg2), arg3)
    }

    public entry fun remove_minter(arg0: &BULLPEPEAdminCap, arg1: &mut BULLPEPEStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.minters, &arg2);
        let v0 = MinterRemoved{id: arg2};
        0x2::event::emit<MinterRemoved>(v0);
    }

    public fun total_supply(arg0: &BULLPEPEStorage) : u64 {
        0x2::balance::supply_value<BULLPEPE>(&arg0.supply)
    }

    public entry fun transfer_admin(arg0: BULLPEPEAdminCap, arg1: address) {
        assert!(arg1 != @0x0, 2);
        0x2::transfer::transfer<BULLPEPEAdminCap>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    // decompiled from Move bytecode v6
}

