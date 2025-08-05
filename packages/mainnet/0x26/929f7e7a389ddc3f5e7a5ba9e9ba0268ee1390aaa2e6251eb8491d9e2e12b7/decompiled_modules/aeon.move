module 0x26929f7e7a389ddc3f5e7a5ba9e9ba0268ee1390aaa2e6251eb8491d9e2e12b7::aeon {
    struct AEON has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<AEON>, arg1: 0x2::coin::Coin<AEON>) {
        0x2::coin::burn<AEON>(arg0, arg1);
    }

    public entry fun destroy_treasury_cap(arg0: 0x2::coin::TreasuryCap<AEON>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AEON>>(arg0, @0x0);
    }

    fun init(arg0: AEON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AEON>(arg0, 6, b"AEON", b"Aetherlink", b"Aetherlink transcends traditional DeFi, creating a spiritual-mechanical bridge between consciousness, AI memory, and universal governance across infinite realms.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/76ZIrep.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AEON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AEON>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<AEON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AEON>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

