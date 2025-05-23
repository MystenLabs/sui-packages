module 0x22cac18d673c28bb29a69bf1cc4b86344d81e1ae29d9bd2220745f75e4c980c::mat {
    struct MAT has drop {
        dummy_field: bool,
    }

    struct MyTokenCap has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<MAT>,
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

    public entry fun burn(arg0: &mut MyTokenCap, arg1: 0x2::coin::Coin<MAT>) {
        let v0 = 0x2::coin::value<MAT>(&arg1);
        assert!(v0 > 0, 0);
        0x2::coin::burn<MAT>(&mut arg0.treasury, arg1);
        let v1 = BurnEvent{amount: v0};
        0x2::event::emit<BurnEvent>(v1);
    }

    public fun get_metadata(arg0: &CoinMetadata) : (0x1::string::String, 0x1::string::String, 0x1::string::String, u8, 0x1::option::Option<0x2::url::Url>) {
        (arg0.name, arg0.symbol, arg0.description, arg0.decimals, arg0.icon_url)
    }

    fun init(arg0: MAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAT>(arg0, 9, b"MAT", b"My Awesome Token", b"This is a test token for demonstration purposes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/token-icon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAT>>(v1);
        0x2::coin::mint_and_transfer<MAT>(&mut v2, 1000000000000, @0x123456789abcdef123456789abcdef123456789abcdef123456789abcdef1234, arg1);
        let v3 = MyTokenCap{
            id       : 0x2::object::new(arg1),
            treasury : v2,
        };
        0x2::transfer::public_transfer<MyTokenCap>(v3, @0x123456789abcdef123456789abcdef123456789abcdef123456789abcdef1234);
    }

    public entry fun mint(arg0: &mut MyTokenCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 0);
        0x2::coin::mint_and_transfer<MAT>(&mut arg0.treasury, arg1, arg2, arg3);
        let v0 = MintEvent{
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public entry fun transfer_token(arg0: 0x2::coin::Coin<MAT>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MAT>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

