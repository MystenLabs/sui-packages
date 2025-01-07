module 0xd882feaed0c1896866129b7d3ec5e6e08e95d9bd022dc96adfe12ef61fdd52a6::zephr {
    struct MyZEPHR has key {
        id: 0x2::object::UID,
        max_supply: u64,
        total_supply: u64,
        name: vector<u8>,
        symbol: vector<u8>,
        description: vector<u8>,
        image_url: 0x2::url::Url,
    }

    struct ZEPHR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEPHR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::url::new_unsafe_from_bytes(b"https://red-rainy-catfish-636.mypinata.cloud/ipfs/QmfF9erhWqxTqrMjeX5w9NtqqLdh7bkKxeBFKGSHDeNudY");
        let v1 = MyZEPHR{
            id           : 0x2::object::new(arg1),
            max_supply   : 10000000000000,
            total_supply : 0,
            name         : b"ZEPHR",
            symbol       : b"ZEPHR",
            description  : b"This is my awesome ZEPHR",
            image_url    : v0,
        };
        let (v2, v3) = 0x2::coin::create_currency<ZEPHR>(arg0, 9, b"ZEPHR", b"My Awesome ZEPHR", b"This is my awesome ZEPHR", 0x1::option::some<0x2::url::Url>(v0), arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZEPHR>>(v3);
        let v5 = 10000000000000;
        let v6 = &mut v1;
        let v7 = &mut v4;
        let v8 = mint_initial(v6, v7, v5, arg1);
        v1.total_supply = v5;
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ZEPHR>>(v4);
        0x2::transfer::transfer<MyZEPHR>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<ZEPHR>>(v8, 0x2::tx_context::sender(arg1));
    }

    fun mint_initial(arg0: &mut MyZEPHR, arg1: &mut 0x2::coin::TreasuryCap<ZEPHR>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ZEPHR> {
        0x1::debug::print<u64>(&arg0.total_supply);
        0x1::debug::print<u64>(&arg2);
        0x1::debug::print<u64>(&arg0.max_supply);
        assert!(arg0.total_supply + arg2 <= arg0.max_supply, 1);
        arg0.total_supply = arg0.total_supply + arg2;
        0x2::coin::mint<ZEPHR>(arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

