module 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config {
    struct TransferOperatorsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        allowed_versions: 0x2::vec_set::VecSet<u16>,
        keepers: 0x2::vec_set::VecSet<address>,
    }

    public fun add_keeper(arg0: &mut GlobalConfig, arg1: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::admin::AdminCap, arg2: address) {
        if (!0x2::vec_set::contains<address>(&arg0.keepers, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg0.keepers, arg2);
            0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::events::emit_keeper_added(0x2::object::uid_to_address(&arg0.id), arg2);
        };
    }

    public fun add_transfer_operator(arg0: &mut GlobalConfig, arg1: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::admin::AdminCap, arg2: address) {
        let v0 = TransferOperatorsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<TransferOperatorsKey, 0x2::vec_set::VecSet<address>>(&arg0.id, v0)) {
            0x2::dynamic_field::add<TransferOperatorsKey, 0x2::vec_set::VecSet<address>>(&mut arg0.id, v0, 0x2::vec_set::empty<address>());
        };
        let v1 = 0x2::dynamic_field::borrow_mut<TransferOperatorsKey, 0x2::vec_set::VecSet<address>>(&mut arg0.id, v0);
        if (!0x2::vec_set::contains<address>(v1, &arg2)) {
            0x2::vec_set::insert<address>(v1, arg2);
            0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::events::emit_transfer_operator_added(0x2::object::uid_to_address(&arg0.id), arg2);
        };
    }

    public fun allow_version(arg0: &mut GlobalConfig, arg1: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::admin::AdminCap, arg2: u16) {
        if (!0x2::vec_set::contains<u16>(&arg0.allowed_versions, &arg2)) {
            0x2::vec_set::insert<u16>(&mut arg0.allowed_versions, arg2);
        };
    }

    public fun allowed_versions(arg0: &GlobalConfig) : vector<u16> {
        *0x2::vec_set::keys<u16>(&arg0.allowed_versions)
    }

    public fun assert_version(arg0: &GlobalConfig) {
        let v0 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::version::package_version();
        if (!0x2::vec_set::contains<u16>(&arg0.allowed_versions, &v0)) {
            abort 1
        };
    }

    public fun disallow_version(arg0: &mut GlobalConfig, arg1: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::admin::AdminCap, arg2: u16) {
        if (0x2::vec_set::contains<u16>(&arg0.allowed_versions, &arg2)) {
            0x2::vec_set::remove<u16>(&mut arg0.allowed_versions, &arg2);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id               : 0x2::object::new(arg0),
            allowed_versions : 0x2::vec_set::singleton<u16>(0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::version::package_version()),
            keepers          : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg0)),
        };
        0x2::transfer::share_object<GlobalConfig>(v0);
    }

    public fun is_keeper(arg0: &GlobalConfig, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.keepers, &arg1)
    }

    public fun is_transfer_operator(arg0: &GlobalConfig, arg1: address) : bool {
        let v0 = TransferOperatorsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<TransferOperatorsKey, 0x2::vec_set::VecSet<address>>(&arg0.id, v0)) {
            return false
        };
        0x2::vec_set::contains<address>(0x2::dynamic_field::borrow<TransferOperatorsKey, 0x2::vec_set::VecSet<address>>(&arg0.id, v0), &arg1)
    }

    public fun keeper_addresses(arg0: &GlobalConfig) : vector<address> {
        *0x2::vec_set::keys<address>(&arg0.keepers)
    }

    public fun keeper_count(arg0: &GlobalConfig) : u64 {
        0x2::vec_set::length<address>(&arg0.keepers)
    }

    public fun remove_keeper(arg0: &mut GlobalConfig, arg1: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::admin::AdminCap, arg2: address) {
        if (0x2::vec_set::contains<address>(&arg0.keepers, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg0.keepers, &arg2);
            0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::events::emit_keeper_removed(0x2::object::uid_to_address(&arg0.id), arg2);
        };
    }

    public fun remove_transfer_operator(arg0: &mut GlobalConfig, arg1: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::admin::AdminCap, arg2: address) {
        let v0 = TransferOperatorsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<TransferOperatorsKey, 0x2::vec_set::VecSet<address>>(&arg0.id, v0)) {
            return
        };
        let v1 = 0x2::dynamic_field::borrow_mut<TransferOperatorsKey, 0x2::vec_set::VecSet<address>>(&mut arg0.id, v0);
        if (0x2::vec_set::contains<address>(v1, &arg2)) {
            0x2::vec_set::remove<address>(v1, &arg2);
            0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::events::emit_transfer_operator_removed(0x2::object::uid_to_address(&arg0.id), arg2);
        };
    }

    public fun transfer_operators(arg0: &GlobalConfig) : vector<address> {
        let v0 = TransferOperatorsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<TransferOperatorsKey, 0x2::vec_set::VecSet<address>>(&arg0.id, v0)) {
            return vector[]
        };
        *0x2::vec_set::keys<address>(0x2::dynamic_field::borrow<TransferOperatorsKey, 0x2::vec_set::VecSet<address>>(&arg0.id, v0))
    }

    // decompiled from Move bytecode v7
}

