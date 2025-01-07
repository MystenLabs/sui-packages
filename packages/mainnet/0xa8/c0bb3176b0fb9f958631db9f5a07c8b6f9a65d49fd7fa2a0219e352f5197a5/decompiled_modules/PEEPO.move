module 0xa8c0bb3176b0fb9f958631db9f5a07c8b6f9a65d49fd7fa2a0219e352f5197a5::PEEPO {
    struct PEEPO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEEPO>, arg1: 0x2::coin::Coin<PEEPO>) {
        0x2::coin::burn<PEEPO>(arg0, arg1);
    }

    fun init(arg0: PEEPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEEPO>(arg0, 2, b"PEEPO", b"PEEPO", b"PEEPO on the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.dextools.io/resources/tokens/logos/ether/0xaada04204e9e1099daf67cf3d5d137e84e41cf41.jpeg?1682300532097")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEEPO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEEPO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEEPO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PEEPO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

