module 0x1509a84c0ef3e29778131b31bbb14c35b380064c3cefb8660c759d72be3bde94::babysui {
    struct BABYSUI has drop {
        dummy_field: bool,
    }

    struct BABYSUIStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<BABYSUI>,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<BABYSUI>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BABYSUI>>(arg0, arg1);
    }

    fun init(arg0: BABYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSUI>(arg0, 9, b"BABYSUI", b"Babysui", b"The Biggest Meme Token on SUI Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeicwmin7lvipd6qukdxdzh37hpu3gjfkcu5d2gp33wyh7yuy6q7qbe.ipfs.w3s.link/rice-farm.jpg")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<BABYSUI>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<BABYSUI>>(0x2::coin::from_balance<BABYSUI>(0x2::balance::increase_supply<BABYSUI>(&mut v2, 100000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = BABYSUIStorage{
            id     : 0x2::object::new(arg1),
            supply : v2,
        };
        0x2::transfer::share_object<BABYSUIStorage>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYSUI>>(v1);
    }

    public fun total_supply(arg0: &BABYSUIStorage) : u64 {
        0x2::balance::supply_value<BABYSUI>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

