module 0x50380c54698ce3604225e9484158ee6e71ce58728852077a062dc17a1557b08b::rocksui {
    struct ROCKSUI has drop {
        dummy_field: bool,
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<ROCKSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<ROCKSUI>(arg0) + arg1 <= 1000000000000000000, 2);
        0x2::coin::mint_and_transfer<ROCKSUI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: ROCKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCKSUI>(arg0, 6, b"RSUI", b"RockSUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ROCKSUI>(&mut v2, 1000000000000000000, @0xa12aef28dfca1f4bd8eed16e6fd08d1e7215e82a346686085b24e26210bbc667, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKSUI>>(v2, @0xa12aef28dfca1f4bd8eed16e6fd08d1e7215e82a346686085b24e26210bbc667);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ROCKSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_metadata(arg0: 0x2::coin::CoinMetadata<ROCKSUI>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROCKSUI>>(arg0);
    }

    public entry fun update_metadata(arg0: &mut 0x2::coin::TreasuryCap<ROCKSUI>, arg1: &mut 0x2::coin::CoinMetadata<ROCKSUI>, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: 0x1::ascii::String) {
        0x2::coin::update_name<ROCKSUI>(arg0, arg1, arg2);
        0x2::coin::update_symbol<ROCKSUI>(arg0, arg1, arg3);
        0x2::coin::update_description<ROCKSUI>(arg0, arg1, arg4);
        0x2::coin::update_icon_url<ROCKSUI>(arg0, arg1, arg5);
    }

    // decompiled from Move bytecode v6
}

