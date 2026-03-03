module 0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::object_config {
    struct ObjectConfig has key {
        id: 0x2::object::UID,
        treasury_obj: 0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::share::SharedObjectRef,
        vault_rewarder_registry: 0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::share::SharedObjectRef,
        saving_pool_incentive_global_config_obj: 0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::share::SharedObjectRef,
        flash_global_config_obj: 0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::share::SharedObjectRef,
        blacklist_obj: 0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::share::SharedObjectRef,
    }

    public fun modify_blacklist_obj(arg0: &mut ObjectConfig, arg1: &0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::admin::AdminCap, arg2: 0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::share::SharedObjectRef) {
        arg0.blacklist_obj = arg2;
    }

    public fun modify_flash_global_config_obj(arg0: &mut ObjectConfig, arg1: &0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::admin::AdminCap, arg2: 0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::share::SharedObjectRef) {
        arg0.flash_global_config_obj = arg2;
    }

    public fun modify_saving_pool_incentive_global_config_obj(arg0: &mut ObjectConfig, arg1: &0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::admin::AdminCap, arg2: 0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::share::SharedObjectRef) {
        arg0.saving_pool_incentive_global_config_obj = arg2;
    }

    public fun modify_treasury_obj(arg0: &mut ObjectConfig, arg1: &0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::admin::AdminCap, arg2: 0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::share::SharedObjectRef) {
        arg0.treasury_obj = arg2;
    }

    public fun modify_vault_rewarder_registry(arg0: &mut ObjectConfig, arg1: &0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::admin::AdminCap, arg2: 0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::share::SharedObjectRef) {
        arg0.vault_rewarder_registry = arg2;
    }

    public fun new_object_config(arg0: &0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::admin::AdminCap, arg1: 0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::share::SharedObjectRef, arg2: 0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::share::SharedObjectRef, arg3: 0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::share::SharedObjectRef, arg4: 0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::share::SharedObjectRef, arg5: 0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::share::SharedObjectRef, arg6: &mut 0x2::tx_context::TxContext) {
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

