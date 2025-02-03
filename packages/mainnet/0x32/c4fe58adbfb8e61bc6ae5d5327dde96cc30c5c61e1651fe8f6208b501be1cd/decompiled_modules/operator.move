module 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::operator {
    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun update_asset_data<T0>(arg0: &OperatorCap, arg1: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::Version, arg2: &mut 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::Configuration, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u8, arg6: bool, arg7: bool, arg8: 0x1::string::String, arg9: u64, arg10: vector<u8>, arg11: u16) {
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::assert_current_version(arg1);
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::assert_current_version(arg1);
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::update_asset_data<T0>(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::borrow_mut<0x1::string::String, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::Asset<T0>>(arg2, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::get_type<T0>()), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun update_foreign_chain(arg0: &OperatorCap, arg1: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::Version, arg2: &mut 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::Configuration, arg3: u16, arg4: vector<u8>, arg5: vector<u8>, arg6: u64) {
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::assert_current_version(arg1);
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain::update_foreign_chain(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::borrow_mut<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain::ForeignChainKey, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain::ForeignChain>(arg2, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain::new_foreign_chain_key(arg3)), arg4, arg5, arg6);
    }

    public entry fun add_asset<T0>(arg0: &OperatorCap, arg1: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::Version, arg2: &mut 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::Configuration, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u8, arg6: bool, arg7: bool, arg8: 0x1::string::String, arg9: u64, arg10: vector<u8>, arg11: u16, arg12: &mut 0x2::tx_context::TxContext) {
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::assert_current_version(arg1);
        let v0 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::get_type<T0>();
        assert!(!0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::contain<0x1::string::String, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::Asset<T0>>(arg2, v0), 1);
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::add<0x1::string::String, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::Asset<T0>>(arg2, v0, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::new<T0>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12));
    }

    public entry fun add_foreign_chain(arg0: &OperatorCap, arg1: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::Version, arg2: &mut 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::Configuration, arg3: u16, arg4: vector<u8>, arg5: vector<u8>, arg6: u64) {
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::assert_current_version(arg1);
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::add<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain::ForeignChainKey, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain::ForeignChain>(arg2, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain::new_foreign_chain_key(arg3), 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain::new_foreign_chain(arg4, arg5, arg6));
    }

    public entry fun delete_asset<T0>(arg0: &OperatorCap, arg1: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::Version, arg2: &mut 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::Configuration) {
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::assert_current_version(arg1);
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::delete<T0>(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::remove<0x1::string::String, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::Asset<T0>>(arg2, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::get_type<T0>()));
    }

    public entry fun delete_asset_tier<T0>(arg0: &OperatorCap, arg1: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::Version, arg2: &mut 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::State, arg3: 0x1::string::String) {
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::assert_current_version(arg1);
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset_tier::delete<T0>(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::remove<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset_tier::AssetTierKey<T0>, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset_tier::AssetTier<T0>>(arg2, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset_tier::new_asset_tier_key<T0>(arg3)));
    }

    public entry fun delete_foreign_chain(arg0: &OperatorCap, arg1: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::Version, arg2: &mut 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::Configuration, arg3: u16) {
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::assert_current_version(arg1);
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::remove<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain::ForeignChainKey, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain::ForeignChain>(arg2, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain::new_foreign_chain_key(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OperatorCap>(v0, @0x93aa0e1a1caf47ec9092a2bf4faa145bf79282923be206c9b4cb235b47cde837);
    }

    public entry fun init_asset_tier<T0>(arg0: &OperatorCap, arg1: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::Version, arg2: &mut 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::State, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::assert_current_version(arg1);
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::add<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset_tier::AssetTierKey<T0>, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset_tier::AssetTier<T0>>(arg2, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset_tier::new_asset_tier_key<T0>(arg3), 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset_tier::new<T0>(arg3, arg4, arg5, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::get_type<T0>(), arg6));
    }

    public entry fun init_system<T0>(arg0: &OperatorCap, arg1: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::Version, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: address, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::assert_current_version(arg1);
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::new(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::new(arg10);
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::custodian::new<T0>(arg10);
    }

    public entry fun init_wormhole_emitter(arg0: &OperatorCap, arg1: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::Version, arg2: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: &mut 0x2::tx_context::TxContext) {
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::assert_current_version(arg1);
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::wormhole::new(arg2, arg3);
    }

    public(friend) fun new_operator(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<OperatorCap>(v0, arg0);
    }

    entry fun set_operator(arg0: &OperatorCap, arg1: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::Version, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::assert_current_version(arg1);
        new_operator(arg2, arg3);
    }

    public entry fun update_asset<T0>(arg0: &OperatorCap, arg1: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::Version, arg2: &mut 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::Configuration, arg3: 0x1::string::String, arg4: u64) {
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::assert_current_version(arg1);
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::update<T0>(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::borrow_mut<0x1::string::String, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::Asset<T0>>(arg2, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::get_type<T0>()), arg3, arg4);
    }

    public entry fun update_asset_tier<T0>(arg0: &OperatorCap, arg1: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::Version, arg2: &mut 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::State, arg3: 0x1::string::String, arg4: u64, arg5: u64) {
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::assert_current_version(arg1);
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset_tier::update<T0>(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::borrow_mut<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset_tier::AssetTierKey<T0>, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset_tier::AssetTier<T0>>(arg2, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset_tier::new_asset_tier_key<T0>(arg3)), arg4, arg5);
    }

    public entry fun update_configuration(arg0: &OperatorCap, arg1: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::Version, arg2: &mut 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::Configuration, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: address, arg9: address, arg10: u64) {
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::assert_current_version(arg1);
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::update(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    // decompiled from Move bytecode v6
}

