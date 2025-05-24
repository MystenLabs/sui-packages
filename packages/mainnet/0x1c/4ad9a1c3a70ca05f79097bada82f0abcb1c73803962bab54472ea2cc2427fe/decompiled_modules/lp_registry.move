module 0x1c4ad9a1c3a70ca05f79097bada82f0abcb1c73803962bab54472ea2cc2427fe::lp_registry {
    struct DynamicLP<phantom T0> has drop {
        dummy_field: bool,
    }

    struct LPRegistry has key {
        id: 0x2::object::UID,
        lp_tokens: 0x2::table::Table<0x2::object::ID, LPTokenEntry>,
        counter: u64,
    }

    struct LPTokenEntry has copy, drop, store {
        pool_id: 0x2::object::ID,
        treasury_cap_id: 0x2::object::ID,
        metadata_id: 0x2::object::ID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::option::Option<0x2::url::Url>,
        decimals: u8,
        total_supply: u64,
    }

    struct LPTokenCreated has copy, drop {
        pool_id: 0x2::object::ID,
        treasury_cap_id: 0x2::object::ID,
        metadata_id: 0x2::object::ID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
    }

    public fun add_lp_token(arg0: &mut LPRegistry, arg1: LPTokenEntry) {
        0x2::table::add<0x2::object::ID, LPTokenEntry>(&mut arg0.lp_tokens, arg1.pool_id, arg1);
        arg0.counter = arg0.counter + 1;
        let v0 = LPTokenCreated{
            pool_id         : arg1.pool_id,
            treasury_cap_id : arg1.treasury_cap_id,
            metadata_id     : arg1.metadata_id,
            name            : arg1.name,
            symbol          : arg1.symbol,
        };
        0x2::event::emit<LPTokenCreated>(v0);
    }

    public fun create_lp_token_entry(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::option::Option<0x2::url::Url>, arg7: u8, arg8: u64) : LPTokenEntry {
        LPTokenEntry{
            pool_id         : arg0,
            treasury_cap_id : arg1,
            metadata_id     : arg2,
            name            : arg3,
            symbol          : arg4,
            description     : arg5,
            icon_url        : arg6,
            decimals        : arg7,
            total_supply    : arg8,
        }
    }

    public fun get_lp_info(arg0: &LPTokenEntry) : (0x1::string::String, 0x1::string::String, u8, u64) {
        (arg0.name, arg0.symbol, arg0.decimals, arg0.total_supply)
    }

    public fun get_lp_token_entry(arg0: &LPRegistry, arg1: 0x2::object::ID) : &LPTokenEntry {
        assert!(0x2::table::contains<0x2::object::ID, LPTokenEntry>(&arg0.lp_tokens, arg1), 0);
        0x2::table::borrow<0x2::object::ID, LPTokenEntry>(&arg0.lp_tokens, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LPRegistry{
            id        : 0x2::object::new(arg0),
            lp_tokens : 0x2::table::new<0x2::object::ID, LPTokenEntry>(arg0),
            counter   : 0,
        };
        0x2::transfer::share_object<LPRegistry>(v0);
    }

    public fun lp_token_exists(arg0: &LPRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, LPTokenEntry>(&arg0.lp_tokens, arg1)
    }

    public fun update_total_supply(arg0: &mut LPRegistry, arg1: 0x2::object::ID, arg2: u64) {
        0x2::table::borrow_mut<0x2::object::ID, LPTokenEntry>(&mut arg0.lp_tokens, arg1).total_supply = arg2;
    }

    // decompiled from Move bytecode v6
}

