module 0x9c89e06e2afca37c9d2c8fee259c25275294ee13a4409a52ed970f024c8005aa::boocat {
    struct MyBOOCAT has key {
        id: 0x2::object::UID,
        max_supply: u64,
        total_supply: u64,
        name: vector<u8>,
        symbol: vector<u8>,
        description: vector<u8>,
        image_url: 0x2::url::Url,
    }

    struct BOOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::url::new_unsafe_from_bytes(b"https://red-rainy-catfish-636.mypinata.cloud/ipfs/QmW2pFXSgEXbYVpNtktumie4pdKaFD4jiLsxEnU9Ygu7Mw");
        let v1 = MyBOOCAT{
            id           : 0x2::object::new(arg1),
            max_supply   : 10000000000000000000,
            total_supply : 0,
            name         : b"BOOCAT",
            symbol       : b"BOOCAT",
            description  : b"This is my BOOCAT",
            image_url    : v0,
        };
        let (v2, v3) = 0x2::coin::create_currency<BOOCAT>(arg0, 9, b"BOOCAT", b"BOOCAT", b"Scared? Don't be! I'm your friendly meme token bringing fun and surprises to the crypto world!", 0x1::option::some<0x2::url::Url>(v0), arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOCAT>>(v3);
        let v5 = 10000000000000000000;
        let v6 = &mut v1;
        let v7 = &mut v4;
        let v8 = mint_initial(v6, v7, v5, arg1);
        v1.total_supply = v5;
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BOOCAT>>(v4);
        0x2::transfer::transfer<MyBOOCAT>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<BOOCAT>>(v8, 0x2::tx_context::sender(arg1));
    }

    fun mint_initial(arg0: &mut MyBOOCAT, arg1: &mut 0x2::coin::TreasuryCap<BOOCAT>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BOOCAT> {
        0x1::debug::print<u64>(&arg0.total_supply);
        0x1::debug::print<u64>(&arg2);
        0x1::debug::print<u64>(&arg0.max_supply);
        assert!(arg0.total_supply + arg2 <= arg0.max_supply, 1);
        arg0.total_supply = arg0.total_supply + arg2;
        0x2::coin::mint<BOOCAT>(arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

