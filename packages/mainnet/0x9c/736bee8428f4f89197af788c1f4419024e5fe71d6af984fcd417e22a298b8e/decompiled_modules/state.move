module 0x9c736bee8428f4f89197af788c1f4419024e5fe71d6af984fcd417e22a298b8e::state {
    struct FeeManagerStateCreated has copy, drop {
        state: 0x2::object::ID,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct TokenKey has copy, drop, store {
        token_in: address,
        token_out: address,
        chain_dest: u8,
    }

    struct TokenConfig has store {
        one_level_amount_in: u64,
        one_level_rate: u8,
        two_level_amount_in: u64,
        two_level_rate: u8,
        three_level_amount_in: u64,
        three_level_rate: u8,
    }

    struct FeeManagerState has key {
        id: 0x2::object::UID,
        token_configs: 0x2::table::Table<TokenKey, TokenConfig>,
    }

    public fun add_token_config(arg0: &AdminCap, arg1: &mut FeeManagerState, arg2: address, arg3: address, arg4: u8, arg5: u64, arg6: u8, arg7: u64, arg8: u8, arg9: u64, arg10: u8) {
        let v0 = TokenKey{
            token_in   : arg2,
            token_out  : arg3,
            chain_dest : arg4,
        };
        let v1 = TokenConfig{
            one_level_amount_in   : arg5,
            one_level_rate        : arg6,
            two_level_amount_in   : arg7,
            two_level_rate        : arg8,
            three_level_amount_in : arg9,
            three_level_rate      : arg10,
        };
        assert!(!0x2::table::contains<TokenKey, TokenConfig>(&arg1.token_configs, v0), 0);
        0x2::table::add<TokenKey, TokenConfig>(&mut arg1.token_configs, v0, v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = FeeManagerState{
            id            : 0x2::object::new(arg0),
            token_configs : 0x2::table::new<TokenKey, TokenConfig>(arg0),
        };
        let v2 = FeeManagerStateCreated{state: 0x2::object::id<FeeManagerState>(&v1)};
        0x2::event::emit<FeeManagerStateCreated>(v2);
        0x2::transfer::share_object<FeeManagerState>(v1);
    }

    public fun update_token_config(arg0: &AdminCap, arg1: &mut FeeManagerState, arg2: address, arg3: address, arg4: u8, arg5: u64, arg6: u8, arg7: u64, arg8: u8, arg9: u64, arg10: u8) {
        let v0 = TokenKey{
            token_in   : arg2,
            token_out  : arg3,
            chain_dest : arg4,
        };
        assert!(0x2::table::contains<TokenKey, TokenConfig>(&arg1.token_configs, v0), 0);
        let v1 = 0x2::table::borrow_mut<TokenKey, TokenConfig>(&mut arg1.token_configs, v0);
        v1.one_level_amount_in = arg5;
        v1.one_level_rate = arg6;
        v1.two_level_amount_in = arg7;
        v1.two_level_rate = arg8;
        v1.three_level_amount_in = arg9;
        v1.three_level_rate = arg10;
    }

    // decompiled from Move bytecode v6
}

