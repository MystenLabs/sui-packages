module 0x34adce5ef86f2af51ac26637f1d7f9ef3f5f7a800d49f2ec6c2452f17091eda9::keychain {
    struct MasterCap has store, key {
        id: 0x2::object::UID,
    }

    struct Keychain has store, key {
        id: 0x2::object::UID,
        vault_caps: 0x2::object_bag::ObjectBag,
        strategy_caps: 0x2::object_bag::ObjectBag,
        action_allowlist: 0x2::vec_map::VecMap<address, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>,
    }

    public fun action_allowed<T0>(arg0: &Keychain, arg1: address) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(0x2::vec_map::get<address, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.action_allowlist, &arg1), &v0)
    }

    public fun add_address_to_allowlist_empty(arg0: &MasterCap, arg1: &mut Keychain, arg2: address) {
        0x2::vec_map::insert<address, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg1.action_allowlist, arg2, 0x2::vec_set::empty<0x1::type_name::TypeName>());
    }

    public fun address_in_allowlist(arg0: &Keychain, arg1: address) : bool {
        0x2::vec_map::contains<address, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.action_allowlist, &arg1)
    }

    public(friend) fun allow_action_for_address<T0: drop>(arg0: &MasterCap, arg1: &mut Keychain, arg2: address, arg3: T0) {
        if (!address_in_allowlist(arg1, arg2)) {
            add_address_to_allowlist_empty(arg0, arg1, arg2);
        };
        0x2::vec_set::insert<0x1::type_name::TypeName>(0x2::vec_map::get_mut<address, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg1.action_allowlist, &arg2), 0x1::type_name::get<T0>());
    }

    public(friend) fun borrow_strategy_cap<T0: store + key>(arg0: &Keychain) : &T0 {
        0x2::object_bag::borrow<0x1::type_name::TypeName, T0>(&arg0.strategy_caps, 0x1::type_name::get<T0>())
    }

    public(friend) fun borrow_strategy_cap_by_id<T0: store + key>(arg0: &Keychain, arg1: &0x2::object::ID) : &T0 {
        0x2::object_bag::borrow<0x2::object::ID, T0>(&arg0.strategy_caps, *arg1)
    }

    public(friend) fun borrow_vault_cap<T0>(arg0: &Keychain) : &0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::AdminCap<T0> {
        0x2::object_bag::borrow<0x1::type_name::TypeName, 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::AdminCap<T0>>(&arg0.vault_caps, 0x1::type_name::get<T0>())
    }

    public fun disallow_action_for_address<T0>(arg0: &MasterCap, arg1: &mut Keychain, arg2: address) {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(0x2::vec_map::get_mut<address, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg1.action_allowlist, &arg2), &v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Keychain{
            id               : 0x2::object::new(arg0),
            vault_caps       : 0x2::object_bag::new(arg0),
            strategy_caps    : 0x2::object_bag::new(arg0),
            action_allowlist : 0x2::vec_map::empty<address, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(),
        };
        0x2::transfer::share_object<Keychain>(v0);
        let v1 = MasterCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MasterCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun master_borrow_strategy_cap<T0: store + key>(arg0: &MasterCap, arg1: &Keychain) : &T0 {
        0x2::object_bag::borrow<0x1::type_name::TypeName, T0>(&arg1.strategy_caps, 0x1::type_name::get<T0>())
    }

    public fun master_borrow_strategy_cap_by_id<T0: store + key>(arg0: &MasterCap, arg1: &Keychain, arg2: &0x2::object::ID) : &T0 {
        0x2::object_bag::borrow<0x2::object::ID, T0>(&arg1.strategy_caps, *arg2)
    }

    public fun master_borrow_vault_cap<T0>(arg0: &MasterCap, arg1: &Keychain) : &0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::AdminCap<T0> {
        0x2::object_bag::borrow<0x1::type_name::TypeName, 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::AdminCap<T0>>(&arg1.vault_caps, 0x1::type_name::get<T0>())
    }

    public(friend) fun master_put_strategy_cap<T0: store + key>(arg0: &MasterCap, arg1: &mut Keychain, arg2: T0) {
        0x2::object_bag::add<0x1::type_name::TypeName, T0>(&mut arg1.strategy_caps, 0x1::type_name::get<T0>(), arg2);
    }

    public(friend) fun master_put_strategy_cap_by_id<T0: store + key>(arg0: &MasterCap, arg1: &mut Keychain, arg2: T0) {
        0x2::object_bag::add<0x2::object::ID, T0>(&mut arg1.strategy_caps, 0x2::object::id<T0>(&arg2), arg2);
    }

    public fun master_put_vault_cap<T0>(arg0: &MasterCap, arg1: &mut Keychain, arg2: 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::AdminCap<T0>) {
        0x2::object_bag::add<0x1::type_name::TypeName, 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::AdminCap<T0>>(&mut arg1.vault_caps, 0x1::type_name::get<T0>(), arg2);
    }

    public fun master_take_strategy_cap<T0: store + key>(arg0: &MasterCap, arg1: &mut Keychain) : T0 {
        0x2::object_bag::remove<0x1::type_name::TypeName, T0>(&mut arg1.strategy_caps, 0x1::type_name::get<T0>())
    }

    public fun master_take_strategy_cap_by_id<T0: store + key>(arg0: &MasterCap, arg1: &mut Keychain, arg2: &0x2::object::ID) : T0 {
        0x2::object_bag::remove<0x2::object::ID, T0>(&mut arg1.strategy_caps, *arg2)
    }

    public fun master_take_vault_cap<T0>(arg0: &MasterCap, arg1: &mut Keychain) : 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::AdminCap<T0> {
        0x2::object_bag::remove<0x1::type_name::TypeName, 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::AdminCap<T0>>(&mut arg1.vault_caps, 0x1::type_name::get<T0>())
    }

    public fun remove_address_from_allowlist(arg0: &MasterCap, arg1: &mut Keychain, arg2: address) {
        let (_, _) = 0x2::vec_map::remove<address, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg1.action_allowlist, &arg2);
    }

    public fun rotate_address(arg0: &MasterCap, arg1: &mut Keychain, arg2: address, arg3: address) {
        let (_, v1) = 0x2::vec_map::remove<address, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg1.action_allowlist, &arg2);
        0x2::vec_map::insert<address, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg1.action_allowlist, arg3, v1);
    }

    // decompiled from Move bytecode v6
}

