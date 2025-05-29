module 0x1675a4f63cfd2933b99c3acb96160832b46c7259ea3d103e6c061b4924de36a::launchpad {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TUSK_TOKEN has drop {
        dummy_field: bool,
    }

    struct TokenPool has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::option::Option<0x2::url::Url>,
        total_supply: u64,
        minted: u64,
        treasury: 0x2::coin::TreasuryCap<TUSK_TOKEN>,
        reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        base_price: u64,
        slope: u64,
        active: bool,
    }

    struct TokenLaunched has copy, drop {
        pool_id: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        total_supply: u64,
        base_price: u64,
        slope: u64,
    }

    struct TokensMinted has copy, drop {
        pool_id: address,
        amount: u64,
        sui_bonded: u64,
        buyer: address,
    }

    struct DebugEvent has copy, drop {
        stage: 0x1::string::String,
    }

    public entry fun create_admin_cap(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun create_token(arg0: &AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = DebugEvent{stage: 0x1::string::utf8(b"start")};
        0x2::event::emit<DebugEvent>(v0);
        let v1 = 0x1::string::utf8(arg1);
        let v2 = 0x1::string::utf8(arg2);
        let v3 = 0x1::string::utf8(arg3);
        let v4 = if (0x1::vector::length<u8>(&arg4) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(arg4))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        assert!(0x1::string::length(&v1) >= 3 && 0x1::string::length(&v1) <= 32, 1);
        let v5 = DebugEvent{stage: 0x1::string::utf8(b"name_validated")};
        0x2::event::emit<DebugEvent>(v5);
        assert!(0x1::string::length(&v2) >= 2 && 0x1::string::length(&v2) <= 8, 2);
        let v6 = DebugEvent{stage: 0x1::string::utf8(b"symbol_validated")};
        0x2::event::emit<DebugEvent>(v6);
        assert!(arg6 > 0, 6);
        let v7 = DebugEvent{stage: 0x1::string::utf8(b"base_price_validated")};
        0x2::event::emit<DebugEvent>(v7);
        let v8 = 1000000000;
        let v9 = 2 * (arg5 - arg6 * v8) / v8 * v8;
        let v10 = DebugEvent{stage: 0x1::string::utf8(b"bonding_curve_calculated")};
        0x2::event::emit<DebugEvent>(v10);
        let v11 = TUSK_TOKEN{dummy_field: false};
        let (v12, v13) = 0x2::coin::create_currency<TUSK_TOKEN>(v11, 9, arg2, arg1, arg3, v4, arg7);
        let v14 = DebugEvent{stage: 0x1::string::utf8(b"currency_created")};
        0x2::event::emit<DebugEvent>(v14);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUSK_TOKEN>>(v13);
        let v15 = DebugEvent{stage: 0x1::string::utf8(b"metadata_frozen")};
        0x2::event::emit<DebugEvent>(v15);
        let v16 = TokenPool{
            id           : 0x2::object::new(arg7),
            name         : v1,
            symbol       : v2,
            description  : v3,
            icon_url     : v4,
            total_supply : 1000000000,
            minted       : 0,
            treasury     : v12,
            reserve      : 0x2::balance::zero<0x2::sui::SUI>(),
            base_price   : arg6,
            slope        : v9,
            active       : true,
        };
        let v17 = DebugEvent{stage: 0x1::string::utf8(b"pool_created")};
        0x2::event::emit<DebugEvent>(v17);
        let v18 = TokenLaunched{
            pool_id      : 0x2::object::uid_to_address(&v16.id),
            name         : v1,
            symbol       : v2,
            description  : v3,
            total_supply : 1000000000,
            base_price   : arg6,
            slope        : v9,
        };
        0x2::event::emit<TokenLaunched>(v18);
        let v19 = DebugEvent{stage: 0x1::string::utf8(b"launch_event_emitted")};
        0x2::event::emit<DebugEvent>(v19);
        0x2::transfer::public_share_object<TokenPool>(v16);
        let v20 = DebugEvent{stage: 0x1::string::utf8(b"pool_shared")};
        0x2::event::emit<DebugEvent>(v20);
    }

    public fun get_price(arg0: &TokenPool, arg1: u64) : u64 {
        assert!(arg0.active, 4);
        assert!(arg0.minted + arg1 <= arg0.total_supply, 5);
        (arg0.base_price + arg0.slope * arg0.minted + arg0.base_price + arg0.slope * (arg0.minted + arg1)) / 2 * arg1
    }

    public entry fun mint_tokens(arg0: &mut TokenPool, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 4);
        assert!(arg0.minted + arg1 <= arg0.total_supply, 5);
        let v0 = get_price(arg0, arg1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v0, 3);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reserve, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v0));
        arg0.minted = arg0.minted + arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<TUSK_TOKEN>>(0x2::coin::mint<TUSK_TOKEN>(&mut arg0.treasury, arg1, arg3), 0x2::tx_context::sender(arg3));
        if (0x2::balance::value<0x2::sui::SUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        };
        let v2 = TokensMinted{
            pool_id    : 0x2::object::uid_to_address(&arg0.id),
            amount     : arg1,
            sui_bonded : v0,
            buyer      : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<TokensMinted>(v2);
    }

    // decompiled from Move bytecode v6
}

