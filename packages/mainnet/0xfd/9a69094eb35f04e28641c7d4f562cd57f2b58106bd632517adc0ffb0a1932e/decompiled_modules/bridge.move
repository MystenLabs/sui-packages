module 0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::bridge {
    struct Bridge has store, key {
        id: 0x2::object::UID,
        sign: 0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::sign::BridgeSign,
        treasury: 0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::treasury::BridgeTreasury,
        deposit: 0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::deposit::BridgeDeposit,
        config: 0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::config::BridgeConfig,
        claimed: 0x2::table::Table<0x1::ascii::String, 0x2::table::Table<u64, bool>>,
        sequence_num: u64,
        version: u64,
    }

    struct BridgeCap has store, key {
        id: 0x2::object::UID,
    }

    struct BridgeInfo has copy, drop, store {
        pairs: vector<0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::config::BridgePair>,
        signers: vector<address>,
        treasuries: vector<0x1::type_name::TypeName>,
        depositkeys: vector<0x1::type_name::TypeName>,
    }

    struct BridgePairInfo has copy, drop {
        pair: 0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::config::BridgePair,
    }

    struct BridgeTokenInfo has copy, drop {
        from_token: 0x1::type_name::TypeName,
        to_token: 0x1::ascii::String,
        fee: u64,
        fee_type: u8,
        min_limit: u64,
        max_limit: u64,
        balance: u64,
        fee_balance: u64,
        treasury_exist: bool,
    }

    struct BridgeTokenBalance has copy, drop {
        balance: u64,
        fee_balance: u64,
        treasury_exist: bool,
    }

    struct TokenDeposited has copy, drop {
        sequence: u64,
        sender: address,
        from_token: 0x1::type_name::TypeName,
        amount_in: u64,
        fee: u64,
        timestamp: u64,
        to_token: 0x1::ascii::String,
        destination: 0x1::ascii::String,
    }

    struct TokenClaimed has copy, drop {
        destination: address,
        to_token: 0x1::type_name::TypeName,
        amount_out: u64,
        timestamp: u64,
        from_token: 0x1::ascii::String,
        sequence: u64,
    }

    public entry fun add_treasury_cap<T0>(arg0: &mut BridgeCap, arg1: &mut Bridge, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::treasury::add_treasury_cap<T0>(&mut arg1.treasury, arg2);
    }

    public fun bridge_info(arg0: &Bridge) : BridgeInfo {
        check_version(arg0);
        BridgeInfo{
            pairs       : 0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::config::pair_list(&arg0.config),
            signers     : 0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::sign::info(&arg0.sign),
            treasuries  : 0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::treasury::all_treasury_cap(&arg0.treasury),
            depositkeys : 0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::deposit::all_deposit_keys(&arg0.deposit),
        }
    }

    public entry fun bridge_info_entry(arg0: &Bridge) {
        check_version(arg0);
        0x2::event::emit<BridgeInfo>(bridge_info(arg0));
    }

    entry fun bridge_pair_info_entry(arg0: &Bridge, arg1: u64) {
        check_version(arg0);
        let v0 = BridgePairInfo{pair: *0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::config::find_pair_by_id(&arg0.config, arg1)};
        0x2::event::emit<BridgePairInfo>(v0);
    }

    public entry fun bridge_token<T0>(arg0: &mut Bridge, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        arg0.sequence_num = arg0.sequence_num + 1;
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let v1 = 0x2::balance::value<T0>(&v0);
        let v2 = 0x2::tx_context::sender(arg5);
        assert!(0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::config::can_bridge<T0>(&arg0.config, arg3, v2, v1), 3);
        assert!(v1 > 0, 4);
        let v3 = 0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::config::cal_fee<T0>(&mut arg0.config, v2, v1, arg3);
        assert!(v1 > v3, 5);
        if (v3 > 0) {
            0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::deposit::deposit_fee<T0>(&mut arg0.deposit, 0x2::balance::split<T0>(&mut v0, v3));
        };
        if (is_treasury_exist<T0>(arg0)) {
            0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::treasury::burn<T0>(&mut arg0.treasury, 0x2::coin::from_balance<T0>(v0, arg5), arg5);
        } else {
            0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::deposit::deposit<T0>(&mut arg0.deposit, v0);
        };
        let v4 = TokenDeposited{
            sequence    : arg0.sequence_num,
            sender      : v2,
            from_token  : 0x1::type_name::get<T0>(),
            amount_in   : v1,
            fee         : v3,
            timestamp   : 0x2::clock::timestamp_ms(arg4) / 1000,
            to_token    : arg3,
            destination : arg2,
        };
        0x2::event::emit<TokenDeposited>(v4);
    }

    public fun bridge_token_balance<T0>(arg0: &Bridge) : BridgeTokenBalance {
        check_version(arg0);
        let v0 = &arg0.deposit;
        BridgeTokenBalance{
            balance        : 0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::deposit::deposit_balance<T0>(v0),
            fee_balance    : 0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::deposit::deposit_fee_balance<T0>(v0),
            treasury_exist : is_treasury_exist<T0>(arg0),
        }
    }

    public fun bridge_token_info<T0>(arg0: &Bridge, arg1: u64) : BridgeTokenInfo {
        check_version(arg0);
        let v0 = 0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::config::find_pair_by_id(&arg0.config, arg1);
        let (v1, v2) = 0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::config::pair_token_info(v0);
        assert!(v1 == 0x1::type_name::get<T0>(), 8);
        let (v3, v4, v5, v6) = 0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::config::pair_fee_info(v0);
        BridgeTokenInfo{
            from_token     : v1,
            to_token       : v2,
            fee            : v3,
            fee_type       : v4,
            min_limit      : v5,
            max_limit      : v6,
            balance        : 0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::deposit::deposit_balance<T0>(&arg0.deposit),
            fee_balance    : 0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::deposit::deposit_fee_balance<T0>(&arg0.deposit),
            treasury_exist : is_treasury_exist<T0>(arg0),
        }
    }

    entry fun bridge_token_info_entry<T0>(arg0: &Bridge, arg1: u64) {
        check_version(arg0);
        0x2::event::emit<BridgeTokenInfo>(bridge_token_info<T0>(arg0, arg1));
    }

    fun check_version(arg0: &Bridge) {
        assert!(arg0.version == 1, 1);
    }

    public entry fun claim_bridge_fee<T0>(arg0: &mut BridgeCap, arg1: &mut Bridge, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::deposit::claim_fee<T0>(&mut arg1.deposit, arg3), arg4), arg2);
    }

    public entry fun claim_token<T0>(arg0: &mut Bridge, arg1: address, arg2: u64, arg3: 0x1::ascii::String, arg4: u64, arg5: vector<vector<u8>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::sign::verify_signatures<T0>(&arg0.sign, arg5, arg1, arg2, arg3, arg4);
        let v0 = 0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::string_utils::get_bridge_chain_identify(&arg3);
        if (0x2::table::contains<0x1::ascii::String, 0x2::table::Table<u64, bool>>(&arg0.claimed, v0)) {
            let v1 = 0x2::table::borrow_mut<0x1::ascii::String, 0x2::table::Table<u64, bool>>(&mut arg0.claimed, v0);
            if (0x2::table::contains<u64, bool>(v1, arg4)) {
                abort 6
            };
            0x2::table::add<u64, bool>(v1, arg4, true);
        } else {
            let v2 = 0x2::table::new<u64, bool>(arg7);
            0x2::table::add<u64, bool>(&mut v2, arg4, true);
            0x2::table::add<0x1::ascii::String, 0x2::table::Table<u64, bool>>(&mut arg0.claimed, v0, v2);
        };
        let v3 = if (is_treasury_exist<T0>(arg0)) {
            0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::treasury::mint<T0>(&mut arg0.treasury, arg2, arg7)
        } else {
            0x2::coin::from_balance<T0>(0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::deposit::claim<T0>(&mut arg0.deposit, arg2), arg7)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, arg1);
        let v4 = TokenClaimed{
            destination : arg1,
            to_token    : 0x1::type_name::get<T0>(),
            amount_out  : arg2,
            timestamp   : 0x2::clock::timestamp_ms(arg6) / 1000,
            from_token  : arg3,
            sequence    : arg4,
        };
        0x2::event::emit<TokenClaimed>(v4);
    }

    public entry fun claim_token_batch<T0>(arg0: &mut Bridge, arg1: vector<address>, arg2: vector<u64>, arg3: vector<0x1::ascii::String>, arg4: vector<u64>, arg5: vector<vector<vector<u8>>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        let v1 = if (0x1::vector::length<u64>(&arg2) == v0) {
            if (0x1::vector::length<0x1::ascii::String>(&arg3) == v0) {
                if (0x1::vector::length<u64>(&arg4) == v0) {
                    0x1::vector::length<vector<vector<u8>>>(&arg5) == v0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 7);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg1)) {
            claim_token<T0>(arg0, *0x1::vector::borrow<address>(&arg1, v2), *0x1::vector::borrow<u64>(&arg2, v2), *0x1::vector::borrow<0x1::ascii::String>(&arg3, v2), *0x1::vector::borrow<u64>(&arg4, v2), *0x1::vector::borrow<vector<vector<u8>>>(&arg5, v2), arg6, arg7);
            v2 = v2 + 1;
        };
    }

    public entry fun claim_treasury_cap<T0>(arg0: &mut BridgeCap, arg1: &mut Bridge, arg2: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::treasury::claim_treasury_cap<T0>(&mut arg1.treasury), 0x2::tx_context::sender(arg2));
    }

    public fun create_bridge_pair<T0>(arg0: &mut BridgeCap, arg1: &mut Bridge, arg2: vector<0x1::ascii::String>, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::config::create_bridge_pair<T0>(&mut arg1.config, arg2, arg3);
    }

    public fun create_special_bridge_pair<T0>(arg0: &mut BridgeCap, arg1: &mut Bridge, arg2: 0x1::ascii::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::config::create_special_bridge_pair<T0>(&mut arg1.config, arg2, arg3, arg4);
    }

    public fun delete_bridge_pair(arg0: &mut BridgeCap, arg1: &mut Bridge, arg2: u64) {
        check_version(arg1);
        0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::config::delete_bridge_pair(&mut arg1.config, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bridge{
            id           : 0x2::object::new(arg0),
            sign         : 0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::sign::create(),
            treasury     : 0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::treasury::create(arg0),
            deposit      : 0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::deposit::create(arg0),
            config       : 0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::config::create(arg0),
            claimed      : 0x2::table::new<0x1::ascii::String, 0x2::table::Table<u64, bool>>(arg0),
            sequence_num : 0,
            version      : 1,
        };
        0x2::transfer::share_object<Bridge>(v0);
        let v1 = BridgeCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<BridgeCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_treasury_exist<T0>(arg0: &Bridge) : bool {
        check_version(arg0);
        0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::treasury::is_treasury_exist<T0>(&arg0.treasury)
    }

    public entry fun migrate(arg0: &mut BridgeCap, arg1: &mut Bridge) {
        assert!(arg1.version < 1, 2);
        arg1.version = 1;
    }

    public fun modify_pair_enable(arg0: &mut BridgeCap, arg1: &mut Bridge, arg2: u64, arg3: bool) {
        check_version(arg1);
        0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::config::modify_pair_enable(&mut arg1.config, arg2, arg3);
    }

    public fun modify_pair_fee(arg0: &mut BridgeCap, arg1: &mut Bridge, arg2: u64, arg3: u64, arg4: u8) {
        check_version(arg1);
        0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::config::modify_pair_fee(&mut arg1.config, arg2, arg3, arg4);
    }

    public fun modify_pair_limit(arg0: &mut BridgeCap, arg1: &mut Bridge, arg2: u64, arg3: u64, arg4: u64) {
        check_version(arg1);
        0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::config::modify_pair_limit(&mut arg1.config, arg2, arg3, arg4);
    }

    public entry fun op_bridge_signers(arg0: &mut BridgeCap, arg1: &mut Bridge, arg2: address, arg3: bool) {
        check_version(arg1);
        0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::sign::op_signers(&mut arg1.sign, arg2, arg3);
    }

    public entry fun op_bridge_white_black(arg0: &mut BridgeCap, arg1: &mut Bridge, arg2: vector<address>, arg3: u8) {
        check_version(arg1);
        0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::config::op_white_black(&mut arg1.config, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

