module 0xc690a693b838970914ae0e60448240325fd07971629bc47aefd16edc21a10a81::spepe {
    struct SPEPE has drop {
        dummy_field: bool,
    }

    struct SPEPEStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SPEPE>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct SPEPEAdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SPEPE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SPEPE>>(arg0, arg1);
    }

    fun init(arg0: SPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEPE>(arg0, 9, b"SPEPE", b"Sui Pepe", b"https://cryptototem.com/wp-content/uploads/2022/08/SUI-logo.jpg", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SPEPE>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SPEPE>>(0x2::coin::from_balance<SPEPE>(0x2::balance::increase_supply<SPEPE>(&mut v2, 1000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = SPEPEAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SPEPEAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = SPEPEStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<SPEPEStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPEPE>>(v1);
    }

    public fun total_supply(arg0: &SPEPEStorage) : u64 {
        0x2::balance::supply_value<SPEPE>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

