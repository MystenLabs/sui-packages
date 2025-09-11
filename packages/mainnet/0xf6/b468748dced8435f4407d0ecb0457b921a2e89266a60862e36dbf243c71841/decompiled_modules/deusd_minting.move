module 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd_minting {
    struct DeUSDMintingManagement has key {
        id: 0x2::object::UID,
        package_address: address,
        domain_separator: vector<u8>,
        supported_assets: 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::set::Set<0x1::type_name::TypeName>,
        custodian_addresses: 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::set::Set<address>,
        order_bitmaps: 0x2::table::Table<address, 0x2::table::Table<u64, u256>>,
        minted_per_second: 0x2::table::Table<u64, u64>,
        redeemed_per_second: 0x2::table::Table<u64, u64>,
        max_mint_per_second: u64,
        max_redeem_per_second: u64,
        initialized: bool,
    }

    struct BalanceStoreKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Mint has copy, drop, store {
        minter: address,
        benefactor: address,
        beneficiary: address,
        collateral_asset: 0x1::ascii::String,
        collateral_amount: u64,
        deusd_amount: u64,
    }

    struct Redeem has copy, drop, store {
        redeemer: address,
        benefactor: address,
        beneficiary: address,
        collateral_asset: 0x1::ascii::String,
        collateral_amount: u64,
        deusd_amount: u64,
    }

    struct AssetAdded has copy, drop, store {
        asset: 0x1::type_name::TypeName,
    }

    struct AssetRemoved has copy, drop, store {
        asset: 0x1::type_name::TypeName,
    }

    struct CustodianAddressAdded has copy, drop, store {
        custodian: address,
    }

    struct CustodianAddressRemoved has copy, drop, store {
        custodian: address,
    }

    struct MaxMintPerSecondChanged has copy, drop, store {
        old_max: u64,
        new_max: u64,
    }

    struct MaxRedeemPerSecondChanged has copy, drop, store {
        old_max: u64,
        new_max: u64,
    }

    struct CustodyTransfer has copy, drop, store {
        wallet: address,
        asset: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Deposit has copy, drop, store {
        depositor: address,
        asset: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Withdraw has copy, drop, store {
        asset: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    public fun mint<T0>(arg0: &mut DeUSDMintingManagement, arg1: &mut 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::locked_funds::LockedFundsManagement, arg2: &mut 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DeUSDConfig, arg3: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg4: u64, arg5: u64, arg6: address, arg7: address, arg8: u64, arg9: u64, arg10: vector<address>, arg11: vector<u64>, arg12: vector<u8>, arg13: vector<u8>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert_package_version_and_initialized(arg0, arg3);
        assert_is_minter(arg3, arg15);
        verify_order<T0>(arg0, 0, arg4, arg5, arg6, arg7, arg8, arg9, arg12, arg13, arg14);
        assert!(verify_route(arg10, arg11, &arg0.custodian_addresses), 2);
        let v0 = 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::clock_utils::timestamp_seconds(arg14);
        assert!(get_minted_per_second(arg0, v0) + arg9 <= arg0.max_mint_per_second, 3);
        deduplicate_order(arg0, arg6, arg5, arg15);
        update_minted_per_second(arg0, v0, arg9);
        let v1 = 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::locked_funds::withdraw_internal<T0>(arg1, arg6, arg8, arg15);
        transfer_collateral<T0>(arg0, v1, arg10, arg11, arg15);
        0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::mint(arg2, arg7, arg9, arg15);
        let v2 = Mint{
            minter            : 0x2::tx_context::sender(arg15),
            benefactor        : arg6,
            beneficiary       : arg7,
            collateral_asset  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            collateral_amount : arg8,
            deusd_amount      : arg9,
        };
        0x2::event::emit<Mint>(v2);
    }

    public fun add_custodian_address(arg0: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::admin_cap::AdminCap, arg1: &mut DeUSDMintingManagement, arg2: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg3: address) {
        assert_package_version_and_initialized(arg1, arg2);
        add_custodian_address_internal(arg1, arg3);
    }

    fun add_custodian_address_internal(arg0: &mut DeUSDMintingManagement, arg1: address) {
        assert!(arg1 != @0x0, 15);
        assert!(!0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::set::contains<address>(&arg0.custodian_addresses, arg1), 9);
        0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::set::add<address>(&mut arg0.custodian_addresses, arg1);
        let v0 = CustodianAddressAdded{custodian: arg1};
        0x2::event::emit<CustodianAddressAdded>(v0);
    }

    public fun add_supported_asset<T0>(arg0: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::admin_cap::AdminCap, arg1: &mut DeUSDMintingManagement, arg2: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig) {
        assert_package_version_and_initialized(arg1, arg2);
        let v0 = 0x1::type_name::get<T0>();
        0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::set::add<0x1::type_name::TypeName>(&mut arg1.supported_assets, v0);
        let v1 = AssetAdded{asset: v0};
        0x2::event::emit<AssetAdded>(v1);
    }

    fun assert_is_collateral_manager(arg0: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::has_role(arg0, 0x2::tx_context::sender(arg1), 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::roles::role_collateral_manager()), 11);
    }

    fun assert_is_gatekeeper(arg0: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::has_role(arg0, 0x2::tx_context::sender(arg1), 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::roles::role_gate_keeper()), 11);
    }

    fun assert_is_minter(arg0: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::has_role(arg0, 0x2::tx_context::sender(arg1), 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::roles::role_minter()), 11);
    }

    fun assert_is_redeemer(arg0: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::has_role(arg0, 0x2::tx_context::sender(arg1), 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::roles::role_redeemer()), 11);
    }

    fun assert_package_version_and_initialized(arg0: &DeUSDMintingManagement, arg1: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig) {
        0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::check_package_version(arg1);
        assert!(arg0.initialized, 1);
    }

    fun calculate_domain_separator(arg0: address) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, b"deusd_minting");
        0x2::hash::keccak256(&v0)
    }

    fun deduplicate_order(arg0: &mut DeUSDMintingManagement, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 10);
        let v0 = arg2 >> 8;
        let v1 = 1 << ((arg2 & 255) as u8);
        if (!0x2::table::contains<address, 0x2::table::Table<u64, u256>>(&arg0.order_bitmaps, arg1)) {
            0x2::table::add<address, 0x2::table::Table<u64, u256>>(&mut arg0.order_bitmaps, arg1, 0x2::table::new<u64, u256>(arg3));
        };
        let v2 = 0x2::table::borrow_mut<address, 0x2::table::Table<u64, u256>>(&mut arg0.order_bitmaps, arg1);
        if (!0x2::table::contains<u64, u256>(v2, v0)) {
            0x2::table::add<u64, u256>(v2, v0, 0);
        };
        let v3 = 0x2::table::borrow_mut<u64, u256>(v2, v0);
        assert!(*v3 & v1 == 0, 10);
        *v3 = *v3 | v1;
    }

    public fun deposit<T0>(arg0: &mut DeUSDMintingManagement, arg1: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        assert_package_version_and_initialized(arg0, arg1);
        assert!(0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::set::contains<0x1::type_name::TypeName>(&arg0.supported_assets, 0x1::type_name::get<T0>()), 8);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 6);
        0x2::balance::join<T0>(get_or_create_balance_store_mut<T0>(arg0), 0x2::coin::into_balance<T0>(arg2));
        let v1 = Deposit{
            depositor : 0x2::tx_context::sender(arg3),
            asset     : 0x1::type_name::get<T0>(),
            amount    : v0,
        };
        0x2::event::emit<Deposit>(v1);
    }

    public fun disable_mint_redeem(arg0: &mut DeUSDMintingManagement, arg1: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg2: &0x2::tx_context::TxContext) {
        assert_package_version_and_initialized(arg0, arg1);
        assert_is_gatekeeper(arg1, arg2);
        set_max_mint_per_second_internal(arg0, 0);
        set_max_redeem_per_second_internal(arg0, 0);
    }

    public fun get_balance<T0>(arg0: &DeUSDMintingManagement) : u64 {
        let v0 = BalanceStoreKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_<BalanceStoreKey<T0>>(&arg0.id, v0)) {
            return 0
        };
        let v1 = BalanceStoreKey<T0>{dummy_field: false};
        0x2::balance::value<T0>(0x2::dynamic_field::borrow<BalanceStoreKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v1))
    }

    public fun get_domain_separator(arg0: &DeUSDMintingManagement) : vector<u8> {
        arg0.domain_separator
    }

    public fun get_max_mint_per_second(arg0: &DeUSDMintingManagement) : u64 {
        arg0.max_mint_per_second
    }

    public fun get_max_redeem_per_second(arg0: &DeUSDMintingManagement) : u64 {
        arg0.max_redeem_per_second
    }

    public fun get_minted_per_second(arg0: &DeUSDMintingManagement, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(&arg0.minted_per_second, arg1)) {
            *0x2::table::borrow<u64, u64>(&arg0.minted_per_second, arg1)
        } else {
            0
        }
    }

    fun get_or_create_balance_store_mut<T0>(arg0: &mut DeUSDMintingManagement) : &mut 0x2::balance::Balance<T0> {
        let v0 = BalanceStoreKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_<BalanceStoreKey<T0>>(&arg0.id, v0)) {
            0x2::dynamic_field::add<BalanceStoreKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::balance::zero<T0>());
        };
        0x2::dynamic_field::borrow_mut<BalanceStoreKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0)
    }

    public fun get_redeemed_per_second(arg0: &DeUSDMintingManagement, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(&arg0.redeemed_per_second, arg1)) {
            *0x2::table::borrow<u64, u64>(&arg0.redeemed_per_second, arg1)
        } else {
            0
        }
    }

    public fun hash_order<T0>(arg0: &DeUSDMintingManagement, arg1: u8, arg2: u64, arg3: u64, arg4: address, arg5: address, arg6: u64, arg7: u64) : vector<u8> {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = arg0.domain_separator;
        0x1::vector::append<u8>(&mut v1, b"deusd_order");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u8>(&arg1));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg4));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg5));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<vector<u8>>(0x1::ascii::as_bytes(0x1::type_name::borrow_string(&v0))));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg7));
        0x2::hash::keccak256(&v1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeUSDMintingManagement{
            id                    : 0x2::object::new(arg0),
            package_address       : @0x0,
            domain_separator      : 0x1::vector::empty<u8>(),
            supported_assets      : 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::set::new<0x1::type_name::TypeName>(arg0),
            custodian_addresses   : 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::set::new<address>(arg0),
            order_bitmaps         : 0x2::table::new<address, 0x2::table::Table<u64, u256>>(arg0),
            minted_per_second     : 0x2::table::new<u64, u64>(arg0),
            redeemed_per_second   : 0x2::table::new<u64, u64>(arg0),
            max_mint_per_second   : 0,
            max_redeem_per_second : 0,
            initialized           : false,
        };
        0x2::transfer::share_object<DeUSDMintingManagement>(v0);
    }

    public fun initialize(arg0: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::admin_cap::AdminCap, arg1: &mut DeUSDMintingManagement, arg2: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg3: address, arg4: vector<address>, arg5: u64, arg6: u64) {
        0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::check_package_version(arg2);
        assert!(!arg1.initialized, 0);
        arg1.initialized = true;
        arg1.package_address = arg3;
        arg1.domain_separator = calculate_domain_separator(arg3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg4)) {
            add_custodian_address_internal(arg1, *0x1::vector::borrow<address>(&arg4, v0));
            v0 = v0 + 1;
        };
        set_max_mint_per_second_internal(arg1, arg5);
        set_max_redeem_per_second_internal(arg1, arg6);
    }

    public fun is_supported_asset<T0>(arg0: &DeUSDMintingManagement) : bool {
        0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::set::contains<0x1::type_name::TypeName>(&arg0.supported_assets, 0x1::type_name::get<T0>())
    }

    public fun redeem<T0>(arg0: &mut DeUSDMintingManagement, arg1: &mut 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::locked_funds::LockedFundsManagement, arg2: &mut 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DeUSDConfig, arg3: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg4: u64, arg5: u64, arg6: address, arg7: address, arg8: u64, arg9: u64, arg10: vector<u8>, arg11: vector<u8>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert_package_version_and_initialized(arg0, arg3);
        assert_is_redeemer(arg3, arg13);
        verify_order<T0>(arg0, 1, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v0 = 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::clock_utils::timestamp_seconds(arg12);
        assert!(get_redeemed_per_second(arg0, v0) + arg9 <= arg0.max_redeem_per_second, 4);
        deduplicate_order(arg0, arg6, arg5, arg13);
        update_redeemed_per_second(arg0, v0, arg9);
        0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::burn_from(arg2, 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::locked_funds::withdraw_internal<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>(arg1, arg6, arg9, arg13), arg6);
        transfer_to_beneficiary<T0>(arg0, arg7, arg8, arg13);
        let v1 = Redeem{
            redeemer          : 0x2::tx_context::sender(arg13),
            benefactor        : arg6,
            beneficiary       : arg7,
            collateral_asset  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            collateral_amount : arg8,
            deusd_amount      : arg9,
        };
        0x2::event::emit<Redeem>(v1);
    }

    public fun remove_collateral_manager_role(arg0: &mut DeUSDMintingManagement, arg1: &mut 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_package_version_and_initialized(arg0, arg1);
        assert_is_gatekeeper(arg1, arg3);
        0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::remove_role_internal(arg1, arg2, 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::roles::role_collateral_manager());
    }

    public fun remove_custodian_address(arg0: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::admin_cap::AdminCap, arg1: &mut DeUSDMintingManagement, arg2: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg3: address) {
        assert_package_version_and_initialized(arg1, arg2);
        0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::set::remove<address>(&mut arg1.custodian_addresses, arg3);
        let v0 = CustodianAddressRemoved{custodian: arg3};
        0x2::event::emit<CustodianAddressRemoved>(v0);
    }

    public fun remove_minter_role(arg0: &mut DeUSDMintingManagement, arg1: &mut 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_package_version_and_initialized(arg0, arg1);
        assert_is_gatekeeper(arg1, arg3);
        0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::remove_role_internal(arg1, arg2, 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::roles::role_minter());
    }

    public fun remove_redeemer_role(arg0: &mut DeUSDMintingManagement, arg1: &mut 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_package_version_and_initialized(arg0, arg1);
        assert_is_gatekeeper(arg1, arg3);
        0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::remove_role_internal(arg1, arg2, 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::roles::role_redeemer());
    }

    public fun remove_supported_asset<T0>(arg0: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::admin_cap::AdminCap, arg1: &mut DeUSDMintingManagement, arg2: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig) {
        assert_package_version_and_initialized(arg1, arg2);
        let v0 = 0x1::type_name::get<T0>();
        0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::set::remove<0x1::type_name::TypeName>(&mut arg1.supported_assets, v0);
        let v1 = AssetRemoved{asset: v0};
        0x2::event::emit<AssetRemoved>(v1);
    }

    public fun set_max_mint_per_second(arg0: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::admin_cap::AdminCap, arg1: &mut DeUSDMintingManagement, arg2: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg3: u64) {
        assert_package_version_and_initialized(arg1, arg2);
        set_max_mint_per_second_internal(arg1, arg3);
    }

    fun set_max_mint_per_second_internal(arg0: &mut DeUSDMintingManagement, arg1: u64) {
        arg0.max_mint_per_second = arg1;
        let v0 = MaxMintPerSecondChanged{
            old_max : arg0.max_mint_per_second,
            new_max : arg1,
        };
        0x2::event::emit<MaxMintPerSecondChanged>(v0);
    }

    public fun set_max_redeem_per_second(arg0: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::admin_cap::AdminCap, arg1: &mut DeUSDMintingManagement, arg2: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg3: u64) {
        assert_package_version_and_initialized(arg1, arg2);
        set_max_redeem_per_second_internal(arg1, arg3);
    }

    fun set_max_redeem_per_second_internal(arg0: &mut DeUSDMintingManagement, arg1: u64) {
        arg0.max_redeem_per_second = arg1;
        let v0 = MaxRedeemPerSecondChanged{
            old_max : arg0.max_redeem_per_second,
            new_max : arg1,
        };
        0x2::event::emit<MaxRedeemPerSecondChanged>(v0);
    }

    fun transfer_collateral<T0>(arg0: &mut DeUSDMintingManagement, arg1: 0x2::coin::Coin<T0>, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::set::contains<0x1::type_name::TypeName>(&arg0.supported_assets, 0x1::type_name::get<T0>()), 8);
        let v0 = 0;
        let v1 = 0x1::vector::length<address>(&arg2);
        while (v0 < v1 - 1) {
            transfer_collateral_to<T0>(arg0, 0x2::coin::split<T0>(&mut arg1, 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::math_u64::mul_div(0x2::coin::value<T0>(&arg1), *0x1::vector::borrow<u64>(&arg3, v0), 10000, false), arg4), *0x1::vector::borrow<address>(&arg2, v0));
            v0 = v0 + 1;
        };
        transfer_collateral_to<T0>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v1 - 1));
    }

    fun transfer_collateral_to<T0>(arg0: &mut DeUSDMintingManagement, arg1: 0x2::coin::Coin<T0>, arg2: address) {
        if (arg2 == arg0.package_address) {
            0x2::balance::join<T0>(get_or_create_balance_store_mut<T0>(arg0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg2);
        };
    }

    fun transfer_to_beneficiary<T0>(arg0: &mut DeUSDMintingManagement, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::set::contains<0x1::type_name::TypeName>(&arg0.supported_assets, 0x1::type_name::get<T0>()), 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(get_or_create_balance_store_mut<T0>(arg0), arg2), arg3), arg1);
    }

    public fun transfer_to_custody<T0>(arg0: &mut DeUSDMintingManagement, arg1: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_package_version_and_initialized(arg0, arg1);
        assert_is_collateral_manager(arg1, arg4);
        assert!(arg2 != @0x0, 5);
        assert!(0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::set::contains<address>(&arg0.custodian_addresses, arg2), 5);
        let v0 = get_or_create_balance_store_mut<T0>(arg0);
        assert!(0x2::balance::value<T0>(v0) >= arg3, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg3), arg4), arg2);
        let v1 = CustodyTransfer{
            wallet : arg2,
            asset  : 0x1::type_name::get<T0>(),
            amount : arg3,
        };
        0x2::event::emit<CustodyTransfer>(v1);
    }

    fun update_minted_per_second(arg0: &mut DeUSDMintingManagement, arg1: u64, arg2: u64) {
        if (0x2::table::contains<u64, u64>(&arg0.minted_per_second, arg1)) {
            let v0 = 0x2::table::borrow_mut<u64, u64>(&mut arg0.minted_per_second, arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::table::add<u64, u64>(&mut arg0.minted_per_second, arg1, arg2);
        };
    }

    fun update_redeemed_per_second(arg0: &mut DeUSDMintingManagement, arg1: u64, arg2: u64) {
        if (0x2::table::contains<u64, u64>(&arg0.redeemed_per_second, arg1)) {
            let v0 = 0x2::table::borrow_mut<u64, u64>(&mut arg0.redeemed_per_second, arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::table::add<u64, u64>(&mut arg0.redeemed_per_second, arg1, arg2);
        };
    }

    fun verify_order<T0>(arg0: &DeUSDMintingManagement, arg1: u8, arg2: u64, arg3: u64, arg4: address, arg5: address, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: vector<u8>, arg10: &0x2::clock::Clock) {
        assert!(arg5 != @0x0, 5);
        assert!(arg6 > 0, 6);
        assert!(arg7 > 0, 6);
        assert!(0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::clock_utils::timestamp_seconds(arg10) <= arg2, 7);
        let v0 = hash_order<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        assert!(0x2::ed25519::ed25519_verify(&arg9, &arg8, &v0), 12);
        assert!(0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::cryptography::ed25519_public_key_to_address(arg8) == arg4, 13);
    }

    public fun verify_route(arg0: vector<address>, arg1: vector<u64>, arg2: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::set::Set<address>) : bool {
        if (0x1::vector::length<address>(&arg0) != 0x1::vector::length<u64>(&arg1)) {
            return false
        };
        if (0x1::vector::length<address>(&arg0) == 0) {
            return false
        };
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0)) {
            let v2 = *0x1::vector::borrow<address>(&arg0, v1);
            let v3 = *0x1::vector::borrow<u64>(&arg1, v1);
            let v4 = if (!0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::set::contains<address>(arg2, v2)) {
                true
            } else if (v2 == @0x0) {
                true
            } else {
                v3 == 0
            };
            if (v4) {
                return false
            };
            v0 = v0 + v3;
            v1 = v1 + 1;
        };
        v0 == 10000
    }

    public fun withdraw<T0>(arg0: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::admin_cap::AdminCap, arg1: &mut DeUSDMintingManagement, arg2: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert_package_version_and_initialized(arg1, arg2);
        assert!(arg3 > 0, 6);
        assert!(arg4 != @0x0, 5);
        let v0 = get_or_create_balance_store_mut<T0>(arg1);
        assert!(0x2::balance::value<T0>(v0) >= arg3, 14);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg3), arg5), arg4);
        let v1 = Withdraw{
            asset     : 0x1::type_name::get<T0>(),
            amount    : arg3,
            recipient : arg4,
        };
        0x2::event::emit<Withdraw>(v1);
    }

    // decompiled from Move bytecode v6
}

