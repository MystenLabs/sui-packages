module 0xf5338a0e7a0b9636ed59f62053f5966dc46664fa574b089700c536995ed6e44e::suilla {
    struct SUILLA has drop {
        dummy_field: bool,
    }

    struct SUILLAStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SUILLA>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct SUILLAAdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SUILLA>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUILLA>>(arg0, arg1);
    }

    fun init(arg0: SUILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILLA>(arg0, 9, b"SUILLA", b"SUI Zilla", b"We just here for the hype", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SUILLA>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUILLA>>(0x2::coin::from_balance<SUILLA>(0x2::balance::increase_supply<SUILLA>(&mut v2, 1000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = SUILLAAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SUILLAAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = SUILLAStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<SUILLAStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUILLA>>(v1);
    }

    public fun total_supply(arg0: &SUILLAStorage) : u64 {
        0x2::balance::supply_value<SUILLA>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

