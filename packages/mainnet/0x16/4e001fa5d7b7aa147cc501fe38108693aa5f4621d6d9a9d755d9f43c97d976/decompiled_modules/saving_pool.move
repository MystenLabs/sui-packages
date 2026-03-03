module 0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::saving_pool {
    struct SavingPool has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<0x1::string::String, SavingPoolObjectInfo>,
    }

    struct SavingPoolObjectInfo has drop, store {
        pool: 0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::share::SharedObjectRef,
        reward: 0x1::option::Option<RewardConfig>,
    }

    struct RewardConfig has drop, store {
        reward_manager: 0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::share::SharedObjectRef,
        reward_types: vector<0x1::string::String>,
    }

    public fun modify_saving_pool_obj(arg0: &mut SavingPool, arg1: &0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::admin::AdminCap, arg2: 0x1::string::String, arg3: SavingPoolObjectInfo) {
        if (0x2::table::contains<0x1::string::String, SavingPoolObjectInfo>(&arg0.table, arg2)) {
            0x2::table::remove<0x1::string::String, SavingPoolObjectInfo>(&mut arg0.table, arg2);
        };
        0x2::table::add<0x1::string::String, SavingPoolObjectInfo>(&mut arg0.table, arg2, arg3);
    }

    public fun new_reward_config(arg0: &0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::admin::AdminCap, arg1: 0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::share::SharedObjectRef, arg2: vector<0x1::string::String>) : RewardConfig {
        RewardConfig{
            reward_manager : arg1,
            reward_types   : arg2,
        }
    }

    public fun new_saving_pool(arg0: &0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SavingPool{
            id    : 0x2::object::new(arg1),
            table : 0x2::table::new<0x1::string::String, SavingPoolObjectInfo>(arg1),
        };
        0x2::transfer::share_object<SavingPool>(v0);
    }

    public fun new_saving_pool_object_info(arg0: &0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::admin::AdminCap, arg1: 0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::share::SharedObjectRef, arg2: 0x1::option::Option<RewardConfig>) : SavingPoolObjectInfo {
        SavingPoolObjectInfo{
            pool   : arg1,
            reward : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

