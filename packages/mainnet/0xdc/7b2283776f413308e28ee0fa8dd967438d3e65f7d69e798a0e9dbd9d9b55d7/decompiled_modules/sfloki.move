module 0xdc7b2283776f413308e28ee0fa8dd967438d3e65f7d69e798a0e9dbd9d9b55d7::sfloki {
    struct SFLOKI has drop {
        dummy_field: bool,
    }

    struct SFLOKIStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SFLOKI>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct SFLOKIAdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SFLOKI>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SFLOKI>>(arg0, arg1);
    }

    fun init(arg0: SFLOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFLOKI>(arg0, 9, b"SFLOKI", b"Sui Moon Token", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SFLOKI>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SFLOKI>>(0x2::coin::from_balance<SFLOKI>(0x2::balance::increase_supply<SFLOKI>(&mut v2, 1000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = SFLOKIAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SFLOKIAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = SFLOKIStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<SFLOKIStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFLOKI>>(v1);
    }

    public fun total_supply(arg0: &SFLOKIStorage) : u64 {
        0x2::balance::supply_value<SFLOKI>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

