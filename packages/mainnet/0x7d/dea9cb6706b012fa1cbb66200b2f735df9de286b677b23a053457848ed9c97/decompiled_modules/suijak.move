module 0x7ddea9cb6706b012fa1cbb66200b2f735df9de286b677b23a053457848ed9c97::suijak {
    struct SUIJAK has drop {
        dummy_field: bool,
    }

    struct SUIJAKStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SUIJAK>,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SUIJAK>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIJAK>>(arg0, arg1);
    }

    fun init(arg0: SUIJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let (v1, v2) = 0x2::coin::create_currency<SUIJAK>(arg0, v0, b"SUIJAK", b"Sui Wojak", b"https://twitter.com/sui_jak You missed all the shitcoins too fren? Suijak is here to help us", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/2sj5h47/suijack.png"))), arg1);
        let v3 = v1;
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SUIJAK>(&mut v3, 4200000 * 0x2::math::pow(10, v0), v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJAK>>(v3, v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIJAK>>(v2);
    }

    public fun total_supply(arg0: &SUIJAKStorage) : u64 {
        0x2::balance::supply_value<SUIJAK>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

