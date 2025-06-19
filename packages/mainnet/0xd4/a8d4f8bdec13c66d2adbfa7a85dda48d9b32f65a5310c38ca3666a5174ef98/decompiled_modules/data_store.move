module 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::data_store {
    struct EDSPerpetual has store {
        perpetual: 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::Perpetual,
        synced: bool,
    }

    struct OrderFill has drop, store {
        quantity: u64,
        timestamp: u64,
    }

    struct InternalDataStore has key {
        id: 0x2::object::UID,
        version: u64,
        sequence_hash: vector<u8>,
        accounts: 0x2::table::Table<address, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::account::Account>,
        perpetuals: 0x2::table::Table<0x1::string::String, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::Perpetual>,
        hashes: 0x2::table::Table<vector<u8>, u64>,
        filled_orders: 0x2::table::Table<vector<u8>, OrderFill>,
        supported_assets: 0x2::table::Table<0x1::string::String, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::bank::Asset>,
        operators: 0x2::table::Table<0x1::string::String, address>,
        liquidators: vector<address>,
        gas_fee: u64,
        gas_pool: address,
        sequence_number: u128,
    }

    struct ExternalDataStore has key {
        id: 0x2::object::UID,
        version: u64,
        internal_data_store: 0x2::object::ID,
        perpetuals: 0x2::table::Table<0x1::string::String, EDSPerpetual>,
        operators: 0x2::table::Table<0x1::string::String, address>,
        asset_bank: 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::bank::AssetBank,
        sequence_number: u128,
    }

    public(friend) fun apply_funding_rate(arg0: &mut InternalDataStore, arg1: 0x1::option::Option<0x1::string::String>, arg2: vector<address>, arg3: u128) {
        let v0 = &arg0.perpetuals;
        while (0x1::vector::length<address>(&arg2) > 0) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            assert!(0x2::table::contains<address, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::account::Account>(&arg0.accounts, v1), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::account_does_not_exist());
            let v2 = 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::account::apply_funding_rate(0x2::table::borrow_mut<address, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::account::Account>(&mut arg0.accounts, v1), v0, arg1);
            while (0x1::vector::length<0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::account::FundingApplied>(&v2) > 0) {
                let v3 = 0x1::vector::pop_back<0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::account::FundingApplied>(&mut v2);
                let (v4, v5, v6, v7) = 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::account::dec_funding_applied(&v3);
                0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::events::emit_funding_rate_applied_event(v1, v4, v5, v6, v7, arg3);
            };
        };
    }

    entry fun support_asset<T0>(arg0: &0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::admin::AdminCap, arg1: &mut ExternalDataStore, arg2: 0x1::string::String, arg3: u8, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u64) {
        assert!(arg1.version == 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::constants::get_version(), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::version_mismatch());
        let v0 = 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::bank::support_asset<T0>(&mut arg1.asset_bank, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v1 = eds_increment_sequence_number(arg1);
        0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::events::emit_asset_supported_event(*0x2::object::uid_as_inner(&arg1.id), v0, v1);
    }

    public(friend) fun authorize_liquidator(arg0: &mut InternalDataStore, arg1: address, arg2: bool) {
        if (arg2) {
            let (v0, _) = 0x1::vector::index_of<address>(&arg0.liquidators, &arg1);
            if (v0 == false) {
                0x1::vector::push_back<address>(&mut arg0.liquidators, arg1);
            };
        } else {
            let (v2, v3) = 0x1::vector::index_of<address>(&arg0.liquidators, &arg1);
            if (v2) {
                0x1::vector::remove<address>(&mut arg0.liquidators, v3);
            };
        };
    }

    public(friend) fun check_if_perp_exists(arg0: &0x2::table::Table<0x1::string::String, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::Perpetual>, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::Perpetual>(arg0, arg1)
    }

    public(friend) fun check_if_perp_exists_in_ids(arg0: &InternalDataStore, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::Perpetual>(&arg0.perpetuals, arg1)
    }

    public(friend) fun compute_and_update_sequence_hash(arg0: &mut InternalDataStore, arg1: vector<u8>, arg2: vector<u8>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg1)) {
            0x1::vector::push_back<u8>(&mut arg0.sequence_hash, *0x1::vector::borrow<u8>(&arg1, v0));
            v0 = v0 + 1;
        };
        arg0.sequence_hash = 0x2::hash::blake2b256(&arg0.sequence_hash);
        assert!(arg0.sequence_hash == arg2, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::invalid_sequence_hash());
    }

    entry fun create_internal_data_store(arg0: &0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::admin::AdminCap, arg1: &mut ExternalDataStore, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::constants::get_version(), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::version_mismatch());
        eds_increment_sequence_number(arg1);
        arg1.internal_data_store = internal_data_store_creator(arg2, arg1.sequence_number, arg3);
    }

    entry fun create_perpetual(arg0: &0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::admin::AdminCap, arg1: &mut ExternalDataStore, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: vector<u64>, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: address, arg20: address, arg21: bool, arg22: vector<u8>, arg23: vector<u8>, arg24: u64, arg25: u64, arg26: u64, arg27: u64, arg28: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::constants::get_version(), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::version_mismatch());
        assert!(!0x2::table::contains<0x1::string::String, EDSPerpetual>(&arg1.perpetuals, arg2), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::perpetual_already_exists());
        let v0 = 0x2::object::new(arg28);
        0x2::object::delete(v0);
        let v1 = 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::create_perpetual(0x2::object::uid_to_address(&v0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, 0x1::string::utf8(arg22), 0x1::string::utf8(arg23), arg24, arg25, arg26, arg27);
        let v2 = EDSPerpetual{
            perpetual : v1,
            synced    : false,
        };
        0x2::table::add<0x1::string::String, EDSPerpetual>(&mut arg1.perpetuals, arg2, v2);
        let v3 = eds_increment_sequence_number(arg1);
        0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::events::emit_perpetual_update_event(0x2::object::uid_to_inner(&arg1.id), v1, v3);
    }

    public(friend) fun create_user_account(arg0: &mut InternalDataStore, arg1: address) {
        if (!0x2::table::contains<address, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::account::Account>(&arg0.accounts, arg1)) {
            0x2::table::add<address, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::account::Account>(&mut arg0.accounts, arg1, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::account::initialize(arg1));
        };
    }

    public(friend) fun eds_increment_sequence_number(arg0: &mut ExternalDataStore) : u128 {
        arg0.sequence_number = arg0.sequence_number + 1;
        arg0.sequence_number
    }

    fun external_data_store_creator(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ExternalDataStore{
            id                  : 0x2::object::new(arg1),
            version             : 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::constants::get_version(),
            internal_data_store : arg0,
            perpetuals          : 0x2::table::new<0x1::string::String, EDSPerpetual>(arg1),
            operators           : 0x2::table::new<0x1::string::String, address>(arg1),
            asset_bank          : 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::bank::create_asset_bank(arg1),
            sequence_number     : 0,
        };
        0x2::transfer::share_object<ExternalDataStore>(v0);
    }

    public(friend) fun filled_order_quantity(arg0: &InternalDataStore, arg1: vector<u8>) : u64 {
        filled_order_quantity_from_table(&arg0.filled_orders, arg1)
    }

    public(friend) fun filled_order_quantity_from_table(arg0: &0x2::table::Table<vector<u8>, OrderFill>, arg1: vector<u8>) : u64 {
        if (0x2::table::contains<vector<u8>, OrderFill>(arg0, arg1)) {
            0x2::table::borrow<vector<u8>, OrderFill>(arg0, arg1).quantity
        } else {
            0
        }
    }

    public(friend) fun get_asset_bank(arg0: &mut ExternalDataStore) : &mut 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::bank::AssetBank {
        &mut arg0.asset_bank
    }

    public(friend) fun get_current_ids_id(arg0: &ExternalDataStore) : 0x2::object::ID {
        arg0.internal_data_store
    }

    public(friend) fun get_eds_address(arg0: &ExternalDataStore) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public(friend) fun get_eds_id(arg0: &ExternalDataStore) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun get_eds_version(arg0: &ExternalDataStore) : u64 {
        arg0.version
    }

    public fun get_gas_fee_amount(arg0: &InternalDataStore) : u64 {
        arg0.gas_fee
    }

    public fun get_gas_pool(arg0: &InternalDataStore) : address {
        arg0.gas_pool
    }

    public(friend) fun get_ids_address(arg0: &InternalDataStore) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public(friend) fun get_ids_id(arg0: &InternalDataStore) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun get_ids_version(arg0: &InternalDataStore) : u64 {
        arg0.version
    }

    public(friend) fun get_immutable_account_from_accounts_table(arg0: &0x2::table::Table<address, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::account::Account>, arg1: address) : &0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::account::Account {
        assert!(0x2::table::contains<address, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::account::Account>(arg0, arg1), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::account_does_not_exist());
        0x2::table::borrow<address, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::account::Account>(arg0, arg1)
    }

    public(friend) fun get_immutable_account_from_ids(arg0: &InternalDataStore, arg1: address) : &0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::account::Account {
        get_immutable_account_from_accounts_table(&arg0.accounts, arg1)
    }

    public(friend) fun get_immutable_assets_table_from_ids(arg0: &InternalDataStore) : &0x2::table::Table<0x1::string::String, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::bank::Asset> {
        &arg0.supported_assets
    }

    public(friend) fun get_immutable_perpetual_from_ids(arg0: &InternalDataStore, arg1: 0x1::string::String) : &0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::Perpetual {
        assert!(0x2::table::contains<0x1::string::String, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::Perpetual>(&arg0.perpetuals, arg1), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::perpetual_does_not_exists());
        0x2::table::borrow<0x1::string::String, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::Perpetual>(&arg0.perpetuals, arg1)
    }

    public(friend) fun get_immutable_perpetual_from_table(arg0: &0x2::table::Table<0x1::string::String, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::Perpetual>, arg1: 0x1::string::String) : &0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::Perpetual {
        assert!(0x2::table::contains<0x1::string::String, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::Perpetual>(arg0, arg1), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::perpetual_does_not_exists());
        0x2::table::borrow<0x1::string::String, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::Perpetual>(arg0, arg1)
    }

    public(friend) fun get_immutable_perpetual_table_from_ids(arg0: &InternalDataStore) : &0x2::table::Table<0x1::string::String, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::Perpetual> {
        &arg0.perpetuals
    }

    public(friend) fun get_mutable_account_from_accounts_table(arg0: &mut 0x2::table::Table<address, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::account::Account>, arg1: address) : &mut 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::account::Account {
        assert!(0x2::table::contains<address, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::account::Account>(arg0, arg1), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::account_does_not_exist());
        0x2::table::borrow_mut<address, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::account::Account>(arg0, arg1)
    }

    public(friend) fun get_mutable_account_from_ids(arg0: &mut InternalDataStore, arg1: address) : &mut 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::account::Account {
        let v0 = &mut arg0.accounts;
        get_mutable_account_from_accounts_table(v0, arg1)
    }

    public(friend) fun get_mutable_accounts_table_from_ids(arg0: &mut InternalDataStore) : &mut 0x2::table::Table<address, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::account::Account> {
        &mut arg0.accounts
    }

    public(friend) fun get_mutable_order_fills_table_from_ids(arg0: &mut InternalDataStore) : &mut 0x2::table::Table<vector<u8>, OrderFill> {
        &mut arg0.filled_orders
    }

    public(friend) fun get_operator_address(arg0: &InternalDataStore, arg1: vector<u8>) : address {
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x2::table::contains<0x1::string::String, address>(&arg0.operators, v0), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::invalid_operator_type());
        *0x2::table::borrow<0x1::string::String, address>(&arg0.operators, v0)
    }

    public(friend) fun get_perpetual_from_eds(arg0: &mut ExternalDataStore, arg1: 0x1::string::String) : &mut EDSPerpetual {
        assert!(0x2::table::contains<0x1::string::String, EDSPerpetual>(&arg0.perpetuals, arg1), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::perpetual_does_not_exists());
        0x2::table::borrow_mut<0x1::string::String, EDSPerpetual>(&mut arg0.perpetuals, arg1)
    }

    public(friend) fun get_perpetual_from_ids(arg0: &mut InternalDataStore, arg1: 0x1::string::String) : &mut 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::Perpetual {
        assert!(0x2::table::contains<0x1::string::String, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::Perpetual>(&arg0.perpetuals, arg1), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::perpetual_does_not_exists());
        0x2::table::borrow_mut<0x1::string::String, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::Perpetual>(&mut arg0.perpetuals, arg1)
    }

    public(friend) fun get_tables_from_ids(arg0: &mut InternalDataStore) : (&mut 0x2::table::Table<vector<u8>, OrderFill>, &mut 0x2::table::Table<address, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::account::Account>, &0x2::table::Table<0x1::string::String, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::Perpetual>, &0x2::table::Table<0x1::string::String, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::bank::Asset>, address, address, u64) {
        (&mut arg0.filled_orders, &mut arg0.accounts, &arg0.perpetuals, &arg0.supported_assets, arg0.gas_pool, 0x2::object::uid_to_address(&arg0.id), arg0.gas_fee)
    }

    public(friend) fun ids_increment_sequence_number(arg0: &mut InternalDataStore) : u128 {
        arg0.sequence_number = arg0.sequence_number + 1;
        arg0.sequence_number
    }

    entry fun increment_external_data_store_version(arg0: &0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::admin::AdminCap, arg1: &mut ExternalDataStore) {
        arg1.version = arg1.version + 1;
        assert!(arg1.version <= 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::constants::get_version(), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::latest_supported_contract_version());
    }

    entry fun increment_internal_data_store_version(arg0: &mut InternalDataStore) {
        arg0.version = arg0.version + 1;
        assert!(arg0.version <= 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::constants::get_version(), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::latest_supported_contract_version());
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = internal_data_store_creator(v0, 0, arg0);
        external_data_store_creator(v1, arg0);
    }

    fun internal_data_store_creator(arg0: address, arg1: u128, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg0 != @0x0, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::can_not_be_zero_address());
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = InternalDataStore{
            id               : v0,
            version          : 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::constants::get_version(),
            sequence_hash    : 0x2::address::to_bytes(@0x0),
            accounts         : 0x2::table::new<address, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::account::Account>(arg2),
            perpetuals       : 0x2::table::new<0x1::string::String, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::Perpetual>(arg2),
            hashes           : 0x2::table::new<vector<u8>, u64>(arg2),
            filled_orders    : 0x2::table::new<vector<u8>, OrderFill>(arg2),
            supported_assets : 0x2::table::new<0x1::string::String, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::bank::Asset>(arg2),
            operators        : 0x2::table::new<0x1::string::String, address>(arg2),
            liquidators      : 0x1::vector::empty<address>(),
            gas_fee          : 30000000,
            gas_pool         : arg0,
            sequence_number  : 0,
        };
        let v3 = &mut v2;
        create_user_account(v3, arg0);
        0x2::transfer::transfer<InternalDataStore>(v2, arg0);
        0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::events::emit_internal_exchange_created_event(v1, arg0, arg1);
        v1
    }

    public(friend) fun is_first_fill(arg0: &InternalDataStore, arg1: vector<u8>) : bool {
        !0x2::table::contains<vector<u8>, OrderFill>(&arg0.filled_orders, arg1)
    }

    public(friend) fun is_first_fill_in_table(arg0: &0x2::table::Table<vector<u8>, OrderFill>, arg1: vector<u8>) : bool {
        !0x2::table::contains<vector<u8>, OrderFill>(arg0, arg1)
    }

    public(friend) fun is_whitelisted_liquidator(arg0: &InternalDataStore, arg1: address) : bool {
        let (v0, _) = 0x1::vector::index_of<address>(&arg0.liquidators, &arg1);
        v0
    }

    fun prune_history_table(arg0: &mut InternalDataStore, arg1: vector<vector<u8>>, arg2: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg1)) {
            let v1 = 0x1::vector::pop_back<vector<u8>>(&mut arg1);
            assert!(0x2::table::contains<vector<u8>, u64>(&arg0.hashes, v1), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::trying_to_prune_non_existent_entry());
            if (*0x2::table::borrow<vector<u8>, u64>(&arg0.hashes, v1) < arg2) {
                0x2::table::remove<vector<u8>, u64>(&mut arg0.hashes, v1);
            };
            v0 = v0 + 1;
        };
    }

    fun prune_order_fills_table(arg0: &mut InternalDataStore, arg1: vector<vector<u8>>, arg2: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg1)) {
            let v1 = 0x1::vector::pop_back<vector<u8>>(&mut arg1);
            assert!(0x2::table::contains<vector<u8>, OrderFill>(&arg0.filled_orders, v1), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::trying_to_prune_non_existent_entry());
            if (0x2::table::borrow<vector<u8>, OrderFill>(&arg0.filled_orders, v1).timestamp < arg2) {
                0x2::table::remove<vector<u8>, OrderFill>(&mut arg0.filled_orders, v1);
            };
            v0 = v0 + 1;
        };
    }

    public(friend) fun prune_table(arg0: &mut InternalDataStore, arg1: vector<vector<u8>>, arg2: u8, arg3: u64) {
        if (arg2 == 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::constants::history_table()) {
            prune_history_table(arg0, arg1, arg3 - 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::constants::lifespan());
        } else {
            assert!(arg2 == 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::constants::fills_table(), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::invalid_table_type());
            prune_order_fills_table(arg0, arg1, arg3 - 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::constants::lifespan());
        };
    }

    public(friend) fun set_gas_fee(arg0: &mut InternalDataStore, arg1: u64) {
        arg0.gas_fee = arg1;
    }

    public(friend) fun set_gas_pool(arg0: &mut InternalDataStore, arg1: address) {
        arg0.gas_pool = arg1;
        create_user_account(arg0, arg1);
    }

    entry fun set_operator(arg0: &0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::admin::AdminCap, arg1: &mut ExternalDataStore, arg2: vector<u8>, arg3: address) {
        assert!(arg1.version == 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::constants::get_version(), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::version_mismatch());
        assert!(arg3 != @0x0, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::can_not_be_zero_address());
        let v0 = 0x1::string::utf8(arg2);
        let v1 = 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::constants::get_supported_operators();
        let v2 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(0x1::vector::contains<0x1::string::String>(&v1, &v0), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::invalid_operator_type());
        let v3 = &mut arg1.operators;
        let v4 = update_operator_entry(v3, v0, arg3);
        assert!(v4 != arg3, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::operator_already_set());
        0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::events::emit_eds_operator_update(v2, v0, v4, arg3, eds_increment_sequence_number(arg1));
    }

    entry fun sync_operator(arg0: &mut InternalDataStore, arg1: &mut ExternalDataStore, arg2: vector<u8>, arg3: vector<u8>) {
        assert!(arg0.version == 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::constants::get_version(), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::version_mismatch());
        assert!(arg1.version == 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::constants::get_version(), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::version_mismatch());
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.internal_data_store, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::invalid_internal_data_store());
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = 0x1::string::utf8(arg2);
        let v2 = 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::constants::get_supported_operators();
        assert!(0x1::vector::contains<0x1::string::String>(&v2, &v1), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::invalid_operator_type());
        assert!(0x2::table::contains<0x1::string::String, address>(&arg1.operators, v1), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::nothing_to_sync());
        let v3 = *0x2::table::borrow<0x1::string::String, address>(&arg1.operators, v1);
        let v4 = &mut arg0.operators;
        let v5 = update_operator_entry(v4, v1, v3);
        assert!(v3 != v5, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::already_synced());
        0x2::table::remove<0x1::string::String, address>(&mut arg1.operators, v1);
        compute_and_update_sequence_hash(arg0, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::bcs_handler::enc_operator_update(v1, v5, v3), arg3);
        0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::events::emit_operator_synced_event(v0, v1, v5, v3, ids_increment_sequence_number(arg0));
    }

    entry fun sync_perpetual(arg0: &mut InternalDataStore, arg1: &mut ExternalDataStore, arg2: 0x1::string::String, arg3: vector<u8>) {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        assert!(arg0.version == 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::constants::get_version(), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::version_mismatch());
        assert!(arg1.version == 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::constants::get_version(), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::version_mismatch());
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.internal_data_store, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::invalid_internal_data_store());
        assert!(0x2::table::contains<0x1::string::String, EDSPerpetual>(&arg1.perpetuals, arg2), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::nothing_to_sync());
        let v1 = ids_increment_sequence_number(arg0);
        let v2 = get_perpetual_from_eds(arg1, arg2);
        if (!0x2::table::contains<0x1::string::String, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::Perpetual>(&arg0.perpetuals, arg2)) {
            0x2::table::add<0x1::string::String, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::Perpetual>(&mut arg0.perpetuals, arg2, v2.perpetual);
        };
        let v3 = get_perpetual_from_ids(arg0, arg2);
        assert!(!v2.synced, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::already_synced());
        v2.synced = true;
        create_user_account(arg0, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::get_fee_pool_address(&v2.perpetual));
        create_user_account(arg0, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::get_insurance_pool_address(&v2.perpetual));
        compute_and_update_sequence_hash(arg0, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::replicate_perp_data(v3, &v2.perpetual), arg3);
        0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::events::emit_perpetual_synced_event(v0, *v3, v1);
    }

    entry fun sync_supported_asset(arg0: &mut InternalDataStore, arg1: &mut ExternalDataStore, arg2: 0x1::string::String, arg3: vector<u8>) {
        assert!(arg0.version == 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::constants::get_version(), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::version_mismatch());
        assert!(arg1.version == 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::constants::get_version(), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::version_mismatch());
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.internal_data_store, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::invalid_internal_data_store());
        assert!(0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::bank::is_asset_supported(&arg1.asset_bank, arg2), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::asset_not_supported());
        assert!(!0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::bank::is_asset_synced(&arg1.asset_bank, arg2), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::already_synced());
        let v0 = 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::bank::get_supported_asset(&arg1.asset_bank, arg2);
        0x2::table::add<0x1::string::String, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::bank::Asset>(&mut arg0.supported_assets, arg2, v0);
        0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::bank::set_asset_status_as_synced(&mut arg1.asset_bank, arg2);
        let v1 = ids_increment_sequence_number(arg0);
        compute_and_update_sequence_hash(arg0, 0x2::bcs::to_bytes<0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::bank::Asset>(&v0), arg3);
        0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::events::emit_asset_synced_event(*0x2::object::uid_as_inner(&arg1.id), *0x2::object::uid_as_inner(&arg0.id), arg2, v1);
    }

    entry fun transfer_ids(arg0: InternalDataStore, arg1: address) {
        0x2::transfer::transfer<InternalDataStore>(arg0, arg1);
    }

    fun update_operator_entry(arg0: &mut 0x2::table::Table<0x1::string::String, address>, arg1: 0x1::string::String, arg2: address) : address {
        if (!0x2::table::contains<0x1::string::String, address>(arg0, arg1)) {
            0x2::table::add<0x1::string::String, address>(arg0, arg1, @0x0);
        };
        let v0 = 0x2::table::borrow_mut<0x1::string::String, address>(arg0, arg1);
        *v0 = arg2;
        *v0
    }

    public(friend) fun update_oracle_prices(arg0: &mut InternalDataStore, arg1: vector<0x1::string::String>, arg2: vector<u64>) {
        assert!(arg0.version == 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::constants::get_version(), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::version_mismatch());
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            let v1 = get_perpetual_from_ids(arg0, *0x1::vector::borrow<0x1::string::String>(&arg1, v0));
            0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::update_oracle_price(v1, *0x1::vector::borrow<u64>(&arg2, v0));
            v0 = v0 + 1;
        };
        0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::events::emit_oracle_price_update_event(arg1, arg2, arg0.sequence_number);
    }

    public(friend) fun update_order_fill(arg0: &mut InternalDataStore, arg1: vector<u8>, arg2: u64, arg3: u64) {
        let v0 = &mut arg0.filled_orders;
        update_order_fill_internal(v0, arg1, arg2, arg3);
    }

    public(friend) fun update_order_fill_internal(arg0: &mut 0x2::table::Table<vector<u8>, OrderFill>, arg1: vector<u8>, arg2: u64, arg3: u64) {
        if (!0x2::table::contains<vector<u8>, OrderFill>(arg0, arg1)) {
            let v0 = OrderFill{
                quantity  : 0,
                timestamp : arg3,
            };
            0x2::table::add<vector<u8>, OrderFill>(arg0, arg1, v0);
        };
        let v1 = 0x2::table::borrow_mut<vector<u8>, OrderFill>(arg0, arg1);
        v1.quantity = v1.quantity + arg2;
    }

    entry fun update_perpetual(arg0: &0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::admin::AdminCap, arg1: &mut ExternalDataStore, arg2: 0x1::string::String, arg3: vector<u8>, arg4: vector<u8>) {
        assert!(arg1.version == 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::constants::get_version(), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::version_mismatch());
        let v0 = eds_increment_sequence_number(arg1);
        let v1 = 0x2::object::uid_to_inner(&arg1.id);
        let v2 = get_perpetual_from_eds(arg1, arg2);
        assert!(v2.synced, 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::sync_already_pending());
        let v3 = 0x2::bcs::new(arg4);
        if (arg3 == b"tick_size") {
            0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::set_tick_size(&mut v2.perpetual, 0x2::bcs::peel_u64(&mut v3));
        } else if (arg3 == b"step_size" || arg3 == b"min_trade_quantity") {
            0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::set_step_size_and_min_trade_qty(&mut v2.perpetual, 0x2::bcs::peel_u64(&mut v3));
        } else if (arg3 == b"max_trade_quantity") {
            0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::set_max_trade_qty(&mut v2.perpetual, 0x2::bcs::peel_u64(&mut v3));
        } else if (arg3 == b"initial_margin_required") {
            0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::set_imr(&mut v2.perpetual, 0x2::bcs::peel_u64(&mut v3));
        } else if (arg3 == b"maintenance_margin_required") {
            0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::set_mmr(&mut v2.perpetual, 0x2::bcs::peel_u64(&mut v3));
        } else if (arg3 == b"min_trade_price") {
            0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::set_min_trade_price(&mut v2.perpetual, 0x2::bcs::peel_u64(&mut v3));
        } else if (arg3 == b"max_trade_price") {
            0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::set_max_trade_price(&mut v2.perpetual, 0x2::bcs::peel_u64(&mut v3));
        } else if (arg3 == b"mtb_long") {
            0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::set_mtb(&mut v2.perpetual, 0x2::bcs::peel_u64(&mut v3), true);
        } else if (arg3 == b"mtb_short") {
            0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::set_mtb(&mut v2.perpetual, 0x2::bcs::peel_u64(&mut v3), false);
        } else if (arg3 == b"maker_fee") {
            0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::set_fee(&mut v2.perpetual, 0x2::bcs::peel_u64(&mut v3), true);
        } else if (arg3 == b"taker_fee") {
            0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::set_fee(&mut v2.perpetual, 0x2::bcs::peel_u64(&mut v3), false);
        } else if (arg3 == b"max_funding_rate") {
            0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::set_max_funding_rate(&mut v2.perpetual, 0x2::bcs::peel_u64(&mut v3));
        } else if (arg3 == b"insurance_pool_address") {
            0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::set_insurance_pool_address(&mut v2.perpetual, 0x2::bcs::peel_address(&mut v3));
        } else if (arg3 == b"fee_pool_address") {
            0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::set_fee_pool_address(&mut v2.perpetual, 0x2::bcs::peel_address(&mut v3));
        } else if (arg3 == b"insurance_pool_ratio") {
            0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::set_insurance_pool_liquidation_premium_percentage(&mut v2.perpetual, 0x2::bcs::peel_u64(&mut v3));
        } else if (arg3 == b"isolated_only") {
            0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::set_isolated_only(&mut v2.perpetual, 0x2::bcs::peel_bool(&mut v3));
        } else if (arg3 == b"trading_status") {
            0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::set_trading_status(&mut v2.perpetual, 0x2::bcs::peel_bool(&mut v3));
        } else if (arg3 == b"delist") {
            0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::delist(&mut v2.perpetual, 0x2::bcs::peel_u64(&mut v3));
        } else {
            assert!(arg3 == b"max_allowed_oi_open", 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::invalid_perpetual_config());
            0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::perpetual::set_max_allowed_oi_open(&mut v2.perpetual, 0x2::bcs::peel_vec_u64(&mut v3));
        };
        v2.synced = false;
        0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::events::emit_perpetual_update_event(v1, v2.perpetual, v0);
    }

    public(friend) fun validate_tx_replay(arg0: &mut InternalDataStore, arg1: vector<u8>, arg2: u64) : vector<u8> {
        let v0 = 0x2::hash::blake2b256(&arg1);
        assert!(!0x2::table::contains<vector<u8>, u64>(&arg0.hashes, v0), 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::errors::transaction_replay());
        0x2::table::add<vector<u8>, u64>(&mut arg0.hashes, v0, arg2);
        v0
    }

    // decompiled from Move bytecode v6
}

