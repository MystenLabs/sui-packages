module 0x90f500b598e15599947ba21e8c4811ea33519f273126d66b3c5481c7b3ab7ded::ipx {
    struct IPX has drop {
        dummy_field: bool,
    }

    struct IPXStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<IPX>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct IPXAdminCap has key {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<IPX>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<IPX>>(arg0, arg1);
    }

    public entry fun add_minter(arg0: &IPXAdminCap, arg1: &mut IPXStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.minters, arg2);
        let v0 = MinterAdded{id: arg2};
        0x2::event::emit<MinterAdded>(v0);
    }

    public fun burn(arg0: &mut IPXStorage, arg1: 0x2::coin::Coin<IPX>) : u64 {
        0x2::balance::decrease_supply<IPX>(&mut arg0.supply, 0x2::coin::into_balance<IPX>(arg1))
    }

    fun init(arg0: IPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IPX>(arg0, 9, b"IPX", b"Interest Protocol Token", b"The governance token of Interest Protocol", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = IPXAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<IPXAdminCap>(v2, 0x2::tx_context::sender(arg1));
        let v3 = IPXStorage{
            id      : 0x2::object::new(arg1),
            supply  : 0x2::coin::treasury_into_supply<IPX>(v0),
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<IPXStorage>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IPX>>(v1);
    }

    public fun is_minter(arg0: &IPXStorage, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.minters, &arg1)
    }

    public fun mint(arg0: &mut IPXStorage, arg1: &0x2::package::Publisher, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<IPX> {
        assert!(is_minter(arg0, 0x2::object::id<0x2::package::Publisher>(arg1)), 1);
        0x2::coin::from_balance<IPX>(0x2::balance::increase_supply<IPX>(&mut arg0.supply, arg2), arg3)
    }

    public entry fun remove_minter(arg0: &IPXAdminCap, arg1: &mut IPXStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.minters, &arg2);
        let v0 = MinterRemoved{id: arg2};
        0x2::event::emit<MinterRemoved>(v0);
    }

    public fun total_supply(arg0: &IPXStorage) : u64 {
        0x2::balance::supply_value<IPX>(&arg0.supply)
    }

    public entry fun transfer_admin(arg0: IPXAdminCap, arg1: address) {
        assert!(arg1 != @0x0, 2);
        0x2::transfer::transfer<IPXAdminCap>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    // decompiled from Move bytecode v6
}

