module 0x70b0d6dfa8a0b4f8e92189c874d546506113efa1917f950df04b9ca6eb905681::OBJ {
    struct OBJ has drop {
        dummy_field: bool,
    }

    struct OBJStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<OBJ>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct OBJAdminCap has key {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<OBJ>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<OBJ>>(arg0, arg1);
    }

    public entry fun add_minter(arg0: &OBJAdminCap, arg1: &mut OBJStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.minters, arg2);
        let v0 = MinterAdded{id: arg2};
        0x2::event::emit<MinterAdded>(v0);
    }

    public fun burn(arg0: &mut OBJStorage, arg1: 0x2::coin::Coin<OBJ>) : u64 {
        0x2::balance::decrease_supply<OBJ>(&mut arg0.supply, 0x2::coin::into_balance<OBJ>(arg1))
    }

    fun init(arg0: OBJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OBJ>(arg0, 9, b"OBJ", b"ObjectSwap Token", b"The native token of ObjectSwap", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://objectswap.finance/images/token.png")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<OBJ>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<OBJ>>(0x2::coin::from_balance<OBJ>(0x2::balance::increase_supply<OBJ>(&mut v2, 175000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = OBJAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<OBJAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = OBJStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<OBJStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OBJ>>(v1);
    }

    public fun is_minter(arg0: &OBJStorage, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.minters, &arg1)
    }

    public fun mint(arg0: &mut OBJStorage, arg1: &0x2::package::Publisher, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<OBJ> {
        assert!(is_minter(arg0, 0x2::object::id<0x2::package::Publisher>(arg1)), 1);
        0x2::coin::from_balance<OBJ>(0x2::balance::increase_supply<OBJ>(&mut arg0.supply, arg2), arg3)
    }

    public entry fun remove_minter(arg0: &OBJAdminCap, arg1: &mut OBJStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.minters, &arg2);
        let v0 = MinterRemoved{id: arg2};
        0x2::event::emit<MinterRemoved>(v0);
    }

    public fun total_supply(arg0: &OBJStorage) : u64 {
        0x2::balance::supply_value<OBJ>(&arg0.supply)
    }

    public entry fun transfer_admin(arg0: OBJAdminCap, arg1: address) {
        assert!(arg1 != @0x0, 2);
        0x2::transfer::transfer<OBJAdminCap>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    // decompiled from Move bytecode v6
}

