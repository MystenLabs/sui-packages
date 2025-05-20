module 0x13b60317379f0853a3466cfe9e459907187c5289761a8dccb2eebee4f0e9c4fa::abc {
    struct ABC has drop {
        dummy_field: bool,
    }

    struct UyAwesomeTokenCap has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<ABC>,
    }

    struct CoinMetadata has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        decimals: u8,
        icon_url: 0x1::option::Option<0x2::url::Url>,
    }

    struct MintEvent has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct BurnEvent has copy, drop {
        amount: u64,
    }

    public entry fun burn(arg0: &mut UyAwesomeTokenCap, arg1: 0x2::coin::Coin<ABC>) {
        let v0 = 0x2::coin::value<ABC>(&arg1);
        assert!(v0 > 0, 0);
        0x2::coin::burn<ABC>(&mut arg0.treasury, arg1);
        let v1 = BurnEvent{amount: v0};
        0x2::event::emit<BurnEvent>(v1);
    }

    public fun get_metadata(arg0: &CoinMetadata) : (0x1::string::String, 0x1::string::String, 0x1::string::String, u8, 0x1::option::Option<0x2::url::Url>) {
        (arg0.name, arg0.symbol, arg0.description, arg0.decimals, arg0.icon_url)
    }

    fun init(arg0: ABC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABC>(arg0, 5, b"ABC", b"BestToken", b"description containing multiple words and special characters!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/SXytMt5b/panda.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABC>>(v1);
        0x2::coin::mint_and_transfer<ABC>(&mut v2, 1000000000, @0x3f3c5b496a3587aa81b13d70c0681f3b468a6d282fa962b4a2db4ebec16fa6c, arg1);
        let v3 = UyAwesomeTokenCap{
            id       : 0x2::object::new(arg1),
            treasury : v2,
        };
        0x2::transfer::public_transfer<UyAwesomeTokenCap>(v3, @0x3f3c5b496a3587aa81b13d70c0681f3b468a6d282fa962b4a2db4ebec16fa6c);
    }

    public entry fun mint(arg0: &mut UyAwesomeTokenCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 0);
        0x2::coin::mint_and_transfer<ABC>(&mut arg0.treasury, arg1, arg2, arg3);
        let v0 = MintEvent{
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public entry fun transfer_token(arg0: 0x2::coin::Coin<ABC>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ABC>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

