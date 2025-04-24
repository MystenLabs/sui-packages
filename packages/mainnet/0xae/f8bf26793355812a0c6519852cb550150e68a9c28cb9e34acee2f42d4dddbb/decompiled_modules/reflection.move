module 0xaef8bf26793355812a0c6519852cb550150e68a9c28cb9e34acee2f42d4dddbb::reflection {
    struct REFLECTION has drop {
        dummy_field: bool,
    }

    struct ReflectionConfig has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        fee_basis_points: u64,
        min_tokens_for_reflection: u64,
        team_wallet: address,
        team_percentage: u64,
        developer_wallet: address,
        developer_percentage: u64,
        owner: address,
    }

    struct FeeCollector has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<REFLECTION>,
        last_distribution_time: u64,
    }

    struct HolderRegistry has key {
        id: 0x2::object::UID,
        holders: 0x2::table::Table<address, u64>,
        total_supply: u64,
    }

    struct DistributionEvent has copy, drop {
        amount: u64,
        holders_count: u64,
        timestamp: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<REFLECTION>, arg1: u64, arg2: address, arg3: &mut HolderRegistry, arg4: &mut 0x2::tx_context::TxContext) {
        update_holder_balance(arg3, arg2, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<REFLECTION>>(0x2::coin::mint<REFLECTION>(arg0, arg1, arg4), arg2);
    }

    fun init(arg0: REFLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REFLECTION>(arg0, 9, b"WONKA", b"willy", b"Token with automatic reflections to holders", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        let v3 = ReflectionConfig{
            id                        : 0x2::object::new(arg1),
            name                      : 0x1::string::utf8(b"willy"),
            symbol                    : 0x1::string::utf8(b"WONKA"),
            fee_basis_points          : 500,
            min_tokens_for_reflection : 100000000000,
            team_wallet               : @0x0,
            team_percentage           : 0,
            developer_wallet          : @0x0,
            developer_percentage      : 5,
            owner                     : 0x2::tx_context::sender(arg1),
        };
        let v4 = FeeCollector{
            id                     : 0x2::object::new(arg1),
            balance                : 0x2::balance::zero<REFLECTION>(),
            last_distribution_time : 0x2::tx_context::epoch(arg1),
        };
        let v5 = HolderRegistry{
            id           : 0x2::object::new(arg1),
            holders      : 0x2::table::new<address, u64>(arg1),
            total_supply : 0,
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REFLECTION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REFLECTION>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<ReflectionConfig>(v3);
        0x2::transfer::share_object<FeeCollector>(v4);
        0x2::transfer::share_object<HolderRegistry>(v5);
    }

    public entry fun update_config(arg0: &AdminCap, arg1: &mut ReflectionConfig, arg2: u64, arg3: u64, arg4: address, arg5: u64, arg6: address, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 2000, 4);
        arg1.fee_basis_points = arg2;
        arg1.min_tokens_for_reflection = arg3;
        arg1.team_wallet = arg4;
        arg1.team_percentage = arg5;
        arg1.developer_wallet = arg6;
        arg1.developer_percentage = arg7;
    }

    fun update_holder_balance(arg0: &mut HolderRegistry, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, u64>(&arg0.holders, arg1)) {
            if (arg2 > 0) {
                0x2::table::add<address, u64>(&mut arg0.holders, arg1, arg2);
            };
            arg0.total_supply = arg0.total_supply + arg2 - 0x2::table::remove<address, u64>(&mut arg0.holders, arg1);
        } else if (arg2 > 0) {
            0x2::table::add<address, u64>(&mut arg0.holders, arg1, arg2);
            arg0.total_supply = arg0.total_supply + arg2;
        };
    }

    // decompiled from Move bytecode v6
}

