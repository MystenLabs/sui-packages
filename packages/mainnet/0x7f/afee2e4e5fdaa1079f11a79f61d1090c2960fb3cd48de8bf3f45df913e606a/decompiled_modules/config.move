module 0x7fafee2e4e5fdaa1079f11a79f61d1090c2960fb3cd48de8bf3f45df913e606a::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        package_version: u64,
        minter: address,
        backup_collector: address,
        is_mintable: bool,
    }

    public fun assert_is_mintable(arg0: &GlobalConfig) {
        assert!(arg0.is_mintable, 2);
    }

    public fun assert_sender_is_minter(arg0: &GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.minter == 0x2::tx_context::sender(arg1), 1);
    }

    public fun assert_valid_package_version(arg0: &GlobalConfig) {
        assert!(arg0.package_version == 1, 0);
    }

    public fun backup_collector(arg0: &GlobalConfig) : address {
        arg0.backup_collector
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = GlobalConfig{
            id               : 0x2::object::new(arg0),
            package_version  : 1,
            minter           : @0xd3ac9139cc0f4b80f56003d5867d637ac99c77b2fc31ca8fba760c41c45b48d2,
            backup_collector : v0,
            is_mintable      : true,
        };
        0x2::transfer::share_object<GlobalConfig>(v2);
    }

    public fun is_mintable(arg0: &GlobalConfig) : bool {
        arg0.is_mintable
    }

    public fun minter(arg0: &GlobalConfig) : address {
        arg0.minter
    }

    public fun package_version(arg0: &GlobalConfig) : u64 {
        arg0.package_version
    }

    public fun rotate_backup_collector(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        arg1.backup_collector = arg2;
    }

    public fun rotate_minter(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        arg1.minter = arg2;
    }

    public fun toggle_mintable(arg0: &AdminCap, arg1: &mut GlobalConfig) {
        arg1.is_mintable = !arg1.is_mintable;
    }

    public fun update_version(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.package_version = arg2;
    }

    // decompiled from Move bytecode v6
}

