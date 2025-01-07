module 0x2706b46ec94ba22cf5f49b7d857eb4bb68740fa63d437044c72b82ea49d94d74::PEEPO {
    struct Registry has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<PEEPO>,
    }

    struct PEEPO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEEPO>, arg1: 0x2::coin::Coin<PEEPO>) {
        0x2::coin::burn<PEEPO>(arg0, arg1);
    }

    fun init(arg0: PEEPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEEPO>(arg0, 9, b"PEEPO", b"Sui PEEPO", b"PEEPO on SUI blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.dextools.io/resources/tokens/logos/ether/0xaada04204e9e1099daf67cf3d5d137e84e41cf41.jpeg?1682300532097")), arg1);
        let v2 = Registry{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEEPO>>(v1);
        0x2::transfer::share_object<Registry>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEEPO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PEEPO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

