module 0xef1e9a08c6084c1887b655d8b599675b82d9efd8b3006342810564b9c0d8a829::safe {
    struct SAFE has drop {
        dummy_field: bool,
    }

    struct SAFEStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SAFE>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct SAFEAdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SAFE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SAFE>>(arg0, arg1);
    }

    fun init(arg0: SAFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAFE>(arg0, 9, b"SAFE", b"SAFE TO TRADE BRUH", b"We just here for the hype", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SAFE>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SAFE>>(0x2::coin::from_balance<SAFE>(0x2::balance::increase_supply<SAFE>(&mut v2, 1000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = SAFEAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SAFEAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = SAFEStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<SAFEStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAFE>>(v1);
    }

    public fun total_supply(arg0: &SAFEStorage) : u64 {
        0x2::balance::supply_value<SAFE>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

