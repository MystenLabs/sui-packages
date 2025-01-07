module 0x40456c99aa99ef353ace6bd813939d74b9cb93ba81eb2ec475eb55bd2e6c0337::hexacat {
    struct MyHEXACAT has key {
        id: 0x2::object::UID,
        max_supply: u64,
        total_supply: u64,
        name: vector<u8>,
        symbol: vector<u8>,
        description: vector<u8>,
        image_url: 0x2::url::Url,
    }

    struct HEXACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEXACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::url::new_unsafe_from_bytes(b"https://red-rainy-catfish-636.mypinata.cloud/ipfs/QmcHh5ZsEiNpgAXdiBjGHaE14WfpGSxczPUpfnxR621B9D");
        let v1 = MyHEXACAT{
            id           : 0x2::object::new(arg1),
            max_supply   : 10000000000000000000,
            total_supply : 0,
            name         : b"HEXACAT",
            symbol       : b"HEXACAT",
            description  : b"This is my HEXACAT",
            image_url    : v0,
        };
        let (v2, v3) = 0x2::coin::create_currency<HEXACAT>(arg0, 9, b"HEXACAT", b"HEXACAT", b"This is my HEXACAT", 0x1::option::some<0x2::url::Url>(v0), arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEXACAT>>(v3);
        let v5 = 10000000000000000000;
        let v6 = &mut v1;
        let v7 = &mut v4;
        let v8 = mint_initial(v6, v7, v5, arg1);
        v1.total_supply = v5;
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HEXACAT>>(v4);
        0x2::transfer::transfer<MyHEXACAT>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<HEXACAT>>(v8, 0x2::tx_context::sender(arg1));
    }

    fun mint_initial(arg0: &mut MyHEXACAT, arg1: &mut 0x2::coin::TreasuryCap<HEXACAT>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<HEXACAT> {
        0x1::debug::print<u64>(&arg0.total_supply);
        0x1::debug::print<u64>(&arg2);
        0x1::debug::print<u64>(&arg0.max_supply);
        assert!(arg0.total_supply + arg2 <= arg0.max_supply, 1);
        arg0.total_supply = arg0.total_supply + arg2;
        0x2::coin::mint<HEXACAT>(arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

