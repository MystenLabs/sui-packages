module 0x92fa882c9a10bbc04e6b0a91964c4862dfabb47ff3e1b77d6ad3d8d4bab34f96::stripper {
    struct STRIPPER has drop {
        dummy_field: bool,
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<STRIPPER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<STRIPPER>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: STRIPPER, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 665 || 0x2::tx_context::epoch(arg1) == 666, 1);
        let (v0, v1) = 0x2::coin::create_currency<STRIPPER>(arg0, 9, b"STRIP", b"STRIPPER", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STRIPPER>(&mut v2, 6000000000000000, @0x671e9db4de3c43ca0287d9cded4335aaa5a04fbd70089848ab99ba54b1385a9f, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRIPPER>>(v2, @0x671e9db4de3c43ca0287d9cded4335aaa5a04fbd70089848ab99ba54b1385a9f);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STRIPPER>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_metadata(arg0: 0x2::coin::CoinMetadata<STRIPPER>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STRIPPER>>(arg0);
    }

    public entry fun update_metadata(arg0: &mut 0x2::coin::TreasuryCap<STRIPPER>, arg1: &mut 0x2::coin::CoinMetadata<STRIPPER>, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: 0x1::ascii::String) {
        0x2::coin::update_name<STRIPPER>(arg0, arg1, arg2);
        0x2::coin::update_symbol<STRIPPER>(arg0, arg1, arg3);
        0x2::coin::update_description<STRIPPER>(arg0, arg1, arg4);
        0x2::coin::update_icon_url<STRIPPER>(arg0, arg1, arg5);
    }

    // decompiled from Move bytecode v6
}

