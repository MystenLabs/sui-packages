module 0xa5e7af50df270daf0917be0c6919bcbeb322b6cb43b04aae5a1e9d4113024502::asset_active_state {
    struct BaseAssetActiveStates has drop {
        dummy_field: bool,
    }

    struct CollateralActiveStates has drop {
        dummy_field: bool,
    }

    struct AssetActiveStates has store {
        base: 0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::wit_table::WitTable<BaseAssetActiveStates, 0x1::type_name::TypeName, bool>,
        collateral: 0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::wit_table::WitTable<CollateralActiveStates, 0x1::type_name::TypeName, bool>,
    }

    public(friend) fun is_base_asset_active(arg0: &AssetActiveStates, arg1: 0x1::type_name::TypeName) : bool {
        0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::wit_table::contains<BaseAssetActiveStates, 0x1::type_name::TypeName, bool>(&arg0.base, arg1) && *0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::wit_table::borrow<BaseAssetActiveStates, 0x1::type_name::TypeName, bool>(&arg0.base, arg1)
    }

    public(friend) fun is_collateral_active(arg0: &AssetActiveStates, arg1: 0x1::type_name::TypeName) : bool {
        0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::wit_table::contains<CollateralActiveStates, 0x1::type_name::TypeName, bool>(&arg0.collateral, arg1) && *0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::wit_table::borrow<CollateralActiveStates, 0x1::type_name::TypeName, bool>(&arg0.collateral, arg1)
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : AssetActiveStates {
        let v0 = BaseAssetActiveStates{dummy_field: false};
        let v1 = CollateralActiveStates{dummy_field: false};
        AssetActiveStates{
            base       : 0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::wit_table::new<BaseAssetActiveStates, 0x1::type_name::TypeName, bool>(v0, true, arg0),
            collateral : 0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::wit_table::new<CollateralActiveStates, 0x1::type_name::TypeName, bool>(v1, true, arg0),
        }
    }

    public(friend) fun set_base_asset_active_state(arg0: &mut AssetActiveStates, arg1: 0x1::type_name::TypeName, arg2: bool) {
        if (0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::wit_table::contains<BaseAssetActiveStates, 0x1::type_name::TypeName, bool>(&arg0.base, arg1)) {
            let v0 = BaseAssetActiveStates{dummy_field: false};
            0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::wit_table::remove<BaseAssetActiveStates, 0x1::type_name::TypeName, bool>(v0, &mut arg0.base, arg1);
        };
        let v1 = BaseAssetActiveStates{dummy_field: false};
        0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::wit_table::add<BaseAssetActiveStates, 0x1::type_name::TypeName, bool>(v1, &mut arg0.base, arg1, arg2);
    }

    public(friend) fun set_collateral_active_state(arg0: &mut AssetActiveStates, arg1: 0x1::type_name::TypeName, arg2: bool) {
        if (0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::wit_table::contains<CollateralActiveStates, 0x1::type_name::TypeName, bool>(&arg0.collateral, arg1)) {
            let v0 = CollateralActiveStates{dummy_field: false};
            0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::wit_table::remove<CollateralActiveStates, 0x1::type_name::TypeName, bool>(v0, &mut arg0.collateral, arg1);
        };
        let v1 = CollateralActiveStates{dummy_field: false};
        0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::wit_table::add<CollateralActiveStates, 0x1::type_name::TypeName, bool>(v1, &mut arg0.collateral, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

