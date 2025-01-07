module 0xf64ed853fad171f664a16a1771c66d33c0b5680aab87d7c6179596a18cb0cfbd::doggo {
    struct DOGGO has drop {
        dummy_field: bool,
    }

    struct DOGGOStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<DOGGO>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct DOGGOAdminCap has key {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<DOGGO>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DOGGO>>(arg0, arg1);
    }

    public entry fun add_minter(arg0: &DOGGOAdminCap, arg1: &mut DOGGOStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.minters, arg2);
        let v0 = MinterAdded{id: arg2};
        0x2::event::emit<MinterAdded>(v0);
    }

    public fun burn(arg0: &mut DOGGOStorage, arg1: 0x2::coin::Coin<DOGGO>) : u64 {
        0x2::balance::decrease_supply<DOGGO>(&mut arg0.supply, 0x2::coin::into_balance<DOGGO>(arg1))
    }

    fun init(arg0: DOGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGGO>(arg0, 4, b"DOGGO", b"Sui Doggo", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::coin::treasury_into_supply<DOGGO>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<DOGGO>>(0x2::coin::from_balance<DOGGO>(0x2::balance::increase_supply<DOGGO>(&mut v2, 1000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = DOGGOAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<DOGGOAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = DOGGOStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<DOGGOStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGGO>>(v1);
    }

    public fun is_minter(arg0: &DOGGOStorage, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.minters, &arg1)
    }

    public fun mint(arg0: &mut DOGGOStorage, arg1: &0x2::package::Publisher, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<DOGGO> {
        assert!(is_minter(arg0, 0x2::object::id<0x2::package::Publisher>(arg1)), 1);
        0x2::coin::from_balance<DOGGO>(0x2::balance::increase_supply<DOGGO>(&mut arg0.supply, arg2), arg3)
    }

    public entry fun remove_minter(arg0: &DOGGOAdminCap, arg1: &mut DOGGOStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.minters, &arg2);
        let v0 = MinterRemoved{id: arg2};
        0x2::event::emit<MinterRemoved>(v0);
    }

    public fun total_supply(arg0: &DOGGOStorage) : u64 {
        0x2::balance::supply_value<DOGGO>(&arg0.supply)
    }

    public entry fun transfer_admin(arg0: DOGGOAdminCap, arg1: address) {
        assert!(arg1 != @0x0, 2);
        0x2::transfer::transfer<DOGGOAdminCap>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    // decompiled from Move bytecode v6
}

