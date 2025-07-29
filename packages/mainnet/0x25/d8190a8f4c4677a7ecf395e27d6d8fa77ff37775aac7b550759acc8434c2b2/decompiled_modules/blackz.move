module 0x25d8190a8f4c4677a7ecf395e27d6d8fa77ff37775aac7b550759acc8434c2b2::blackz {
    struct BLACKZ has drop {
        dummy_field: bool,
    }

    public entry fun burn_coin(arg0: &mut 0x2::coin::TreasuryCap<BLACKZ>, arg1: 0x2::coin::Coin<BLACKZ>) {
        0x2::coin::burn<BLACKZ>(arg0, arg1);
    }

    fun init(arg0: BLACKZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKZ>(arg0, 9, b"BLZ", b"BLACKZ", b"Currency of Fake protocol!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://indigo-elderly-aardwolf-635.mypinata.cloud/ipfs/QmYqLMBatiRkwvZ7AyGrE3wz7FwTS1xpKejTP4Bg3JimtG"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLACKZ>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLACKZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKZ>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

