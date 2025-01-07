module 0x2d461a2c2d0fc644199b7da633a2fb425aa97a6ce60aadb26cd6102fd2f3a0e2::seatoken {
    struct SEATOKEN has drop {
        dummy_field: bool,
    }

    struct SEATOKENStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SEATOKEN>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct SEATOKENAdminCap has key {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<SEATOKEN>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SEATOKEN>>(arg0, arg1);
    }

    public entry fun add_minter(arg0: &SEATOKENAdminCap, arg1: &mut SEATOKENStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.minters, arg2);
        let v0 = MinterAdded{id: arg2};
        0x2::event::emit<MinterAdded>(v0);
    }

    public fun burn(arg0: &mut SEATOKENStorage, arg1: 0x2::coin::Coin<SEATOKEN>) : u64 {
        0x2::balance::decrease_supply<SEATOKEN>(&mut arg0.supply, 0x2::coin::into_balance<SEATOKEN>(arg1))
    }

    fun init(arg0: SEATOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEATOKEN>(arg0, 9, b"SEATOKEN", b"Sea Token", b"Sea Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://thumbs.dreamstime.com/b/sea-waves-icon-gold-round-button-gold-round-button-golden-coin-shiny-frame-shadow-luxury-realistic-border-concept-abstract-167081233.jpg")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SEATOKEN>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SEATOKEN>>(0x2::coin::from_balance<SEATOKEN>(0x2::balance::increase_supply<SEATOKEN>(&mut v2, 600000000000000000), arg1), @0x45af3b25576c9c40502316e854aa3b772205a97f56c0a067b7832687b7b5f4b3);
        let v3 = SEATOKENAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SEATOKENAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = SEATOKENStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<SEATOKENStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEATOKEN>>(v1);
    }

    public fun is_minter(arg0: &SEATOKENStorage, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.minters, &arg1)
    }

    public fun mint(arg0: &mut SEATOKENStorage, arg1: &0x2::package::Publisher, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SEATOKEN> {
        assert!(is_minter(arg0, 0x2::object::id<0x2::package::Publisher>(arg1)), 1);
        0x2::coin::from_balance<SEATOKEN>(0x2::balance::increase_supply<SEATOKEN>(&mut arg0.supply, arg2), arg3)
    }

    public entry fun remove_minter(arg0: &SEATOKENAdminCap, arg1: &mut SEATOKENStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.minters, &arg2);
        let v0 = MinterRemoved{id: arg2};
        0x2::event::emit<MinterRemoved>(v0);
    }

    public fun total_supply(arg0: &SEATOKENStorage) : u64 {
        0x2::balance::supply_value<SEATOKEN>(&arg0.supply)
    }

    public entry fun transfer_admin(arg0: SEATOKENAdminCap, arg1: address) {
        assert!(arg1 != @0x0, 2);
        0x2::transfer::transfer<SEATOKENAdminCap>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    // decompiled from Move bytecode v6
}

