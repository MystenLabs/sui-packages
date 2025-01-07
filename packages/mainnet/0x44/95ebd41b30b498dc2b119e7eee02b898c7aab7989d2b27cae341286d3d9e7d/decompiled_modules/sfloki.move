module 0x4495ebd41b30b498dc2b119e7eee02b898c7aab7989d2b27cae341286d3d9e7d::sfloki {
    struct SFLOKI has drop {
        dummy_field: bool,
    }

    struct SFLOKIStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SFLOKI>,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SFLOKI>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SFLOKI>>(arg0, arg1);
    }

    fun init(arg0: SFLOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let (v1, v2) = 0x2::coin::create_currency<SFLOKI>(arg0, v0, b"SFLOKI", b"Sui Floki", b"25k MCAP Twitter, 50k MCAP Website, %90 LP, %10 Team and Marketing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://s3.coinmarketcap.com/static/img/portraits/630de341f8184351dc5cb644.png"))), arg1);
        let v3 = v1;
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SFLOKI>(&mut v3, 1000000 * 0x2::math::pow(10, v0), v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFLOKI>>(v3, v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFLOKI>>(v2);
    }

    public fun total_supply(arg0: &SFLOKIStorage) : u64 {
        0x2::balance::supply_value<SFLOKI>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

