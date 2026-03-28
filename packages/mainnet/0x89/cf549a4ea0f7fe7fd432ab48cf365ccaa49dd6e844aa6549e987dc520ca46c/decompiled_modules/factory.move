module 0x89cf549a4ea0f7fe7fd432ab48cf365ccaa49dd6e844aa6549e987dc520ca46c::factory {
    struct FACTORY has drop {
        dummy_field: bool,
    }

    struct LaunchpadAccountReceipt<phantom T0> {
        account_id: 0x2::object::ID,
        pre_minted_tokens: 0x2::coin::Coin<T0>,
    }

    struct Factory has store, key {
        id: 0x2::object::UID,
        dao_count: u64,
        paused: bool,
        owner_cap_id: 0x2::object::ID,
        allowed_stable_types: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        launchpad_bid_fee: u64,
    }

    struct FactoryOwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct DAOCreated has copy, drop {
        account_id: address,
        dao_name: 0x1::ascii::String,
        asset_type: 0x1::string::String,
        stable_type: 0x1::string::String,
        asset_decimals: u8,
        stable_decimals: u8,
        asset_currency_id: 0x2::object::ID,
        stable_currency_id: 0x2::object::ID,
        creator: address,
        affiliate_id: 0x1::string::String,
        timestamp: u64,
    }

    struct StableCoinTypeAdded has copy, drop {
        type_str: 0x1::string::String,
        admin: address,
        timestamp: u64,
    }

    struct StableCoinTypeRemoved has copy, drop {
        type_str: 0x1::string::String,
        admin: address,
        timestamp: u64,
    }

    struct LaunchpadFeesUpdated has copy, drop {
        admin: address,
        old_bid_fee: u64,
        new_bid_fee: u64,
        timestamp: u64,
    }

    public entry fun add_allowed_stable_type<T0>(arg0: &mut Factory, arg1: &FactoryOwnerCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<FactoryOwnerCap>(arg1) == arg0.owner_cap_id, 15);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_stable_types, &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.allowed_stable_types, v0);
            let v1 = StableCoinTypeAdded{
                type_str  : get_type_string<T0>(),
                admin     : 0x2::tx_context::sender(arg3),
                timestamp : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<StableCoinTypeAdded>(v1);
        };
    }

    public fun add_outcome_coins_to_proposal<T0, T1, T2, T3>(arg0: &mut 0x247a26578dca33ebe83d531627f7cf670e93ba4c874b395613d1929a5a5c2731::proposal::Proposal<T0, T1>, arg1: &mut 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::TokenEscrow<T0, T1>, arg2: u64, arg3: 0x2::coin::TreasuryCap<T2>, arg4: &mut 0x2::coin_registry::Currency<T2>, arg5: 0x2::coin_registry::MetadataCap<T2>, arg6: 0x2::coin::TreasuryCap<T3>, arg7: &mut 0x2::coin_registry::Currency<T3>, arg8: 0x2::coin_registry::MetadataCap<T3>, arg9: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg10: &0x2::coin_registry::Currency<T0>, arg11: &0x2::coin_registry::Currency<T1>) {
        0x247a26578dca33ebe83d531627f7cf670e93ba4c874b395613d1929a5a5c2731::proposal::add_outcome_coins<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun assert_valid_owner_cap(arg0: &Factory, arg1: &FactoryOwnerCap) {
        assert!(0x2::object::id<FactoryOwnerCap>(arg1) == arg0.owner_cap_id, 15);
    }

    fun build_bootstrap_specs<T0, T1>(arg0: 0x2::object::ID, arg1: bool, arg2: bool, arg3: &vector<0x1::string::String>) : vector<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec> {
        let v0 = 0x1::type_name::with_original_ids<0x2::sui::SUI>();
        let v1 = 0x1::string::utf8(b"treasury");
        let v2 = 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::new(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::source_factory_init(), arg0, 0);
        0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::vault_init_actions::add_open_vault_spec(&mut v2, v1);
        0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::vault_init_actions::add_approve_coin_type_spec<0x2::sui::SUI>(&mut v2, v1);
        if (0x1::type_name::with_original_ids<T0>() != v0) {
            0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::vault_init_actions::add_approve_coin_type_spec<T0>(&mut v2, v1);
        };
        if (0x1::type_name::with_original_ids<T1>() != v0) {
            0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::vault_init_actions::add_approve_coin_type_spec<T1>(&mut v2, v1);
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(arg3)) {
            let v4 = *0x1::vector::borrow<0x1::string::String>(arg3, v3);
            0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::vault_init_actions::add_open_vault_spec(&mut v2, v4);
            0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::vault_init_actions::add_approve_coin_type_spec<T1>(&mut v2, v4);
            v3 = v3 + 1;
        };
        if (arg1) {
            0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::owned_init_actions::add_provide_object_spec<0x2::coin::TreasuryCap<T0>>(&mut v2, 0x1::string::utf8(b"treasury_cap"));
            0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::currency_init_actions::add_lock_treasury_cap_spec<T0>(&mut v2, 0x1::option::none<u64>(), true, true, true, true, true, b"treasury_cap");
        };
        if (arg2) {
            0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::owned_init_actions::add_provide_object_spec<0x2::coin_registry::MetadataCap<T0>>(&mut v2, 0x1::string::utf8(b"metadata_cap"));
            0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::currency_init_actions::add_lock_metadata_cap_spec<T0>(&mut v2, true, true, true, b"metadata_cap");
        };
        0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::into_vector(v2)
    }

    public entry fun burn_factory_owner_cap(arg0: &Factory, arg1: FactoryOwnerCap) {
        assert!(0x2::object::id<FactoryOwnerCap>(&arg1) == arg0.owner_cap_id, 15);
        let FactoryOwnerCap { id: v0 } = arg1;
        0x2::object::delete(v0);
    }

    public fun consume_launchpad_receipt<T0>(arg0: LaunchpadAccountReceipt<T0>) : (0x2::object::ID, 0x2::coin::Coin<T0>) {
        let LaunchpadAccountReceipt {
            account_id        : v0,
            pre_minted_tokens : v1,
        } = arg0;
        (v0, v1)
    }

    public fun create_dao<T0, T1>(arg0: &mut Factory, arg1: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry, arg2: &mut 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::fee::FeeManager, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x1::string::String, arg5: 0x1::ascii::String, arg6: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>, arg7: 0x1::option::Option<0x2::coin_registry::MetadataCap<T0>>, arg8: &0x2::coin_registry::Currency<T0>, arg9: &0x2::coin_registry::Currency<T1>, arg10: vector<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>, arg11: u8, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        create_dao_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    fun create_dao_internal<T0, T1>(arg0: &mut Factory, arg1: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry, arg2: &mut 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::fee::FeeManager, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x1::string::String, arg5: 0x1::ascii::String, arg6: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>, arg7: 0x1::option::Option<0x2::coin_registry::MetadataCap<T0>>, arg8: &0x2::coin_registry::Currency<T0>, arg9: &0x2::coin_registry::Currency<T1>, arg10: vector<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>, arg11: u8, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        let v0 = 0x1::type_name::with_original_ids<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_stable_types, &v0), 2);
        assert!(!0x2::coin_registry::is_regulated<T0>(arg8), 12);
        assert!(0x1::type_name::with_original_ids<T0>() != v0, 4);
        0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::fee::deposit_dao_creation_payment(arg2, arg3, arg12, arg13);
        assert!(0x1::string::length(&arg4) <= 0x9770f391e82370d06c368c058fd9d6fad5ab036b29b2efd823a8de2c84317e0c::constants::launchpad_max_affiliate_id_length(), 11);
        assert!(0x1::vector::length<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>(&arg10) <= 0x9770f391e82370d06c368c058fd9d6fad5ab036b29b2efd823a8de2c84317e0c::constants::factory_max_init_actions(), 13);
        let v1 = 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::new_with_package_registry(arg1, 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::new<T0, T1>(default_dao_config(), 0x1::option::none<u128>()), arg11, 0x89cf549a4ea0f7fe7fd432ab48cf365ccaa49dd6e844aa6549e987dc520ca46c::factory_version::current(), arg13);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = build_bootstrap_specs<T0, T1>(0x2::object::id<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account>(&v1), 0x1::option::is_some<0x2::coin::TreasuryCap<T0>>(&arg6), 0x1::option::is_some<0x2::coin_registry::MetadataCap<T0>>(&arg7), &v2);
        let v4 = &mut v1;
        execute_bootstrap<T0, T1>(v4, arg1, &v3, arg6, arg7, 0, arg12, arg13);
        0x89cf549a4ea0f7fe7fd432ab48cf365ccaa49dd6e844aa6549e987dc520ca46c::dao_init_executor::create_intents_from_specs_for_factory(&mut v1, arg1, &arg10, arg12, arg13);
        0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::mark_account_initialized(&mut v1);
        0x2::transfer::public_share_object<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account>(v1);
        arg0.dao_count = arg0.dao_count + 1;
        let v5 = DAOCreated{
            account_id         : 0x2::object::id_address<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account>(&v1),
            dao_name           : arg5,
            asset_type         : get_type_string<T0>(),
            stable_type        : get_type_string<T1>(),
            asset_decimals     : 0x2::coin_registry::decimals<T0>(arg8),
            stable_decimals    : 0x2::coin_registry::decimals<T1>(arg9),
            asset_currency_id  : 0x2::object::id<0x2::coin_registry::Currency<T0>>(arg8),
            stable_currency_id : 0x2::object::id<0x2::coin_registry::Currency<T1>>(arg9),
            creator            : 0x2::tx_context::sender(arg13),
            affiliate_id       : arg4,
            timestamp          : 0x2::clock::timestamp_ms(arg12),
        };
        0x2::event::emit<DAOCreated>(v5);
    }

    public fun dao_count(arg0: &Factory) : u64 {
        arg0.dao_count
    }

    fun default_dao_config() : 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::dao_config::DaoConfig {
        0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::dao_config::new_dao_config(0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::dao_config::default_trading_params(), 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::dao_config::default_twap_config(), 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::dao_config::default_governance_config(), 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::dao_config::new_metadata_config(0x1::ascii::string(b"DAO"), 0x2::url::new_unsafe_from_bytes(b""), 0x1::string::utf8(b"")), 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::dao_config::default_conditional_coin_config(), 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::dao_config::default_sponsorship_config())
    }

    fun execute_bootstrap<T0, T1>(arg0: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg1: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry, arg2: &vector<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>, arg3: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>, arg4: 0x1::option::Option<0x2::coin_registry::MetadataCap<T0>>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_original_ids<0x2::sui::SUI>();
        let v1 = 0x89cf549a4ea0f7fe7fd432ab48cf365ccaa49dd6e844aa6549e987dc520ca46c::dao_init_executor::dao_init_intent_witness();
        0x89cf549a4ea0f7fe7fd432ab48cf365ccaa49dd6e844aa6549e987dc520ca46c::dao_init_executor::create_bootstrap_intent(arg0, arg1, arg2, arg6, arg7);
        let v2 = 0x89cf549a4ea0f7fe7fd432ab48cf365ccaa49dd6e844aa6549e987dc520ca46c::dao_init_executor::begin_bootstrap_execution(arg0, arg1, arg6, arg7);
        0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::vault::do_init_open<0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::FutarchyConfig, 0x89cf549a4ea0f7fe7fd432ab48cf365ccaa49dd6e844aa6549e987dc520ca46c::dao_init_outcome::DaoInitOutcome, 0x89cf549a4ea0f7fe7fd432ab48cf365ccaa49dd6e844aa6549e987dc520ca46c::dao_init_executor::DaoInitIntent>(&mut v2, arg0, arg1, v1, arg7);
        0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::vault::do_approve_coin_type<0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::FutarchyConfig, 0x89cf549a4ea0f7fe7fd432ab48cf365ccaa49dd6e844aa6549e987dc520ca46c::dao_init_outcome::DaoInitOutcome, 0x2::sui::SUI, 0x89cf549a4ea0f7fe7fd432ab48cf365ccaa49dd6e844aa6549e987dc520ca46c::dao_init_executor::DaoInitIntent>(&mut v2, arg0, arg1, v1);
        if (0x1::type_name::with_original_ids<T0>() != v0) {
            0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::vault::do_approve_coin_type<0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::FutarchyConfig, 0x89cf549a4ea0f7fe7fd432ab48cf365ccaa49dd6e844aa6549e987dc520ca46c::dao_init_outcome::DaoInitOutcome, T0, 0x89cf549a4ea0f7fe7fd432ab48cf365ccaa49dd6e844aa6549e987dc520ca46c::dao_init_executor::DaoInitIntent>(&mut v2, arg0, arg1, v1);
        };
        if (0x1::type_name::with_original_ids<T1>() != v0) {
            0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::vault::do_approve_coin_type<0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::FutarchyConfig, 0x89cf549a4ea0f7fe7fd432ab48cf365ccaa49dd6e844aa6549e987dc520ca46c::dao_init_outcome::DaoInitOutcome, T1, 0x89cf549a4ea0f7fe7fd432ab48cf365ccaa49dd6e844aa6549e987dc520ca46c::dao_init_executor::DaoInitIntent>(&mut v2, arg0, arg1, v1);
        };
        let v3 = 0;
        while (v3 < arg5) {
            0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::vault::do_init_open<0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::FutarchyConfig, 0x89cf549a4ea0f7fe7fd432ab48cf365ccaa49dd6e844aa6549e987dc520ca46c::dao_init_outcome::DaoInitOutcome, 0x89cf549a4ea0f7fe7fd432ab48cf365ccaa49dd6e844aa6549e987dc520ca46c::dao_init_executor::DaoInitIntent>(&mut v2, arg0, arg1, v1, arg7);
            0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::vault::do_approve_coin_type<0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::FutarchyConfig, 0x89cf549a4ea0f7fe7fd432ab48cf365ccaa49dd6e844aa6549e987dc520ca46c::dao_init_outcome::DaoInitOutcome, T1, 0x89cf549a4ea0f7fe7fd432ab48cf365ccaa49dd6e844aa6549e987dc520ca46c::dao_init_executor::DaoInitIntent>(&mut v2, arg0, arg1, v1);
            v3 = v3 + 1;
        };
        if (0x1::option::is_some<0x2::coin::TreasuryCap<T0>>(&arg3)) {
            0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::owned::do_provide_object<0x89cf549a4ea0f7fe7fd432ab48cf365ccaa49dd6e844aa6549e987dc520ca46c::dao_init_outcome::DaoInitOutcome, 0x2::coin::TreasuryCap<T0>, 0x89cf549a4ea0f7fe7fd432ab48cf365ccaa49dd6e844aa6549e987dc520ca46c::dao_init_executor::DaoInitIntent>(&mut v2, arg0, arg1, v1, 0x1::option::destroy_some<0x2::coin::TreasuryCap<T0>>(arg3), arg7);
            0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::currency::do_init_lock_treasury_cap<0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::FutarchyConfig, 0x89cf549a4ea0f7fe7fd432ab48cf365ccaa49dd6e844aa6549e987dc520ca46c::dao_init_outcome::DaoInitOutcome, T0, 0x89cf549a4ea0f7fe7fd432ab48cf365ccaa49dd6e844aa6549e987dc520ca46c::dao_init_executor::DaoInitIntent>(&mut v2, arg0, arg1, v1);
        } else {
            0x1::option::destroy_none<0x2::coin::TreasuryCap<T0>>(arg3);
        };
        if (0x1::option::is_some<0x2::coin_registry::MetadataCap<T0>>(&arg4)) {
            0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::owned::do_provide_object<0x89cf549a4ea0f7fe7fd432ab48cf365ccaa49dd6e844aa6549e987dc520ca46c::dao_init_outcome::DaoInitOutcome, 0x2::coin_registry::MetadataCap<T0>, 0x89cf549a4ea0f7fe7fd432ab48cf365ccaa49dd6e844aa6549e987dc520ca46c::dao_init_executor::DaoInitIntent>(&mut v2, arg0, arg1, v1, 0x1::option::destroy_some<0x2::coin_registry::MetadataCap<T0>>(arg4), arg7);
            0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::currency::do_init_lock_metadata_cap<0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::FutarchyConfig, 0x89cf549a4ea0f7fe7fd432ab48cf365ccaa49dd6e844aa6549e987dc520ca46c::dao_init_outcome::DaoInitOutcome, T0, 0x89cf549a4ea0f7fe7fd432ab48cf365ccaa49dd6e844aa6549e987dc520ca46c::dao_init_executor::DaoInitIntent>(&mut v2, arg0, arg1, v1);
        } else {
            0x1::option::destroy_none<0x2::coin_registry::MetadataCap<T0>>(arg4);
        };
        0x89cf549a4ea0f7fe7fd432ab48cf365ccaa49dd6e844aa6549e987dc520ca46c::dao_init_executor::confirm_bootstrap_execution(arg0, v2);
    }

    fun get_type_string<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())))
    }

    fun init(arg0: FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<FACTORY>(&arg0), 3);
        let v0 = FactoryOwnerCap{id: 0x2::object::new(arg1)};
        let v1 = Factory{
            id                   : 0x2::object::new(arg1),
            dao_count            : 0,
            paused               : false,
            owner_cap_id         : 0x2::object::id<FactoryOwnerCap>(&v0),
            allowed_stable_types : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            launchpad_bid_fee    : 0x9770f391e82370d06c368c058fd9d6fad5ab036b29b2efd823a8de2c84317e0c::constants::launchpad_bid_fee_per_contribution(),
        };
        0x2::transfer::share_object<Factory>(v1);
        0x2::transfer::transfer<FactoryOwnerCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_paused(arg0: &Factory) : bool {
        arg0.paused
    }

    public fun is_stable_type_allowed<T0>(arg0: &Factory) : bool {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_stable_types, &v0)
    }

    public fun launchpad_bid_fee(arg0: &Factory) : u64 {
        arg0.launchpad_bid_fee
    }

    public entry fun remove_allowed_stable_type<T0>(arg0: &mut Factory, arg1: &FactoryOwnerCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<FactoryOwnerCap>(arg1) == arg0.owner_cap_id, 15);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_stable_types, &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.allowed_stable_types, &v0);
            let v1 = StableCoinTypeRemoved{
                type_str  : get_type_string<T0>(),
                admin     : 0x2::tx_context::sender(arg3),
                timestamp : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<StableCoinTypeRemoved>(v1);
        };
    }

    public(friend) fun setup_dao_account_for_launchpad<T0, T1>(arg0: &mut Factory, arg1: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x1::option::Option<0x2::coin_registry::MetadataCap<T0>>, arg4: &0x2::coin_registry::Currency<T0>, arg5: &0x2::coin_registry::Currency<T1>, arg6: u64, arg7: 0x1::ascii::String, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : LaunchpadAccountReceipt<T0> {
        assert!(!0x2::coin_registry::is_regulated<T0>(arg4), 12);
        assert!(0x1::type_name::with_original_ids<T0>() != 0x1::type_name::with_original_ids<T1>(), 4);
        let v0 = 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::new_with_package_registry(arg1, 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::new<T0, T1>(default_dao_config(), 0x1::option::none<u128>()), 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::constants::auth_level_global_only(), 0x89cf549a4ea0f7fe7fd432ab48cf365ccaa49dd6e844aa6549e987dc520ca46c::factory_version::current(), arg10);
        let v1 = 0x2::coin::mint<T0>(&mut arg2, arg6, arg10);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"amm_liquidity"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"bid_wall_funds"));
        let v4 = build_bootstrap_specs<T0, T1>(0x2::object::id<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account>(&v0), true, 0x1::option::is_some<0x2::coin_registry::MetadataCap<T0>>(&arg3), &v2);
        let v5 = &mut v0;
        execute_bootstrap<T0, T1>(v5, arg1, &v4, 0x1::option::some<0x2::coin::TreasuryCap<T0>>(arg2), arg3, 0x1::vector::length<0x1::string::String>(&v2), arg9, arg10);
        0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::mark_account_initialized(&mut v0);
        arg0.dao_count = arg0.dao_count + 1;
        let v6 = DAOCreated{
            account_id         : 0x2::object::id_address<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account>(&v0),
            dao_name           : arg7,
            asset_type         : get_type_string<T0>(),
            stable_type        : get_type_string<T1>(),
            asset_decimals     : 0x2::coin_registry::decimals<T0>(arg4),
            stable_decimals    : 0x2::coin_registry::decimals<T1>(arg5),
            asset_currency_id  : 0x2::object::id<0x2::coin_registry::Currency<T0>>(arg4),
            stable_currency_id : 0x2::object::id<0x2::coin_registry::Currency<T1>>(arg5),
            creator            : arg8,
            affiliate_id       : 0x1::string::utf8(b"launchpad"),
            timestamp          : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<DAOCreated>(v6);
        0x2::transfer::public_share_object<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account>(v0);
        LaunchpadAccountReceipt<T0>{
            account_id        : 0x2::object::id<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account>(&v0),
            pre_minted_tokens : v1,
        }
    }

    public entry fun toggle_pause(arg0: &mut Factory, arg1: &FactoryOwnerCap) {
        assert!(0x2::object::id<FactoryOwnerCap>(arg1) == arg0.owner_cap_id, 15);
        arg0.paused = !arg0.paused;
    }

    public entry fun update_launchpad_fees(arg0: &mut Factory, arg1: &FactoryOwnerCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<FactoryOwnerCap>(arg1) == arg0.owner_cap_id, 15);
        arg0.launchpad_bid_fee = arg2;
        let v0 = LaunchpadFeesUpdated{
            admin       : 0x2::tx_context::sender(arg4),
            old_bid_fee : arg0.launchpad_bid_fee,
            new_bid_fee : arg2,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<LaunchpadFeesUpdated>(v0);
    }

    public fun zero_coin<T0>(arg0: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::zero<T0>(arg0)
    }

    // decompiled from Move bytecode v6
}

