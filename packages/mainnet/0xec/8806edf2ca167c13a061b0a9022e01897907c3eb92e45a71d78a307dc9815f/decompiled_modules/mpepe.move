module 0xec8806edf2ca167c13a061b0a9022e01897907c3eb92e45a71d78a307dc9815f::mpepe {
    struct MPEPE has drop {
        dummy_field: bool,
    }

    struct MPEPEStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<MPEPE>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct MPEPEAdminCap has key {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<MPEPE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MPEPE>>(arg0, arg1);
    }

    public entry fun add_minter(arg0: &MPEPEAdminCap, arg1: &mut MPEPEStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.minters, arg2);
        let v0 = MinterAdded{id: arg2};
        0x2::event::emit<MinterAdded>(v0);
    }

    public fun burn(arg0: &mut MPEPEStorage, arg1: 0x2::coin::Coin<MPEPE>) : u64 {
        0x2::balance::decrease_supply<MPEPE>(&mut arg0.supply, 0x2::coin::into_balance<MPEPE>(arg1))
    }

    fun init(arg0: MPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MPEPE>(arg0, 3, b"MPEPE", b"Magic Pepe Token", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::coin::treasury_into_supply<MPEPE>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<MPEPE>>(0x2::coin::from_balance<MPEPE>(0x2::balance::increase_supply<MPEPE>(&mut v2, 1000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = MPEPEAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MPEPEAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = MPEPEStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<MPEPEStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MPEPE>>(v1);
    }

    public fun is_minter(arg0: &MPEPEStorage, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.minters, &arg1)
    }

    public fun mint(arg0: &mut MPEPEStorage, arg1: &0x2::package::Publisher, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MPEPE> {
        assert!(is_minter(arg0, 0x2::object::id<0x2::package::Publisher>(arg1)), 1);
        0x2::coin::from_balance<MPEPE>(0x2::balance::increase_supply<MPEPE>(&mut arg0.supply, arg2), arg3)
    }

    public entry fun remove_minter(arg0: &MPEPEAdminCap, arg1: &mut MPEPEStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.minters, &arg2);
        let v0 = MinterRemoved{id: arg2};
        0x2::event::emit<MinterRemoved>(v0);
    }

    public fun total_supply(arg0: &MPEPEStorage) : u64 {
        0x2::balance::supply_value<MPEPE>(&arg0.supply)
    }

    public entry fun transfer_admin(arg0: MPEPEAdminCap, arg1: address) {
        assert!(arg1 != @0x0, 2);
        0x2::transfer::transfer<MPEPEAdminCap>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    // decompiled from Move bytecode v6
}

