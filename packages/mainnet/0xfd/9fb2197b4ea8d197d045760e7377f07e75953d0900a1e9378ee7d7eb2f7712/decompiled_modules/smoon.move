module 0xfd9fb2197b4ea8d197d045760e7377f07e75953d0900a1e9378ee7d7eb2f7712::smoon {
    struct SMOON has drop {
        dummy_field: bool,
    }

    struct SMOONStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SMOON>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct SMOONAdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SMOON>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SMOON>>(arg0, arg1);
    }

    fun init(arg0: SMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOON>(arg0, 9, b"SMOON", b"Sui Moon Token", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SMOON>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SMOON>>(0x2::coin::from_balance<SMOON>(0x2::balance::increase_supply<SMOON>(&mut v2, 600000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = SMOONAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SMOONAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = SMOONStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<SMOONStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMOON>>(v1);
    }

    public fun total_supply(arg0: &SMOONStorage) : u64 {
        0x2::balance::supply_value<SMOON>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

