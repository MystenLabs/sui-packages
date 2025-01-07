module 0x787c59d1aff3cca87f217ede74edec0da9778ea9d676497b3015fd8a427d46c7::convbetta {
    struct CONVBETTA has drop {
        dummy_field: bool,
    }

    struct GlobalStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<CONVBETTA>,
    }

    fun init(arg0: CONVBETTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONVBETTA>(arg0, 9, b"convBETTA", b"Convert BETTA", b"convBETTA is convertable to mainnet BETTA with a ratio 1:1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.bayswap.io/convbetta.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<CONVBETTA>>(0x2::coin::mint<CONVBETTA>(&mut v2, 1000000000 * 1000000000, arg1), 0x2::tx_context::sender(arg1));
        let v3 = GlobalStorage{
            id     : 0x2::object::new(arg1),
            supply : 0x2::coin::treasury_into_supply<CONVBETTA>(v2),
        };
        0x2::transfer::share_object<GlobalStorage>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CONVBETTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

