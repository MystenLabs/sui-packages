module 0xe5bc012a1266dc6b661d7ff730200c9f515cb21ae47458893db00969770df8f4::suasui {
    struct SUASUI has drop {
        dummy_field: bool,
    }

    struct IPXStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SUASUI>,
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

    public entry fun transfer(arg0: 0x2::coin::Coin<SUASUI>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUASUI>>(arg0, arg1);
    }

    public entry fun add_minter(arg0: &IPXAdminCap, arg1: &mut IPXStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.minters, arg2);
        let v0 = MinterAdded{id: arg2};
        0x2::event::emit<MinterAdded>(v0);
    }

    public fun burn(arg0: &mut IPXStorage, arg1: 0x2::coin::Coin<SUASUI>) : u64 {
        0x2::balance::decrease_supply<SUASUI>(&mut arg0.supply, 0x2::coin::into_balance<SUASUI>(arg1))
    }

    fun init(arg0: SUASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUASUI>(arg0, 9, b"SUASUI", b"sua sui", b"suasui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYKRPnNSzu2nBo3vXTL7r1WxG7RTuWQa7Xj1z6vSUN2YU")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SUASUI>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUASUI>>(0x2::coin::from_balance<SUASUI>(0x2::balance::increase_supply<SUASUI>(&mut v2, 600000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = IPXAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<IPXAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = IPXStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<IPXStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUASUI>>(v1);
    }

    public fun is_minter(arg0: &IPXStorage, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.minters, &arg1)
    }

    public fun mint(arg0: &mut IPXStorage, arg1: &0x2::package::Publisher, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SUASUI> {
        assert!(is_minter(arg0, 0x2::object::id<0x2::package::Publisher>(arg1)), 1);
        0x2::coin::from_balance<SUASUI>(0x2::balance::increase_supply<SUASUI>(&mut arg0.supply, arg2), arg3)
    }

    public entry fun remove_minter(arg0: &IPXAdminCap, arg1: &mut IPXStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.minters, &arg2);
        let v0 = MinterRemoved{id: arg2};
        0x2::event::emit<MinterRemoved>(v0);
    }

    public fun total_supply(arg0: &IPXStorage) : u64 {
        0x2::balance::supply_value<SUASUI>(&arg0.supply)
    }

    public entry fun transfer_admin(arg0: IPXAdminCap, arg1: address) {
        assert!(arg1 != @0x0, 2);
        0x2::transfer::transfer<IPXAdminCap>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    // decompiled from Move bytecode v6
}

