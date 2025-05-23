module 0x9f2e939fe5c3c33e22b177e18f4966db14d6908166eb980432c2c8860e9c6a2a::kari {
    struct KARI has drop {
        dummy_field: bool,
    }

    struct KARIStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<KARI>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct KARIAdminCap has key {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<KARI>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KARI>>(arg0, arg1);
    }

    public entry fun add_minter(arg0: &KARIAdminCap, arg1: &mut KARIStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.minters, arg2);
        let v0 = MinterAdded{id: arg2};
        0x2::event::emit<MinterAdded>(v0);
    }

    public fun burn(arg0: &mut KARIStorage, arg1: 0x2::coin::Coin<KARI>) : u64 {
        0x2::balance::decrease_supply<KARI>(&mut arg0.supply, 0x2::coin::into_balance<KARI>(arg1))
    }

    fun init(arg0: KARI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KARI>(arg0, 9, b"KARI", b"Kanari Token", b"The governance token of Kanari Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://magenta-able-pheasant-388.mypinata.cloud/ipfs/QmNVQ3LQSbLC8bJDnXrbuftf2dC7LWJp4oXVkXxVRrDRfk")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<KARI>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<KARI>>(0x2::coin::from_balance<KARI>(0x2::balance::increase_supply<KARI>(&mut v2, 11000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = KARIAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<KARIAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = KARIStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<KARIStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KARI>>(v1);
    }

    public fun is_minter(arg0: &KARIStorage, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.minters, &arg1)
    }

    public fun mint(arg0: &mut KARIStorage, arg1: &0x2::package::Publisher, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<KARI> {
        assert!(is_minter(arg0, 0x2::object::id<0x2::package::Publisher>(arg1)), 1);
        0x2::coin::from_balance<KARI>(0x2::balance::increase_supply<KARI>(&mut arg0.supply, arg2), arg3)
    }

    public entry fun remove_minter(arg0: &KARIAdminCap, arg1: &mut KARIStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.minters, &arg2);
        let v0 = MinterRemoved{id: arg2};
        0x2::event::emit<MinterRemoved>(v0);
    }

    public fun total_supply(arg0: &KARIStorage) : u64 {
        0x2::balance::supply_value<KARI>(&arg0.supply)
    }

    public entry fun transfer_admin(arg0: KARIAdminCap, arg1: address) {
        assert!(arg1 != @0x0, 2);
        0x2::transfer::transfer<KARIAdminCap>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    // decompiled from Move bytecode v6
}

