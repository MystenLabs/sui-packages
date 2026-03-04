module 0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::object_config {
    struct ObjectConfig has key {
        id: 0x2::object::UID,
        treasury_obj: 0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::share::SharedObjectRef,
        vault_rewarder_registry: 0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::share::SharedObjectRef,
        saving_pool_incentive_global_config_obj: 0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::share::SharedObjectRef,
        flash_global_config_obj: 0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::share::SharedObjectRef,
        blacklist_obj: 0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::share::SharedObjectRef,
    }

    public fun modify_blacklist_obj(arg0: &mut ObjectConfig, arg1: &0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::admin::AdminCap, arg2: 0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::share::SharedObjectRef) {
        arg0.blacklist_obj = arg2;
    }

    public fun modify_flash_global_config_obj(arg0: &mut ObjectConfig, arg1: &0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::admin::AdminCap, arg2: 0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::share::SharedObjectRef) {
        arg0.flash_global_config_obj = arg2;
    }

    public fun modify_saving_pool_incentive_global_config_obj(arg0: &mut ObjectConfig, arg1: &0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::admin::AdminCap, arg2: 0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::share::SharedObjectRef) {
        arg0.saving_pool_incentive_global_config_obj = arg2;
    }

    public fun modify_treasury_obj(arg0: &mut ObjectConfig, arg1: &0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::admin::AdminCap, arg2: 0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::share::SharedObjectRef) {
        arg0.treasury_obj = arg2;
    }

    public fun modify_vault_rewarder_registry(arg0: &mut ObjectConfig, arg1: &0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::admin::AdminCap, arg2: 0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::share::SharedObjectRef) {
        arg0.vault_rewarder_registry = arg2;
    }

    public fun new_object_config(arg0: &0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::admin::AdminCap, arg1: 0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::share::SharedObjectRef, arg2: 0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::share::SharedObjectRef, arg3: 0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::share::SharedObjectRef, arg4: 0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::share::SharedObjectRef, arg5: 0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::share::SharedObjectRef, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = ObjectConfig{
            id                                      : 0x2::object::new(arg6),
            treasury_obj                            : arg1,
            vault_rewarder_registry                 : arg2,
            saving_pool_incentive_global_config_obj : arg3,
            flash_global_config_obj                 : arg4,
            blacklist_obj                           : arg5,
        };
        0x2::transfer::share_object<ObjectConfig>(v0);
    }

    // decompiled from Move bytecode v6
}

