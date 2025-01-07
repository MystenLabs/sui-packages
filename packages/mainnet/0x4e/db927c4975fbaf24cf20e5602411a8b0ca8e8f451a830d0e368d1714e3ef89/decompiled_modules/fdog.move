module 0x4edb927c4975fbaf24cf20e5602411a8b0ca8e8f451a830d0e368d1714e3ef89::fdog {
    struct FDOG has drop {
        dummy_field: bool,
    }

    struct CONTRACT_MEMORY has store, key {
        id: 0x2::object::UID,
        owner: address,
        mint_price: u64,
        close_mint: bool,
    }

    struct MainNetNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun transfer(arg0: MainNetNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<MainNetNFT>(arg0, arg1);
    }

    public fun url(arg0: &MainNetNFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun closeMint(arg0: &mut CONTRACT_MEMORY, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 2);
        arg0.close_mint = true;
    }

    public fun description(arg0: &MainNetNFT) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: FDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = CONTRACT_MEMORY{
            id         : 0x2::object::new(arg1),
            owner      : v0,
            mint_price : 1000000000,
            close_mint : false,
        };
        let (v2, v3) = 0x2::coin::create_currency<FDOG>(arg0, 9, b"FDOG", b"FDOG", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fdoge.xyz/assets/images/icon.png")), arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FDOG>>(v3);
        0x2::coin::mint_and_transfer<FDOG>(&mut v4, 100000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDOG>>(v4, v0);
        0x2::transfer::transfer<CONTRACT_MEMORY>(v1, v0);
    }

    public fun mint_to_sender(arg0: &mut CONTRACT_MEMORY, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.mint_price && arg0.close_mint == false, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.owner);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = MainNetNFT{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg2),
            description : 0x1::string::utf8(arg3),
            url         : 0x2::url::new_unsafe_from_bytes(arg4),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<MainNetNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<MainNetNFT>(v1, v0);
    }

    public fun name(arg0: &MainNetNFT) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

