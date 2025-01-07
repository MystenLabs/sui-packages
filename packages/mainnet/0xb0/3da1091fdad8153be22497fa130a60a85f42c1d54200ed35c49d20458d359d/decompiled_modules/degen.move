module 0xb03da1091fdad8153be22497fa130a60a85f42c1d54200ed35c49d20458d359d::degen {
    struct DEGEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DEGEN>, arg1: 0x2::coin::Coin<DEGEN>) {
        0x2::coin::burn<DEGEN>(arg0, arg1);
    }

    fun init(arg0: DEGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGEN>(arg0, 9, b"DEGEN", b"DEGEN", b"DEGEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x4ed4e862860bed51a9570b96d89af5e1b0efefed.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 1000000000000000, @0x24de41e1ead4cdc5dc899459323884d4be770021825515302a55f7b5b663edbb, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEGEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGEN>>(v2, @0x24de41e1ead4cdc5dc899459323884d4be770021825515302a55f7b5b663edbb);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DEGEN>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DEGEN>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

