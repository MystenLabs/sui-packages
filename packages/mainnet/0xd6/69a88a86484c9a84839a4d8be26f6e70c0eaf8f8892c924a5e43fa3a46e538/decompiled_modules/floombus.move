module 0xd669a88a86484c9a84839a4d8be26f6e70c0eaf8f8892c924a5e43fa3a46e538::floombus {
    struct MyFLOOMBUS has key {
        id: 0x2::object::UID,
        max_supply: u64,
        total_supply: u64,
        name: vector<u8>,
        symbol: vector<u8>,
        description: vector<u8>,
        image_url: 0x2::url::Url,
    }

    struct FLOOMBUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOOMBUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::url::new_unsafe_from_bytes(b"https://red-rainy-catfish-636.mypinata.cloud/ipfs/QmX6niogLDLp2hQKa1wccnCYZ1WFzzjuihzKQmhqoxcqyW");
        let v1 = MyFLOOMBUS{
            id           : 0x2::object::new(arg1),
            max_supply   : 10000000000000000000,
            total_supply : 0,
            name         : b"FLOOMBUS2",
            symbol       : b"FLOOMBUS2",
            description  : b"This is FLOOMBUS",
            image_url    : v0,
        };
        let (v2, v3) = 0x2::coin::create_currency<FLOOMBUS>(arg0, 9, b"FLOOMBUS2", b"FLOOMBUS2", b"This is FLOOMBUS2", 0x1::option::some<0x2::url::Url>(v0), arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLOOMBUS>>(v3);
        let v5 = 10000000000000000000;
        let v6 = &mut v1;
        let v7 = &mut v4;
        let v8 = mint_initial(v6, v7, v5, arg1);
        v1.total_supply = v5;
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FLOOMBUS>>(v4);
        0x2::transfer::transfer<MyFLOOMBUS>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<FLOOMBUS>>(v8, 0x2::tx_context::sender(arg1));
    }

    fun mint_initial(arg0: &mut MyFLOOMBUS, arg1: &mut 0x2::coin::TreasuryCap<FLOOMBUS>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<FLOOMBUS> {
        0x1::debug::print<u64>(&arg0.total_supply);
        0x1::debug::print<u64>(&arg2);
        0x1::debug::print<u64>(&arg0.max_supply);
        assert!(arg0.total_supply + arg2 <= arg0.max_supply, 1);
        arg0.total_supply = arg0.total_supply + arg2;
        0x2::coin::mint<FLOOMBUS>(arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

