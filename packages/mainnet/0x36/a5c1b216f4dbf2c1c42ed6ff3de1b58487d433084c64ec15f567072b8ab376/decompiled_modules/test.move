module 0x36a5c1b216f4dbf2c1c42ed6ff3de1b58487d433084c64ec15f567072b8ab376::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 665 || 0x2::tx_context::epoch(arg1) == 666, 1);
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 9, b"TEST", b"TEST", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST>(&mut v2, 11000000000000000, @0x671e9db4de3c43ca0287d9cded4335aaa5a04fbd70089848ab99ba54b1385a9f, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v2, @0x671e9db4de3c43ca0287d9cded4335aaa5a04fbd70089848ab99ba54b1385a9f);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_metadata(arg0: 0x2::coin::CoinMetadata<TEST>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(arg0);
    }

    public entry fun update_metadata(arg0: &mut 0x2::coin::TreasuryCap<TEST>, arg1: &mut 0x2::coin::CoinMetadata<TEST>, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: 0x1::ascii::String) {
        0x2::coin::update_name<TEST>(arg0, arg1, arg2);
        0x2::coin::update_symbol<TEST>(arg0, arg1, arg3);
        0x2::coin::update_description<TEST>(arg0, arg1, arg4);
        0x2::coin::update_icon_url<TEST>(arg0, arg1, arg5);
    }

    // decompiled from Move bytecode v6
}

