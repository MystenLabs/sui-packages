module 0x7ff183d8eaf836980fc5c2fb53bdc063d85a19490d532927c29be7c193be995d::object_config {
    struct ObjectConfig has key {
        id: 0x2::object::UID,
        treasury_obj: 0x7ff183d8eaf836980fc5c2fb53bdc063d85a19490d532927c29be7c193be995d::share::SharedObjectRef,
        vault_rewarder_registry: 0x7ff183d8eaf836980fc5c2fb53bdc063d85a19490d532927c29be7c193be995d::share::SharedObjectRef,
        saving_pool_incentive_global_config_obj: 0x7ff183d8eaf836980fc5c2fb53bdc063d85a19490d532927c29be7c193be995d::share::SharedObjectRef,
        flash_global_config_obj: 0x7ff183d8eaf836980fc5c2fb53bdc063d85a19490d532927c29be7c193be995d::share::SharedObjectRef,
        blacklist_obj: 0x7ff183d8eaf836980fc5c2fb53bdc063d85a19490d532927c29be7c193be995d::share::SharedObjectRef,
    }

    public fun modify_blacklist_obj(arg0: &mut ObjectConfig, arg1: &0x7ff183d8eaf836980fc5c2fb53bdc063d85a19490d532927c29be7c193be995d::admin::AdminCap, arg2: 0x7ff183d8eaf836980fc5c2fb53bdc063d85a19490d532927c29be7c193be995d::share::SharedObjectRef) {
        arg0.blacklist_obj = arg2;
    }

    public fun modify_flash_global_config_obj(arg0: &mut ObjectConfig, arg1: &0x7ff183d8eaf836980fc5c2fb53bdc063d85a19490d532927c29be7c193be995d::admin::AdminCap, arg2: 0x7ff183d8eaf836980fc5c2fb53bdc063d85a19490d532927c29be7c193be995d::share::SharedObjectRef) {
        arg0.flash_global_config_obj = arg2;
    }

    public fun modify_saving_pool_incentive_global_config_obj(arg0: &mut ObjectConfig, arg1: &0x7ff183d8eaf836980fc5c2fb53bdc063d85a19490d532927c29be7c193be995d::admin::AdminCap, arg2: 0x7ff183d8eaf836980fc5c2fb53bdc063d85a19490d532927c29be7c193be995d::share::SharedObjectRef) {
        arg0.saving_pool_incentive_global_config_obj = arg2;
    }

    public fun modify_treasury_obj(arg0: &mut ObjectConfig, arg1: &0x7ff183d8eaf836980fc5c2fb53bdc063d85a19490d532927c29be7c193be995d::admin::AdminCap, arg2: 0x7ff183d8eaf836980fc5c2fb53bdc063d85a19490d532927c29be7c193be995d::share::SharedObjectRef) {
        arg0.treasury_obj = arg2;
    }

    public fun modify_vault_rewarder_registry(arg0: &mut ObjectConfig, arg1: &0x7ff183d8eaf836980fc5c2fb53bdc063d85a19490d532927c29be7c193be995d::admin::AdminCap, arg2: 0x7ff183d8eaf836980fc5c2fb53bdc063d85a19490d532927c29be7c193be995d::share::SharedObjectRef) {
        arg0.vault_rewarder_registry = arg2;
    }

    public fun new_object_config(arg0: &0x7ff183d8eaf836980fc5c2fb53bdc063d85a19490d532927c29be7c193be995d::admin::AdminCap, arg1: 0x7ff183d8eaf836980fc5c2fb53bdc063d85a19490d532927c29be7c193be995d::share::SharedObjectRef, arg2: 0x7ff183d8eaf836980fc5c2fb53bdc063d85a19490d532927c29be7c193be995d::share::SharedObjectRef, arg3: 0x7ff183d8eaf836980fc5c2fb53bdc063d85a19490d532927c29be7c193be995d::share::SharedObjectRef, arg4: 0x7ff183d8eaf836980fc5c2fb53bdc063d85a19490d532927c29be7c193be995d::share::SharedObjectRef, arg5: 0x7ff183d8eaf836980fc5c2fb53bdc063d85a19490d532927c29be7c193be995d::share::SharedObjectRef, arg6: &mut 0x2::tx_context::TxContext) {
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

