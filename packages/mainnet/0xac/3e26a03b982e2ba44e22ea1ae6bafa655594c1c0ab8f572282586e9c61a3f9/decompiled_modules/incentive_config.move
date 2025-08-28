module 0xac3e26a03b982e2ba44e22ea1ae6bafa655594c1c0ab8f572282586e9c61a3f9::incentive_config {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u16>,
        managers: 0x2::vec_set::VecSet<address>,
    }

    public fun add_manager(arg0: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg1.managers, arg2);
    }

    public fun add_version(arg0: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg1: &mut GlobalConfig, arg2: u16) {
        0x2::vec_set::insert<u16>(&mut arg1.versions, arg2);
    }

    public fun assert_sender_is_manager(arg0: &GlobalConfig, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest) {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1);
        if (!0x2::vec_set::contains<address>(&arg0.managers, &v0)) {
            err_sender_is_not_manager();
        };
    }

    public fun assert_valid_package_version(arg0: &GlobalConfig) {
        let v0 = package_version();
        if (!0x2::vec_set::contains<u16>(&arg0.versions, &v0)) {
            err_invalid_package_version();
        };
    }

    fun err_invalid_package_version() {
        abort 101
    }

    fun err_sender_is_not_manager() {
        abort 102
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id       : 0x2::object::new(arg0),
            versions : 0x2::vec_set::singleton<u16>(package_version()),
            managers : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg0)),
        };
        0x2::transfer::share_object<GlobalConfig>(v0);
    }

    public fun package_version() : u16 {
        2
    }

    public fun remove_manager(arg0: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg1.managers, &arg2);
    }

    public fun remove_version(arg0: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg1: &mut GlobalConfig, arg2: u16) {
        0x2::vec_set::remove<u16>(&mut arg1.versions, &arg2);
    }

    // decompiled from Move bytecode v6
}

