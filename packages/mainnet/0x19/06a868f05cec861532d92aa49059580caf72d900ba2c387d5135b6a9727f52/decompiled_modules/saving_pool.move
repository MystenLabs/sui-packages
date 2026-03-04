module 0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::saving_pool {
    struct SavingPool has key {
        id: 0x2::object::UID,
        table: 0x2::vec_map::VecMap<0x1::string::String, SavingPoolObjectInfo>,
    }

    struct SavingPoolObjectInfo has drop, store {
        pool: 0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::share::SharedObjectRef,
        reward: 0x1::option::Option<RewardConfig>,
    }

    struct RewardConfig has drop, store {
        reward_manager: 0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::share::SharedObjectRef,
        reward_types: vector<0x1::string::String>,
    }

    public fun modify_saving_pool_obj(arg0: &mut SavingPool, arg1: &0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::admin::AdminCap, arg2: 0x1::string::String, arg3: SavingPoolObjectInfo) {
        if (0x2::vec_map::contains<0x1::string::String, SavingPoolObjectInfo>(&arg0.table, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, SavingPoolObjectInfo>(&mut arg0.table, &arg2);
        };
        0x2::vec_map::insert<0x1::string::String, SavingPoolObjectInfo>(&mut arg0.table, arg2, arg3);
    }

    public fun new_reward_config(arg0: &0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::admin::AdminCap, arg1: 0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::share::SharedObjectRef, arg2: vector<0x1::string::String>) : RewardConfig {
        RewardConfig{
            reward_manager : arg1,
            reward_types   : arg2,
        }
    }

    public fun new_saving_pool(arg0: &0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SavingPool{
            id    : 0x2::object::new(arg1),
            table : 0x2::vec_map::empty<0x1::string::String, SavingPoolObjectInfo>(),
        };
        0x2::transfer::share_object<SavingPool>(v0);
    }

    public fun new_saving_pool_object_info(arg0: &0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::admin::AdminCap, arg1: 0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::share::SharedObjectRef, arg2: 0x1::option::Option<RewardConfig>) : SavingPoolObjectInfo {
        SavingPoolObjectInfo{
            pool   : arg1,
            reward : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

