module 0x4382b53032a64e51e6ab0e27a40261d7dbddfe44b4089f63b8f3fa17aa963a40::sape {
    struct SAPE has drop {
        dummy_field: bool,
    }

    struct IPXStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SAPE>,
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

    public entry fun transfer(arg0: 0x2::coin::Coin<SAPE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SAPE>>(arg0, arg1);
    }

    public entry fun add_minter(arg0: &IPXAdminCap, arg1: &mut IPXStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.minters, arg2);
        let v0 = MinterAdded{id: arg2};
        0x2::event::emit<MinterAdded>(v0);
    }

    public fun burn(arg0: &mut IPXStorage, arg1: 0x2::coin::Coin<SAPE>) : u64 {
        0x2::balance::decrease_supply<SAPE>(&mut arg0.supply, 0x2::coin::into_balance<SAPE>(arg1))
    }

    fun init(arg0: SAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAPE>(arg0, 9, b"SAPE", b"SUI APE", b"SUI APE token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.linkpicture.com/q/logo_925.png")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SAPE>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SAPE>>(0x2::coin::from_balance<SAPE>(0x2::balance::increase_supply<SAPE>(&mut v2, 100000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = IPXAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<IPXAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = IPXStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<IPXStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAPE>>(v1);
    }

    public fun is_minter(arg0: &IPXStorage, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.minters, &arg1)
    }

    public fun mint(arg0: &mut IPXStorage, arg1: &0x2::package::Publisher, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SAPE> {
        assert!(is_minter(arg0, 0x2::object::id<0x2::package::Publisher>(arg1)), 1);
        0x2::coin::from_balance<SAPE>(0x2::balance::increase_supply<SAPE>(&mut arg0.supply, arg2), arg3)
    }

    public entry fun remove_minter(arg0: &IPXAdminCap, arg1: &mut IPXStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.minters, &arg2);
        let v0 = MinterRemoved{id: arg2};
        0x2::event::emit<MinterRemoved>(v0);
    }

    public fun total_supply(arg0: &IPXStorage) : u64 {
        0x2::balance::supply_value<SAPE>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

