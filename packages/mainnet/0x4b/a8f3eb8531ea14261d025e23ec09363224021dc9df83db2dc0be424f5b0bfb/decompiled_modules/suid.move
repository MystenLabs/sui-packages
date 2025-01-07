module 0x4ba8f3eb8531ea14261d025e23ec09363224021dc9df83db2dc0be424f5b0bfb::suid {
    struct SUID has drop {
        dummy_field: bool,
    }

    struct SuiDollarStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SUID>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct SuiDollarAdminCap has key {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<SUID>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUID>>(arg0, arg1);
    }

    public entry fun add_minter(arg0: &SuiDollarAdminCap, arg1: &mut SuiDollarStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.minters, arg2);
        let v0 = MinterAdded{id: arg2};
        0x2::event::emit<MinterAdded>(v0);
    }

    public fun burn(arg0: &mut SuiDollarStorage, arg1: 0x2::coin::Coin<SUID>) : u64 {
        0x2::balance::decrease_supply<SUID>(&mut arg0.supply, 0x2::coin::into_balance<SUID>(arg1))
    }

    fun init(arg0: SUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUID>(arg0, 9, b"SUID", b"Sui Dollar", b"Interest Protocol Sui Stable Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.interestprotocol.com")), arg1);
        let v2 = SuiDollarStorage{
            id      : 0x2::object::new(arg1),
            supply  : 0x2::coin::treasury_into_supply<SUID>(v0),
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<SuiDollarStorage>(v2);
        let v3 = SuiDollarAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SuiDollarAdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUID>>(v1);
    }

    public fun is_minter(arg0: &SuiDollarStorage, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.minters, &arg1)
    }

    public fun mint(arg0: &mut SuiDollarStorage, arg1: &0x2::package::Publisher, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SUID> {
        assert!(is_minter(arg0, 0x2::object::id<0x2::package::Publisher>(arg1)), 1);
        0x2::coin::from_balance<SUID>(0x2::balance::increase_supply<SUID>(&mut arg0.supply, arg2), arg3)
    }

    public entry fun remove_minter(arg0: &SuiDollarAdminCap, arg1: &mut SuiDollarStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.minters, &arg2);
        let v0 = MinterRemoved{id: arg2};
        0x2::event::emit<MinterRemoved>(v0);
    }

    public fun total_supply(arg0: &SuiDollarStorage) : u64 {
        0x2::balance::supply_value<SUID>(&arg0.supply)
    }

    public entry fun transfer_admin(arg0: SuiDollarAdminCap, arg1: address) {
        assert!(arg1 != @0x0, 2);
        0x2::transfer::transfer<SuiDollarAdminCap>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    // decompiled from Move bytecode v6
}

