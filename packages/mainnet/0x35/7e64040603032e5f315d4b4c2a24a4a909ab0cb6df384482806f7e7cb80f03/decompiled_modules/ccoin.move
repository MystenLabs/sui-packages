module 0x357e64040603032e5f315d4b4c2a24a4a909ab0cb6df384482806f7e7cb80f03::ccoin {
    struct CCOIN has drop {
        dummy_field: bool,
    }

    struct CoinSupplyObject has drop {
        dummy_field: bool,
    }

    struct CCoinSupply has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<CCOIN>,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CCOIN>, arg1: 0x2::coin::Coin<CCOIN>) {
        0x2::coin::burn<CCOIN>(arg0, arg1);
    }

    fun init(arg0: CCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCOIN>(arg0, 8, b"cc", b"CCoin", b"new coin name cc", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCOIN>>(v1);
        let v2 = CCoinSupply{
            id     : 0x2::object::new(arg1),
            supply : 0x2::coin::treasury_into_supply<CCOIN>(v0),
        };
        0x2::transfer::share_object<CCoinSupply>(v2);
    }

    public entry fun mint(arg0: &mut CCoinSupply, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 17);
        0x2::transfer::public_transfer<0x2::coin::Coin<CCOIN>>(0x2::coin::from_balance<CCOIN>(0x2::balance::increase_supply<CCOIN>(&mut arg0.supply, arg1), arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

