module 0x943adfea9cae461198512e6b260279c5b9faac85c3c7d92e689047e272c31803::schad {
    struct SCHAD has drop {
        dummy_field: bool,
    }

    struct SCHADStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SCHAD>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct SCHADAdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SCHAD>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SCHAD>>(arg0, arg1);
    }

    fun init(arg0: SCHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHAD>(arg0, 9, b"SCHAD", b"Sui Chad", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SCHAD>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SCHAD>>(0x2::coin::from_balance<SCHAD>(0x2::balance::increase_supply<SCHAD>(&mut v2, 1000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = SCHADAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SCHADAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = SCHADStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<SCHADStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCHAD>>(v1);
    }

    public fun total_supply(arg0: &SCHADStorage) : u64 {
        0x2::balance::supply_value<SCHAD>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

