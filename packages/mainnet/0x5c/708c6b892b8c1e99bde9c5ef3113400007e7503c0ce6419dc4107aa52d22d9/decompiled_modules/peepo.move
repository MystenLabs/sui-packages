module 0x5c708c6b892b8c1e99bde9c5ef3113400007e7503c0ce6419dc4107aa52d22d9::peepo {
    struct Registry has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<PEEPO>,
    }

    struct PEEPO has drop {
        dummy_field: bool,
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

    public entry fun mint(arg0: &mut Registry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PEEPO>(&mut arg0.treasury_cap, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

