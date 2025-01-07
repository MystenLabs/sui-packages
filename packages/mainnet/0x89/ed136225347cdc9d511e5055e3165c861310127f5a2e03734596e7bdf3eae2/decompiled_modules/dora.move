module 0x89ed136225347cdc9d511e5055e3165c861310127f5a2e03734596e7bdf3eae2::dora {
    struct DORA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DORA>, arg1: 0x2::coin::Coin<DORA>) {
        0x2::coin::burn<DORA>(arg0, arg1);
    }

    fun init(arg0: DORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORA>(arg0, 9, b"DORA", b"Suiper no Suiping!", x"537569706572206e6f2053756970696e6721200a2068747470733a2f2f747769747465722e636f6d2f646f7261636f696e73756920606e2068747470733a2f2f742e6d652f646f72616f6e737569706f7274616c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1746255099251527680/OYUF1eKs_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DORA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DORA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DORA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

