module 0xbd5c2fc959b868ea9464b55cfbf336ce78f38f1973db31a98dcbfb56026e2094::spepe {
    struct SPEPE has drop {
        dummy_field: bool,
    }

    struct SPEPEStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SPEPE>,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SPEPE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SPEPE>>(arg0, arg1);
    }

    fun init(arg0: SPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let (v1, v2) = 0x2::coin::create_currency<SPEPE>(arg0, v0, b"SPEPE", b"Sui Pepe", b"Pepe for Sui PEPEs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://arweave.net/jlumw0-GYXXg8qgWd4q9v6vVVhmnon68nW8jzTDs584"))), arg1);
        let v3 = v1;
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SPEPE>(&mut v3, 1000000000 * 0x2::math::pow(10, v0), v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEPE>>(v3, v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPEPE>>(v2);
    }

    public fun total_supply(arg0: &SPEPEStorage) : u64 {
        0x2::balance::supply_value<SPEPE>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

