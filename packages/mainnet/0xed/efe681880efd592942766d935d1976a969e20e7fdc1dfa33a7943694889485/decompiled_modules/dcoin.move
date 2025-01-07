module 0xedefe681880efd592942766d935d1976a969e20e7fdc1dfa33a7943694889485::dcoin {
    struct DCOIN has drop {
        dummy_field: bool,
    }

    struct CoinSupplyObject has drop {
        dummy_field: bool,
    }

    struct CCoinSupply has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<DCOIN>,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DCOIN>, arg1: 0x2::coin::Coin<DCOIN>) {
        0x2::coin::burn<DCOIN>(arg0, arg1);
    }

    fun init(arg0: DCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCOIN>(arg0, 8, b"dd", b"DCoin", b"new coin name dd", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DCOIN>>(v1);
        let v2 = CCoinSupply{
            id     : 0x2::object::new(arg1),
            supply : 0x2::coin::treasury_into_supply<DCOIN>(v0),
        };
        0x2::transfer::share_object<CCoinSupply>(v2);
    }

    public entry fun mint(arg0: &mut CCoinSupply, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 17);
        0x2::transfer::public_transfer<0x2::coin::Coin<DCOIN>>(0x2::coin::from_balance<DCOIN>(0x2::balance::increase_supply<DCOIN>(&mut arg0.supply, arg1), arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

