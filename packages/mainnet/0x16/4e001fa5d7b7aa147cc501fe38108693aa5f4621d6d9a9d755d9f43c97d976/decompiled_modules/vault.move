module 0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::vault {
    struct Vault has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<0x1::string::String, VaultObjectInfo>,
    }

    struct VaultObjectInfo has drop, store {
        vault: 0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::share::SharedObjectRef,
        rewarders: 0x1::option::Option<vector<RewarderInfo>>,
    }

    struct RewarderInfo has drop, store {
        rewarder_id: 0x1::string::String,
        reward_type: 0x1::string::String,
    }

    public fun modify_vault_obj(arg0: &mut Vault, arg1: &0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::admin::AdminCap, arg2: 0x1::string::String, arg3: VaultObjectInfo) {
        if (0x2::table::contains<0x1::string::String, VaultObjectInfo>(&arg0.table, arg2)) {
            0x2::table::remove<0x1::string::String, VaultObjectInfo>(&mut arg0.table, arg2);
        };
        0x2::table::add<0x1::string::String, VaultObjectInfo>(&mut arg0.table, arg2, arg3);
    }

    public fun new_rewarder_info(arg0: &0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::admin::AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String) : RewarderInfo {
        RewarderInfo{
            rewarder_id : arg1,
            reward_type : arg2,
        }
    }

    public fun new_vault(arg0: &0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id    : 0x2::object::new(arg1),
            table : 0x2::table::new<0x1::string::String, VaultObjectInfo>(arg1),
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    public fun new_vault_object_info(arg0: &0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::admin::AdminCap, arg1: 0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::share::SharedObjectRef, arg2: 0x1::option::Option<vector<RewarderInfo>>) : VaultObjectInfo {
        VaultObjectInfo{
            vault     : arg1,
            rewarders : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

