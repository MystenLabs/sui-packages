module 0x52646a9931b961c292e202dd8cd36351a9ac74912e71cdd6694e3515546b63c5::state {
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
        fee_collector: address,
        token_configs: 0x2::table::Table<TokenKey, TokenConfig>,
        version_set: 0x2::vec_set::VecSet<u64>,
        latest_package_id: address,
    }

    public(friend) fun new(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_set::empty<u64>();
        0x2::vec_set::insert<u64>(&mut v0, 1);
        let v1 = FeeManagerState{
            id                : 0x2::object::new(arg1),
            fee_collector     : 0x2::tx_context::sender(arg1),
            token_configs     : 0x2::table::new<TokenKey, TokenConfig>(arg1),
            version_set       : v0,
            latest_package_id : arg0,
        };
        let v2 = FeeManagerStateCreated{state: 0x2::object::id<FeeManagerState>(&v1)};
        0x2::event::emit<FeeManagerStateCreated>(v2);
        0x2::transfer::share_object<FeeManagerState>(v1);
    }

    entry fun add_compatible_state_version(arg0: &AdminCap, arg1: address, arg2: &mut FeeManagerState) {
        assert!(max_compatible_state_version(arg2) < current_state_version(), 2);
        0x2::vec_set::insert<u64>(&mut arg2.version_set, current_state_version());
        arg2.latest_package_id = arg1;
    }

    entry fun add_token_config(arg0: &AdminCap, arg1: &mut FeeManagerState, arg2: address, arg3: address, arg4: u8, arg5: u64, arg6: u8, arg7: u64, arg8: u8, arg9: u64, arg10: u8) {
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

    public fun assert_valid_version(arg0: &FeeManagerState) {
        let v0 = current_state_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 2);
    }

    public fun current_state_version() : u64 {
        1
    }

    public fun get_fee_collector(arg0: &FeeManagerState) : address {
        assert_valid_version(arg0);
        arg0.fee_collector
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun max_compatible_state_version(arg0: &FeeManagerState) : u64 {
        let v0 = 0x2::vec_set::keys<u64>(&arg0.version_set);
        let v1 = 0x1::vector::length<u64>(v0);
        assert!(v1 > 0, 1);
        let v2 = *0x1::vector::borrow<u64>(v0, 0);
        let v3 = 1;
        while (v3 < v1) {
            let v4 = *0x1::vector::borrow<u64>(v0, v3);
            if (v4 > v2) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        v2
    }

    entry fun remove_old_state_version(arg0: &AdminCap, arg1: &mut FeeManagerState, arg2: u64) {
        assert_valid_version(arg1);
        assert!(current_state_version() > arg2, 2);
        0x2::vec_set::remove<u64>(&mut arg1.version_set, &arg2);
    }

    entry fun update_fee_collector(arg0: &AdminCap, arg1: &mut FeeManagerState, arg2: address) {
        arg1.fee_collector = arg2;
    }

    entry fun update_token_config(arg0: &AdminCap, arg1: &mut FeeManagerState, arg2: address, arg3: address, arg4: u8, arg5: u64, arg6: u8, arg7: u64, arg8: u8, arg9: u64, arg10: u8) {
        let v0 = TokenKey{
            token_in   : arg2,
            token_out  : arg3,
            chain_dest : arg4,
        };
        assert!(0x2::table::contains<TokenKey, TokenConfig>(&arg1.token_configs, v0), 1);
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

