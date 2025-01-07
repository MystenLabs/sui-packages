module 0xd848567111ece4fb2585c7f72289fa9a0588cd09c3e472620bfb966c4d374dd4::floki {
    struct FLOKI has drop {
        dummy_field: bool,
    }

    struct FLOKIStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<FLOKI>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct FLOKIAdminCap has key {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<FLOKI>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FLOKI>>(arg0, arg1);
    }

    public entry fun add_minter(arg0: &FLOKIAdminCap, arg1: &mut FLOKIStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.minters, arg2);
        let v0 = MinterAdded{id: arg2};
        0x2::event::emit<MinterAdded>(v0);
    }

    public fun burn(arg0: &mut FLOKIStorage, arg1: 0x2::coin::Coin<FLOKI>) : u64 {
        0x2::balance::decrease_supply<FLOKI>(&mut arg0.supply, 0x2::coin::into_balance<FLOKI>(arg1))
    }

    fun init(arg0: FLOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOKI>(arg0, 4, b"FLOKI", b"FLOKI INU", b"floki inu is a bsc meme coin now available on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/10804.png")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<FLOKI>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<FLOKI>>(0x2::coin::from_balance<FLOKI>(0x2::balance::increase_supply<FLOKI>(&mut v2, 10000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = FLOKIAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<FLOKIAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = FLOKIStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<FLOKIStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLOKI>>(v1);
    }

    public fun is_minter(arg0: &FLOKIStorage, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.minters, &arg1)
    }

    public fun mint(arg0: &mut FLOKIStorage, arg1: &0x2::package::Publisher, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<FLOKI> {
        assert!(is_minter(arg0, 0x2::object::id<0x2::package::Publisher>(arg1)), 1);
        0x2::coin::from_balance<FLOKI>(0x2::balance::increase_supply<FLOKI>(&mut arg0.supply, arg2), arg3)
    }

    public entry fun remove_minter(arg0: &FLOKIAdminCap, arg1: &mut FLOKIStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.minters, &arg2);
        let v0 = MinterRemoved{id: arg2};
        0x2::event::emit<MinterRemoved>(v0);
    }

    public fun total_supply(arg0: &FLOKIStorage) : u64 {
        0x2::balance::supply_value<FLOKI>(&arg0.supply)
    }

    public entry fun transfer_admin(arg0: FLOKIAdminCap, arg1: address) {
        assert!(arg1 != @0x0, 2);
        0x2::transfer::transfer<FLOKIAdminCap>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    // decompiled from Move bytecode v6
}

