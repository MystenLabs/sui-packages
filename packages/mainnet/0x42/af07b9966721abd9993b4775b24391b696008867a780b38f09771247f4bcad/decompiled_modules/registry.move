module 0x42af07b9966721abd9993b4775b24391b696008867a780b38f09771247f4bcad::registry {
    struct REGISTRY has drop {
        dummy_field: bool,
    }

    struct MarketKey has copy, drop, store {
        underlying: 0x1::type_name::TypeName,
        strike: 0x1::type_name::TypeName,
    }

    struct LedgerInfo has copy, drop, store {
        ledger_id: 0x2::object::ID,
        underlying: 0x1::type_name::TypeName,
        strike: 0x1::type_name::TypeName,
    }

    struct LedgerRegistry has key {
        id: 0x2::object::UID,
        markets: 0x2::table::Table<MarketKey, 0x2::object::ID>,
        valid_ledgers: 0x2::vec_set::VecSet<0x2::object::ID>,
        all_ledgers: vector<LedgerInfo>,
    }

    struct MarketCreated has copy, drop {
        ledger_id: 0x2::object::ID,
        underlying: 0x1::ascii::String,
        strike: 0x1::ascii::String,
    }

    public fun assert_valid_ledger<T0, T1>(arg0: &LedgerRegistry, arg1: &0x42af07b9966721abd9993b4775b24391b696008867a780b38f09771247f4bcad::ledger::Ledger<T0, T1>) {
        assert!(is_valid_ledger(arg0, 0x2::object::id<0x42af07b9966721abd9993b4775b24391b696008867a780b38f09771247f4bcad::ledger::Ledger<T0, T1>>(arg1)), 202);
    }

    public fun create_market<T0, T1>(arg0: &mut LedgerRegistry, arg1: &0x42af07b9966721abd9993b4775b24391b696008867a780b38f09771247f4bcad::access_control::AdminCap, arg2: &0x42af07b9966721abd9993b4775b24391b696008867a780b38f09771247f4bcad::access_control::CapabilityRegistry, arg3: &mut 0x42af07b9966721abd9993b4775b24391b696008867a780b38f09771247f4bcad::token_validator::TokenRegistry, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::coin::CoinMetadata<T1>, arg6: u8, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x42af07b9966721abd9993b4775b24391b696008867a780b38f09771247f4bcad::access_control::assert_admin_active(arg1, arg2);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x1::type_name::with_original_ids<T1>();
        assert!(v0 != v1, 201);
        let v2 = MarketKey{
            underlying : v0,
            strike     : v1,
        };
        assert!(!0x2::table::contains<MarketKey, 0x2::object::ID>(&arg0.markets, v2), 200);
        if (!0x42af07b9966721abd9993b4775b24391b696008867a780b38f09771247f4bcad::token_validator::is_whitelisted<T0>(arg3)) {
            0x42af07b9966721abd9993b4775b24391b696008867a780b38f09771247f4bcad::token_validator::add_token<T0>(arg1, arg2, arg3, arg4, arg6, arg8);
        };
        if (!0x42af07b9966721abd9993b4775b24391b696008867a780b38f09771247f4bcad::token_validator::is_whitelisted<T1>(arg3)) {
            0x42af07b9966721abd9993b4775b24391b696008867a780b38f09771247f4bcad::token_validator::add_token<T1>(arg1, arg2, arg3, arg5, arg7, arg8);
        };
        let v3 = 0x42af07b9966721abd9993b4775b24391b696008867a780b38f09771247f4bcad::ledger::create<T0, T1>(arg3, arg8);
        0x2::table::add<MarketKey, 0x2::object::ID>(&mut arg0.markets, v2, v3);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.valid_ledgers, v3);
        let v4 = LedgerInfo{
            ledger_id  : v3,
            underlying : v0,
            strike     : v1,
        };
        0x1::vector::push_back<LedgerInfo>(&mut arg0.all_ledgers, v4);
        let v5 = MarketCreated{
            ledger_id  : v3,
            underlying : 0x1::type_name::into_string(v0),
            strike     : 0x1::type_name::into_string(v1),
        };
        0x2::event::emit<MarketCreated>(v5);
        v3
    }

    public fun get_all_ledgers(arg0: &LedgerRegistry) : &vector<LedgerInfo> {
        &arg0.all_ledgers
    }

    public fun get_ledger_id<T0, T1>(arg0: &LedgerRegistry) : 0x1::option::Option<0x2::object::ID> {
        get_ledger_id_by_types(arg0, 0x1::type_name::with_original_ids<T0>(), 0x1::type_name::with_original_ids<T1>())
    }

    public fun get_ledger_id_by_types(arg0: &LedgerRegistry, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName) : 0x1::option::Option<0x2::object::ID> {
        let v0 = MarketKey{
            underlying : arg1,
            strike     : arg2,
        };
        if (0x2::table::contains<MarketKey, 0x2::object::ID>(&arg0.markets, v0)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<MarketKey, 0x2::object::ID>(&arg0.markets, v0))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    fun init(arg0: REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = LedgerRegistry{
            id            : 0x2::object::new(arg1),
            markets       : 0x2::table::new<MarketKey, 0x2::object::ID>(arg1),
            valid_ledgers : 0x2::vec_set::empty<0x2::object::ID>(),
            all_ledgers   : 0x1::vector::empty<LedgerInfo>(),
        };
        0x2::transfer::share_object<LedgerRegistry>(v0);
    }

    public fun is_valid_ledger(arg0: &LedgerRegistry, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.valid_ledgers, &arg1)
    }

    public fun market_count(arg0: &LedgerRegistry) : u64 {
        0x1::vector::length<LedgerInfo>(&arg0.all_ledgers)
    }

    public fun market_exists<T0, T1>(arg0: &LedgerRegistry) : bool {
        let v0 = MarketKey{
            underlying : 0x1::type_name::with_original_ids<T0>(),
            strike     : 0x1::type_name::with_original_ids<T1>(),
        };
        0x2::table::contains<MarketKey, 0x2::object::ID>(&arg0.markets, v0)
    }

    // decompiled from Move bytecode v6
}

