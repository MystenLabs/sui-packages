module 0x156ef03e80b591d3290321b33000c2755b43c95cb45549511a6a00fb8d189a85::cheems {
    struct CHEEMS has drop {
        dummy_field: bool,
    }

    struct CHEEMSStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<CHEEMS>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct CHEEMSAdminCap has key {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<CHEEMS>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CHEEMS>>(arg0, arg1);
    }

    public entry fun add_minter(arg0: &CHEEMSAdminCap, arg1: &mut CHEEMSStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.minters, arg2);
        let v0 = MinterAdded{id: arg2};
        0x2::event::emit<MinterAdded>(v0);
    }

    public fun burn(arg0: &mut CHEEMSStorage, arg1: 0x2::coin::Coin<CHEEMS>) : u64 {
        0x2::balance::decrease_supply<CHEEMS>(&mut arg0.supply, 0x2::coin::into_balance<CHEEMS>(arg1))
    }

    fun init(arg0: CHEEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEEMS>(arg0, 4, b"CHEEMS", b"Cheems Inu", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::coin::treasury_into_supply<CHEEMS>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<CHEEMS>>(0x2::coin::from_balance<CHEEMS>(0x2::balance::increase_supply<CHEEMS>(&mut v2, 1000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = CHEEMSAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<CHEEMSAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = CHEEMSStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<CHEEMSStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHEEMS>>(v1);
    }

    public fun is_minter(arg0: &CHEEMSStorage, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.minters, &arg1)
    }

    public fun mint(arg0: &mut CHEEMSStorage, arg1: &0x2::package::Publisher, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CHEEMS> {
        assert!(is_minter(arg0, 0x2::object::id<0x2::package::Publisher>(arg1)), 1);
        0x2::coin::from_balance<CHEEMS>(0x2::balance::increase_supply<CHEEMS>(&mut arg0.supply, arg2), arg3)
    }

    public entry fun remove_minter(arg0: &CHEEMSAdminCap, arg1: &mut CHEEMSStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.minters, &arg2);
        let v0 = MinterRemoved{id: arg2};
        0x2::event::emit<MinterRemoved>(v0);
    }

    public fun total_supply(arg0: &CHEEMSStorage) : u64 {
        0x2::balance::supply_value<CHEEMS>(&arg0.supply)
    }

    public entry fun transfer_admin(arg0: CHEEMSAdminCap, arg1: address) {
        assert!(arg1 != @0x0, 2);
        0x2::transfer::transfer<CHEEMSAdminCap>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    // decompiled from Move bytecode v6
}

