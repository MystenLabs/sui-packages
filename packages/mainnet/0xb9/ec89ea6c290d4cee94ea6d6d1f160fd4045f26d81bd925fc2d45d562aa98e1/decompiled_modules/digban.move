module 0xb9ec89ea6c290d4cee94ea6d6d1f160fd4045f26d81bd925fc2d45d562aa98e1::digban {
    struct MyDIGBAN has key {
        id: 0x2::object::UID,
        max_supply: u64,
        total_supply: u64,
        name: vector<u8>,
        symbol: vector<u8>,
        description: vector<u8>,
        image_url: 0x2::url::Url,
    }

    struct DIGBAN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut MyDIGBAN, arg1: &mut 0x2::coin::TreasuryCap<DIGBAN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<DIGBAN> {
        0x1::debug::print<u64>(&arg0.total_supply);
        0x1::debug::print<u64>(&arg2);
        0x1::debug::print<u64>(&arg0.max_supply);
        assert!(arg0.total_supply + arg2 <= arg0.max_supply, 1);
        arg0.total_supply = arg0.total_supply + arg2;
        0x2::coin::mint<DIGBAN>(arg1, arg2, arg3)
    }

    fun init(arg0: DIGBAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::url::new_unsafe_from_bytes(b"https://red-rainy-catfish-636.mypinata.cloud/ipfs/QmfF9erhWqxTqrMjeX5w9NtqqLdh7bkKxeBFKGSHDeNudY");
        let v1 = MyDIGBAN{
            id           : 0x2::object::new(arg1),
            max_supply   : 10000000000000,
            total_supply : 0,
            name         : b"DIGBAN",
            symbol       : b"DIGBAN",
            description  : b"This is my awesome DIGBAN",
            image_url    : v0,
        };
        let (v2, v3) = 0x2::coin::create_currency<DIGBAN>(arg0, 9, b"DIGBAN", b"My Awesome DIGBAN", b"This is my awesome DIGBAN", 0x1::option::some<0x2::url::Url>(v0), arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIGBAN>>(v3);
        let v5 = 10000000000000;
        let v6 = &mut v1;
        let v7 = &mut v4;
        let v8 = mint(v6, v7, v5, arg1);
        v1.total_supply = v5;
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIGBAN>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<MyDIGBAN>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<DIGBAN>>(v8, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

