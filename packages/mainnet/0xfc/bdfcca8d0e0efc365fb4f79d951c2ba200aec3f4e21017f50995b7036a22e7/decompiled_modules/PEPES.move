module 0xfcbdfcca8d0e0efc365fb4f79d951c2ba200aec3f4e21017f50995b7036a22e7::PEPES {
    struct PEPES has drop {
        dummy_field: bool,
    }

    struct PEPESStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<PEPES>,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<PEPES>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPES>>(arg0, arg1);
    }

    public fun burn(arg0: &mut PEPESStorage, arg1: 0x2::coin::Coin<PEPES>) : u64 {
        0x2::balance::decrease_supply<PEPES>(&mut arg0.supply, 0x2::coin::into_balance<PEPES>(arg1))
    }

    fun init(arg0: PEPES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPES>(arg0, 1, b"PEPES", b"Pepe Sui", b"Pepe Sui Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/N1QpG69.jpeg")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<PEPES>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPES>>(0x2::coin::from_balance<PEPES>(0x2::balance::increase_supply<PEPES>(&mut v2, 4906900000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = PEPESStorage{
            id     : 0x2::object::new(arg1),
            supply : v2,
        };
        0x2::transfer::share_object<PEPESStorage>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPES>>(v1);
    }

    public fun total_supply(arg0: &PEPESStorage) : u64 {
        0x2::balance::supply_value<PEPES>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

