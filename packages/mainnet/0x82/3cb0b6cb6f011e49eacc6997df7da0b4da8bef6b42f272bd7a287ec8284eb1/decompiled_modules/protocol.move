module 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol {
    struct ProtocolConfig has key {
        id: 0x2::object::UID,
        version: u64,
        is_paused: bool,
        manager_cap_id: 0x2::object::ID,
        deleveraging_cap_id: 0x2::object::ID,
        funding_rate_cap_id: 0x2::object::ID,
        settlement_cap_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
        maker_gas_fee: u128,
        taker_gas_fee: u128,
        privileged_addresses: 0x2::vec_set::VecSet<address>,
    }

    struct PerpetualRegistry has store {
        perpetuals: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct GasConfig has store {
        relayer: address,
        gas_table: 0x2::vec_map::VecMap<0x1::string::String, u128>,
    }

    struct SettlementOperatorAddresses has store {
        addresses: 0x2::vec_set::VecSet<address>,
    }

    struct PackageAuthWhitelist has store {
        witnesses: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    public(friend) fun add_package_auth(arg0: &mut ProtocolConfig, arg1: 0x1::type_name::TypeName) {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"package_auth_whitelist")) {
            let v0 = PackageAuthWhitelist{witnesses: 0x2::vec_set::empty<0x1::type_name::TypeName>()};
            0x2::dynamic_field::add<vector<u8>, PackageAuthWhitelist>(&mut arg0.id, b"package_auth_whitelist", v0);
        };
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, PackageAuthWhitelist>(&mut arg0.id, b"package_auth_whitelist");
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&v1.witnesses, &arg1), 2110);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v1.witnesses, arg1);
    }

    public(friend) fun add_settlement_operator_address(arg0: &mut ProtocolConfig, arg1: address) {
        init_settlement_operator_addresses(arg0);
        0x2::vec_set::insert<address>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, SettlementOperatorAddresses>(&mut arg0.id, b"settlement_operator_addresses").addresses, arg1);
    }

    public(friend) fun borrow_perpetual_ids(arg0: &ProtocolConfig) : &0x2::vec_set::VecSet<0x2::object::ID> {
        &0x2::dynamic_field::borrow<vector<u8>, PerpetualRegistry>(&arg0.id, b"perpetual_registry").perpetuals
    }

    public fun check_basic(arg0: &ProtocolConfig) {
        check_version(arg0);
        assert!(!arg0.is_paused, 100002);
    }

    public(friend) fun check_version(arg0: &ProtocolConfig) {
        assert!(arg0.version == 7, 3000);
    }

    public(friend) fun clear_settlement_cap_ids(arg0: &mut ProtocolConfig) {
        arg0.settlement_cap_ids = 0x2::vec_set::empty<0x2::object::ID>();
    }

    public(friend) fun configured_action_gas_fee(arg0: &ProtocolConfig, arg1: 0x1::string::String) : u128 {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"gas_config")) {
            return 0
        };
        let v0 = 0x2::dynamic_field::borrow<vector<u8>, GasConfig>(&arg0.id, b"gas_config");
        if (!0x2::vec_map::contains<0x1::string::String, u128>(&v0.gas_table, &arg1)) {
            return 0
        };
        *0x2::vec_map::get<0x1::string::String, u128>(&v0.gas_table, &arg1)
    }

    public(friend) fun deleveraging_cap_id(arg0: &ProtocolConfig) : 0x2::object::ID {
        arg0.deleveraging_cap_id
    }

    public(friend) fun funding_rate_cap_id(arg0: &ProtocolConfig) : 0x2::object::ID {
        arg0.funding_rate_cap_id
    }

    public(friend) fun gas_relayer(arg0: &ProtocolConfig) : address {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"gas_config")) {
            return @0x0
        };
        0x2::dynamic_field::borrow<vector<u8>, GasConfig>(&arg0.id, b"gas_config").relayer
    }

    public fun get_action_gas_fee(arg0: &ProtocolConfig, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) : u128 {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"gas_config")) {
            return 0
        };
        let v0 = 0x2::dynamic_field::borrow<vector<u8>, GasConfig>(&arg0.id, b"gas_config");
        if (0x2::tx_context::sender(arg2) != v0.relayer || !0x2::vec_map::contains<0x1::string::String, u128>(&v0.gas_table, &arg1)) {
            return 0
        };
        *0x2::vec_map::get<0x1::string::String, u128>(&v0.gas_table, &arg1)
    }

    public(friend) fun init_gas_config(arg0: &mut ProtocolConfig) {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"gas_config")) {
            let v0 = GasConfig{
                relayer   : @0x0,
                gas_table : 0x2::vec_map::empty<0x1::string::String, u128>(),
            };
            0x2::dynamic_field::add<vector<u8>, GasConfig>(&mut arg0.id, b"gas_config", v0);
        };
    }

    public(friend) fun init_settlement_operator_addresses(arg0: &mut ProtocolConfig) {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"settlement_operator_addresses")) {
            let v0 = SettlementOperatorAddresses{addresses: 0x2::vec_set::empty<address>()};
            0x2::dynamic_field::add<vector<u8>, SettlementOperatorAddresses>(&mut arg0.id, b"settlement_operator_addresses", v0);
        };
    }

    public(friend) fun insurance_operator_cap_id(arg0: &ProtocolConfig) : 0x2::object::ID {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"insurance_operator")) {
            abort 119
        };
        *0x2::dynamic_field::borrow<vector<u8>, 0x2::object::ID>(&arg0.id, b"insurance_operator")
    }

    public(friend) fun is_package_auth_granted(arg0: &ProtocolConfig, arg1: &0x1::type_name::TypeName) : bool {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"package_auth_whitelist")) {
            return false
        };
        0x2::vec_set::contains<0x1::type_name::TypeName>(&0x2::dynamic_field::borrow<vector<u8>, PackageAuthWhitelist>(&arg0.id, b"package_auth_whitelist").witnesses, arg1)
    }

    public(friend) fun is_paused(arg0: &ProtocolConfig) : bool {
        arg0.is_paused
    }

    public(friend) fun maker_gas_fee(arg0: &ProtocolConfig) : u128 {
        arg0.maker_gas_fee
    }

    public(friend) fun manager_cap_id(arg0: &ProtocolConfig) : 0x2::object::ID {
        arg0.manager_cap_id
    }

    public(friend) fun privileged_addresses(arg0: &ProtocolConfig) : &0x2::vec_set::VecSet<address> {
        &arg0.privileged_addresses
    }

    public(friend) fun privileged_addresses_mut(arg0: &mut ProtocolConfig) : &mut 0x2::vec_set::VecSet<address> {
        &mut arg0.privileged_addresses
    }

    public(friend) fun register_perpetual(arg0: &mut ProtocolConfig, arg1: 0x2::object::ID) {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"perpetual_registry")) {
            let v0 = PerpetualRegistry{perpetuals: 0x2::vec_set::empty<0x2::object::ID>()};
            0x2::dynamic_field::add<vector<u8>, PerpetualRegistry>(&mut arg0.id, b"perpetual_registry", v0);
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, PerpetualRegistry>(&mut arg0.id, b"perpetual_registry").perpetuals, arg1);
    }

    public(friend) fun remove_package_auth(arg0: &mut ProtocolConfig, arg1: &0x1::type_name::TypeName) {
        assert!(is_package_auth_granted(arg0, arg1), 2109);
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, PackageAuthWhitelist>(&mut arg0.id, b"package_auth_whitelist").witnesses, arg1);
    }

    public(friend) fun remove_settlement_operator_address(arg0: &mut ProtocolConfig, arg1: address) {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"settlement_operator_addresses")) {
            abort 112
        };
        0x2::vec_set::remove<address>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, SettlementOperatorAddresses>(&mut arg0.id, b"settlement_operator_addresses").addresses, &arg1);
    }

    public(friend) fun set_action_gas_fee(arg0: &mut ProtocolConfig, arg1: 0x1::string::String, arg2: u128) {
        init_gas_config(arg0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, GasConfig>(&mut arg0.id, b"gas_config");
        if (0x2::vec_map::contains<0x1::string::String, u128>(&v0.gas_table, &arg1)) {
            *0x2::vec_map::get_mut<0x1::string::String, u128>(&mut v0.gas_table, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<0x1::string::String, u128>(&mut v0.gas_table, arg1, arg2);
        };
    }

    public(friend) fun set_deleveraging_cap_id(arg0: &mut ProtocolConfig, arg1: 0x2::object::ID) {
        arg0.deleveraging_cap_id = arg1;
    }

    public(friend) fun set_funding_rate_cap_id(arg0: &mut ProtocolConfig, arg1: 0x2::object::ID) {
        arg0.funding_rate_cap_id = arg1;
    }

    public(friend) fun set_gas_relayer(arg0: &mut ProtocolConfig, arg1: address) {
        init_gas_config(arg0);
        0x2::dynamic_field::borrow_mut<vector<u8>, GasConfig>(&mut arg0.id, b"gas_config").relayer = arg1;
    }

    public(friend) fun set_insurance_operator_cap_id(arg0: &mut ProtocolConfig, arg1: 0x2::object::ID) {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"insurance_operator")) {
            0x2::dynamic_field::add<vector<u8>, 0x2::object::ID>(&mut arg0.id, b"insurance_operator", arg1);
        } else {
            *0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::object::ID>(&mut arg0.id, b"insurance_operator") = arg1;
        };
    }

    public(friend) fun set_is_paused(arg0: &mut ProtocolConfig, arg1: bool) {
        arg0.is_paused = arg1;
    }

    public(friend) fun set_maker_gas_fee(arg0: &mut ProtocolConfig, arg1: u128) {
        arg0.maker_gas_fee = arg1;
    }

    public(friend) fun set_manager_cap_id(arg0: &mut ProtocolConfig, arg1: 0x2::object::ID) {
        arg0.manager_cap_id = arg1;
    }

    public(friend) fun set_taker_gas_fee(arg0: &mut ProtocolConfig, arg1: u128) {
        arg0.taker_gas_fee = arg1;
    }

    public(friend) fun set_trial_fund_operator(arg0: &mut ProtocolConfig, arg1: address) {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"trial_fund_operator")) {
            0x2::dynamic_field::add<vector<u8>, address>(&mut arg0.id, b"trial_fund_operator", arg1);
        } else {
            *0x2::dynamic_field::borrow_mut<vector<u8>, address>(&mut arg0.id, b"trial_fund_operator") = arg1;
        };
    }

    public(friend) fun settlement_operator_address_exists(arg0: &ProtocolConfig, arg1: address) : bool {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"settlement_operator_addresses")) {
            return false
        };
        0x2::vec_set::contains<address>(&0x2::dynamic_field::borrow<vector<u8>, SettlementOperatorAddresses>(&arg0.id, b"settlement_operator_addresses").addresses, &arg1)
    }

    public(friend) fun taker_gas_fee(arg0: &ProtocolConfig) : u128 {
        arg0.taker_gas_fee
    }

    public(friend) fun trial_fund_operator(arg0: &ProtocolConfig) : address {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"trial_fund_operator")) {
            return @0x0
        };
        *0x2::dynamic_field::borrow<vector<u8>, address>(&arg0.id, b"trial_fund_operator")
    }

    public(friend) fun upgrade(arg0: &mut ProtocolConfig) {
        assert!(arg0.version + 1 == 7, 3000);
        arg0.version = 7;
    }

    // decompiled from Move bytecode v7
}

