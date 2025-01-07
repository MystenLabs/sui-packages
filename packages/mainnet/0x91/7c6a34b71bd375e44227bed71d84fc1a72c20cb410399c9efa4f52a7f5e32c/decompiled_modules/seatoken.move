module 0x917c6a34b71bd375e44227bed71d84fc1a72c20cb410399c9efa4f52a7f5e32c::seatoken {
    struct SEATOKEN has drop {
        dummy_field: bool,
    }

    struct SEATOKENStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SEATOKEN>,
        owner: address,
    }

    struct SEATOKENAdminCap has key {
        id: 0x2::object::UID,
    }

    struct NewAdmin has copy, drop {
        admin: address,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SEATOKEN>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SEATOKEN>>(arg0, arg1);
    }

    public fun burn(arg0: &mut SEATOKENStorage, arg1: 0x2::coin::Coin<SEATOKEN>) : u64 {
        0x2::balance::decrease_supply<SEATOKEN>(&mut arg0.supply, 0x2::coin::into_balance<SEATOKEN>(arg1))
    }

    fun init(arg0: SEATOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEATOKEN>(arg0, 9, b"TTT", b"Test Token", b"Test Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d1csarkz8obe9u.cloudfront.net/posterpreviews/testing-logo-design-template-ce84480d61b3db9a8e1522a99875832f_screen.jpg?ts=1615794516")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SEATOKEN>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SEATOKEN>>(0x2::coin::from_balance<SEATOKEN>(0x2::balance::increase_supply<SEATOKEN>(&mut v2, 1000000000000000000), arg1), @0x45af3b25576c9c40502316e854aa3b772205a97f56c0a067b7832687b7b5f4b3);
        let v3 = SEATOKENAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SEATOKENAdminCap>(v3, @0x45af3b25576c9c40502316e854aa3b772205a97f56c0a067b7832687b7b5f4b3);
        let v4 = SEATOKENStorage{
            id     : 0x2::object::new(arg1),
            supply : v2,
            owner  : @0x45af3b25576c9c40502316e854aa3b772205a97f56c0a067b7832687b7b5f4b3,
        };
        0x2::transfer::share_object<SEATOKENStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEATOKEN>>(v1);
    }

    public fun is_owner(arg0: &SEATOKENStorage, arg1: address) : bool {
        arg1 == arg0.owner
    }

    public fun total_supply(arg0: &SEATOKENStorage) : u64 {
        0x2::balance::supply_value<SEATOKEN>(&arg0.supply)
    }

    public entry fun transfer_admin(arg0: SEATOKENAdminCap, arg1: &mut SEATOKENStorage, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 2);
        assert!(is_owner(arg1, 0x2::tx_context::sender(arg3)) == true, 3);
        0x2::transfer::transfer<SEATOKENAdminCap>(arg0, arg2);
        arg1.owner = arg2;
        let v0 = NewAdmin{admin: arg2};
        0x2::event::emit<NewAdmin>(v0);
    }

    // decompiled from Move bytecode v6
}

