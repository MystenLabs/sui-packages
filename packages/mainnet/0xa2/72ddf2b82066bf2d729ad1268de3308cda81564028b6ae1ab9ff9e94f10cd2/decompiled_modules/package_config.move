module 0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::package_config {
    struct PackageConfig has key {
        id: 0x2::object::UID,
        original_framework_package_id: 0x1::string::String,
        original_usdb_package_id: 0x1::string::String,
        original_oracle_package_id: 0x1::string::String,
        original_cdp_package_id: 0x1::string::String,
        original_psm_package_id: 0x1::string::String,
        original_flash_package_id: 0x1::string::String,
        original_saving_package_id: 0x1::string::String,
        original_saving_incentive_package_id: 0x1::string::String,
        original_borrow_incentive_package_id: 0x1::string::String,
        original_blacklist_package_id: 0x1::string::String,
        framework_package_id: 0x1::string::String,
        usdb_package_id: 0x1::string::String,
        oracle_package_id: 0x1::string::String,
        cdp_package_id: 0x1::string::String,
        psm_package_id: 0x1::string::String,
        flash_package_id: 0x1::string::String,
        saving_package_id: 0x1::string::String,
        saving_incentive_package_id: 0x1::string::String,
        borrow_incentive_package_id: 0x1::string::String,
        blacklist_package_id: 0x1::string::String,
    }

    public fun modify_blacklist_package_id(arg0: &mut PackageConfig, arg1: &0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::admin::AdminCap, arg2: 0x1::string::String) {
        arg0.blacklist_package_id = arg2;
    }

    public fun modify_borrow_incentive_package_id(arg0: &mut PackageConfig, arg1: &0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::admin::AdminCap, arg2: 0x1::string::String) {
        arg0.borrow_incentive_package_id = arg2;
    }

    public fun modify_cdp_package_id(arg0: &mut PackageConfig, arg1: &0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::admin::AdminCap, arg2: 0x1::string::String) {
        arg0.cdp_package_id = arg2;
    }

    public fun modify_flash_package_id(arg0: &mut PackageConfig, arg1: &0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::admin::AdminCap, arg2: 0x1::string::String) {
        arg0.flash_package_id = arg2;
    }

    public fun modify_framework_package_id(arg0: &mut PackageConfig, arg1: &0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::admin::AdminCap, arg2: 0x1::string::String) {
        arg0.framework_package_id = arg2;
    }

    public fun modify_oracle_package_id(arg0: &mut PackageConfig, arg1: &0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::admin::AdminCap, arg2: 0x1::string::String) {
        arg0.oracle_package_id = arg2;
    }

    public fun modify_original_blacklist_package_id(arg0: &mut PackageConfig, arg1: &0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::admin::AdminCap, arg2: 0x1::string::String) {
        arg0.original_blacklist_package_id = arg2;
    }

    public fun modify_original_borrow_incentive_package_id(arg0: &mut PackageConfig, arg1: &0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::admin::AdminCap, arg2: 0x1::string::String) {
        arg0.original_borrow_incentive_package_id = arg2;
    }

    public fun modify_original_cdp_package_id(arg0: &mut PackageConfig, arg1: &0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::admin::AdminCap, arg2: 0x1::string::String) {
        arg0.original_cdp_package_id = arg2;
    }

    public fun modify_original_flash_package_id(arg0: &mut PackageConfig, arg1: &0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::admin::AdminCap, arg2: 0x1::string::String) {
        arg0.original_flash_package_id = arg2;
    }

    public fun modify_original_framework_package_id(arg0: &mut PackageConfig, arg1: &0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::admin::AdminCap, arg2: 0x1::string::String) {
        arg0.original_framework_package_id = arg2;
    }

    public fun modify_original_oracle_package_id(arg0: &mut PackageConfig, arg1: &0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::admin::AdminCap, arg2: 0x1::string::String) {
        arg0.original_oracle_package_id = arg2;
    }

    public fun modify_original_psm_package_id(arg0: &mut PackageConfig, arg1: &0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::admin::AdminCap, arg2: 0x1::string::String) {
        arg0.original_psm_package_id = arg2;
    }

    public fun modify_original_saving_incentive_package_id(arg0: &mut PackageConfig, arg1: &0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::admin::AdminCap, arg2: 0x1::string::String) {
        arg0.original_saving_incentive_package_id = arg2;
    }

    public fun modify_original_saving_package_id(arg0: &mut PackageConfig, arg1: &0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::admin::AdminCap, arg2: 0x1::string::String) {
        arg0.original_saving_package_id = arg2;
    }

    public fun modify_original_usdb_package_id(arg0: &mut PackageConfig, arg1: &0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::admin::AdminCap, arg2: 0x1::string::String) {
        arg0.original_usdb_package_id = arg2;
    }

    public fun modify_psm_package_id(arg0: &mut PackageConfig, arg1: &0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::admin::AdminCap, arg2: 0x1::string::String) {
        arg0.psm_package_id = arg2;
    }

    public fun modify_saving_incentive_package_id(arg0: &mut PackageConfig, arg1: &0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::admin::AdminCap, arg2: 0x1::string::String) {
        arg0.saving_incentive_package_id = arg2;
    }

    public fun modify_saving_package_id(arg0: &mut PackageConfig, arg1: &0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::admin::AdminCap, arg2: 0x1::string::String) {
        arg0.saving_package_id = arg2;
    }

    public fun modify_usdb_package_id(arg0: &mut PackageConfig, arg1: &0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::admin::AdminCap, arg2: 0x1::string::String) {
        arg0.usdb_package_id = arg2;
    }

    public fun new_package_config(arg0: &0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::admin::AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: 0x1::string::String, arg17: 0x1::string::String, arg18: 0x1::string::String, arg19: 0x1::string::String, arg20: 0x1::string::String, arg21: &mut 0x2::tx_context::TxContext) {
        let v0 = PackageConfig{
            id                                   : 0x2::object::new(arg21),
            original_framework_package_id        : arg1,
            original_usdb_package_id             : arg2,
            original_oracle_package_id           : arg3,
            original_cdp_package_id              : arg4,
            original_psm_package_id              : arg5,
            original_flash_package_id            : arg6,
            original_saving_package_id           : arg7,
            original_saving_incentive_package_id : arg8,
            original_borrow_incentive_package_id : arg9,
            original_blacklist_package_id        : arg10,
            framework_package_id                 : arg11,
            usdb_package_id                      : arg12,
            oracle_package_id                    : arg13,
            cdp_package_id                       : arg14,
            psm_package_id                       : arg15,
            flash_package_id                     : arg16,
            saving_package_id                    : arg17,
            saving_incentive_package_id          : arg18,
            borrow_incentive_package_id          : arg19,
            blacklist_package_id                 : arg20,
        };
        0x2::transfer::share_object<PackageConfig>(v0);
    }

    // decompiled from Move bytecode v6
}

