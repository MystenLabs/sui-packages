module 0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc {
    struct CSC has drop {
        dummy_field: bool,
    }

    struct CSCStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<CSC>,
    }

    struct CSCAdminCap has key {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<CSC>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CSC>>(arg0, arg1);
    }

    public entry fun burn(arg0: &mut CSCStorage, arg1: 0x2::coin::Coin<CSC>) : u64 {
        0x2::balance::decrease_supply<CSC>(&mut arg0.supply, 0x2::coin::into_balance<CSC>(arg1))
    }

    fun init(arg0: CSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSC>(arg0, 9, b"CSC", b"CaSuino Coin", b"The governance token of CaSuino", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://casuino.bet/logo.png")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<CSC>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<CSC>>(0x2::coin::from_balance<CSC>(0x2::balance::increase_supply<CSC>(&mut v2, 1000000000000000000), arg1), @0x8b0725d9ce1f37974984a6fe4c4e75fb50ccc5c4ab48ea802b220cec98b0f9d5);
        let v3 = CSCAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<CSCAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = CSCStorage{
            id     : 0x2::object::new(arg1),
            supply : v2,
        };
        0x2::transfer::share_object<CSCStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CSC>>(v1);
    }

    public entry fun total_supply(arg0: &CSCStorage) : u64 {
        0x2::balance::supply_value<CSC>(&arg0.supply)
    }

    public entry fun transfer_admin(arg0: CSCAdminCap, arg1: address) {
        assert!(arg1 != @0x0, 2);
        0x2::transfer::transfer<CSCAdminCap>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    // decompiled from Move bytecode v6
}

