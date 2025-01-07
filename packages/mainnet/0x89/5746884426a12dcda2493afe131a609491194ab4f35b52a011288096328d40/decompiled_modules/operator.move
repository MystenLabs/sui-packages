module 0x895746884426a12dcda2493afe131a609491194ab4f35b52a011288096328d40::operator {
    struct OperatorCap has key {
        id: 0x2::object::UID,
    }

    public entry fun create_asset_tier<T0>(arg0: &OperatorCap, arg1: &0x895746884426a12dcda2493afe131a609491194ab4f35b52a011288096328d40::version::Version, arg2: &mut 0x895746884426a12dcda2493afe131a609491194ab4f35b52a011288096328d40::state::State, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x895746884426a12dcda2493afe131a609491194ab4f35b52a011288096328d40::version::assert_current_version(arg1);
        0x895746884426a12dcda2493afe131a609491194ab4f35b52a011288096328d40::state::add<0x895746884426a12dcda2493afe131a609491194ab4f35b52a011288096328d40::asset_tier::AssetTierKey<T0>, 0x895746884426a12dcda2493afe131a609491194ab4f35b52a011288096328d40::asset_tier::AssetTier<T0>>(arg2, 0x895746884426a12dcda2493afe131a609491194ab4f35b52a011288096328d40::asset_tier::new_asset_tier_key<T0>(arg3), 0x895746884426a12dcda2493afe131a609491194ab4f35b52a011288096328d40::asset_tier::new<T0>(arg3, arg4, arg5, arg6));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OperatorCap>(v0, @0x6a1f20c51495a6dbadf04f26ea76679f9e00abad8a5fa600677ebcd4b09daaa);
    }

    public(friend) fun new_operator(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<OperatorCap>(v0, arg0);
    }

    public entry fun update_asset_tier<T0>(arg0: &OperatorCap, arg1: &0x895746884426a12dcda2493afe131a609491194ab4f35b52a011288096328d40::version::Version, arg2: &mut 0x895746884426a12dcda2493afe131a609491194ab4f35b52a011288096328d40::state::State, arg3: 0x1::string::String, arg4: u64, arg5: u64) {
        0x895746884426a12dcda2493afe131a609491194ab4f35b52a011288096328d40::version::assert_current_version(arg1);
        0x895746884426a12dcda2493afe131a609491194ab4f35b52a011288096328d40::asset_tier::update<T0>(0x895746884426a12dcda2493afe131a609491194ab4f35b52a011288096328d40::state::borrow_mut<0x895746884426a12dcda2493afe131a609491194ab4f35b52a011288096328d40::asset_tier::AssetTierKey<T0>, 0x895746884426a12dcda2493afe131a609491194ab4f35b52a011288096328d40::asset_tier::AssetTier<T0>>(arg2, 0x895746884426a12dcda2493afe131a609491194ab4f35b52a011288096328d40::asset_tier::new_asset_tier_key<T0>(arg3)), arg4, arg5);
    }

    public entry fun update_configuration(arg0: &0x895746884426a12dcda2493afe131a609491194ab4f35b52a011288096328d40::version::Version, arg1: &OperatorCap, arg2: &mut 0x895746884426a12dcda2493afe131a609491194ab4f35b52a011288096328d40::configuration::Configuration, arg3: u64, arg4: u64, arg5: u64) {
        0x895746884426a12dcda2493afe131a609491194ab4f35b52a011288096328d40::version::assert_current_version(arg0);
        0x895746884426a12dcda2493afe131a609491194ab4f35b52a011288096328d40::configuration::update(arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

