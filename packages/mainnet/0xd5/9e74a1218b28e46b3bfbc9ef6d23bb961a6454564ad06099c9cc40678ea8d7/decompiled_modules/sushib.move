module 0xd59e74a1218b28e46b3bfbc9ef6d23bb961a6454564ad06099c9cc40678ea8d7::sushib {
    struct SUSHIB has drop {
        dummy_field: bool,
    }

    struct SUSHIBStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SUSHIB>,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SUSHIB>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUSHIB>>(arg0, arg1);
    }

    fun init(arg0: SUSHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let (v1, v2) = 0x2::coin::create_currency<SUSHIB>(arg0, v0, b"SUSHIB", b"Sui Pepe", b"Pepe for Sui PEPEs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://upload.wikimedia.org/wikipedia/en/5/53/Shiba_Inu_coin_logo.png"))), arg1);
        let v3 = v1;
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SUSHIB>(&mut v3, 1000000 * 0x2::math::pow(10, v0), v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSHIB>>(v3, v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUSHIB>>(v2);
    }

    public fun total_supply(arg0: &SUSHIBStorage) : u64 {
        0x2::balance::supply_value<SUSHIB>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

