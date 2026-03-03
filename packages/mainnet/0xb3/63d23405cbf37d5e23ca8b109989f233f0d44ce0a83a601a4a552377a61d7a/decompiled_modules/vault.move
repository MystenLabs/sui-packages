module 0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::vault {
    struct Vault has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<0x1::string::String, VaultObjectInfo>,
    }

    struct VaultObjectInfo has drop, store {
        vault: 0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::share::SharedObjectRef,
        rewarders: 0x1::option::Option<vector<RewarderInfo>>,
    }

    struct RewarderInfo has drop, store {
        rewarder_id: 0x1::string::String,
        reward_type: 0x1::string::String,
    }

    public fun modify_vault_obj(arg0: &mut Vault, arg1: &0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::admin::AdminCap, arg2: 0x1::string::String, arg3: VaultObjectInfo) {
        if (0x2::table::contains<0x1::string::String, VaultObjectInfo>(&arg0.table, arg2)) {
            0x2::table::remove<0x1::string::String, VaultObjectInfo>(&mut arg0.table, arg2);
        };
        0x2::table::add<0x1::string::String, VaultObjectInfo>(&mut arg0.table, arg2, arg3);
    }

    public fun new_rewarder_info(arg0: &0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::admin::AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String) : RewarderInfo {
        RewarderInfo{
            rewarder_id : arg1,
            reward_type : arg2,
        }
    }

    public fun new_vault(arg0: &0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id    : 0x2::object::new(arg1),
            table : 0x2::table::new<0x1::string::String, VaultObjectInfo>(arg1),
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    public fun new_vault_object_info(arg0: &0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::admin::AdminCap, arg1: 0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::share::SharedObjectRef, arg2: 0x1::option::Option<vector<RewarderInfo>>) : VaultObjectInfo {
        VaultObjectInfo{
            vault     : arg1,
            rewarders : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

