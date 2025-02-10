module 0xceae9ab5f6654250aa24763621f37944b95e2050a851ac98ec49882e01af9864::carol {
    struct CAROL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAROL, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 670 || 0x2::tx_context::epoch(arg1) == 671, 1);
        let (v0, v1) = 0x2::coin::create_currency<CAROL>(arg0, 9, b"CAROL", b"CAROL", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreibquv7r6vej45bux7czpx7udprq7z5qwfm7lyvpwit2i44mz5xluq.ipfs.w3s.link/"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CAROL>(&mut v2, 270013374000000000, @0x671e9db4de3c43ca0287d9cded4335aaa5a04fbd70089848ab99ba54b1385a9f, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAROL>>(v2, @0x671e9db4de3c43ca0287d9cded4335aaa5a04fbd70089848ab99ba54b1385a9f);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CAROL>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_metadata(arg0: 0x2::coin::CoinMetadata<CAROL>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAROL>>(arg0);
    }

    public entry fun update_metadata(arg0: &mut 0x2::coin::TreasuryCap<CAROL>, arg1: &mut 0x2::coin::CoinMetadata<CAROL>, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: 0x1::ascii::String) {
        0x2::coin::update_name<CAROL>(arg0, arg1, arg2);
        0x2::coin::update_symbol<CAROL>(arg0, arg1, arg3);
        0x2::coin::update_description<CAROL>(arg0, arg1, arg4);
        0x2::coin::update_icon_url<CAROL>(arg0, arg1, arg5);
    }

    // decompiled from Move bytecode v6
}

