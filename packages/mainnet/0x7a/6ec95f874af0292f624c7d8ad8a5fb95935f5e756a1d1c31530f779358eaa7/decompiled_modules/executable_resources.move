module 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable_resources {
    struct ResourceBagKey has copy, drop, store {
        _priv: bool,
    }

    fun borrow_bag_mut(arg0: &mut 0x2::object::UID) : &mut 0x2::bag::Bag {
        assert!(0x2::dynamic_field::exists_<ResourceBagKey>(arg0, resource_bag_key()), 1);
        0x2::dynamic_field::borrow_mut<ResourceBagKey, 0x2::bag::Bag>(arg0, resource_bag_key())
    }

    fun coin_key<T0>(arg0: 0x1::string::String) : 0x1::string::String {
        0x1::string::append(&mut arg0, 0x1::string::utf8(b"::coin::"));
        0x1::string::append(&mut arg0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())));
        arg0
    }

    fun data_key<T0>(arg0: 0x1::string::String) : 0x1::string::String {
        0x1::string::append(&mut arg0, 0x1::string::utf8(b"::data::"));
        0x1::string::append(&mut arg0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())));
        arg0
    }

    public(friend) fun destroy_resources<T0: store>(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::Executable<T0>) {
        let v0 = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::uid_mut<T0>(arg0);
        if (!0x2::dynamic_field::exists_<ResourceBagKey>(v0, resource_bag_key())) {
            return
        };
        let v1 = 0x2::dynamic_field::remove<ResourceBagKey, 0x2::bag::Bag>(v0, resource_bag_key());
        assert!(0x2::bag::is_empty(&v1), 2);
        0x2::bag::destroy_empty(v1);
    }

    fun get_or_create_bag(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : &mut 0x2::bag::Bag {
        if (!0x2::dynamic_field::exists_<ResourceBagKey>(arg0, resource_bag_key())) {
            0x2::dynamic_field::add<ResourceBagKey, 0x2::bag::Bag>(arg0, resource_bag_key(), 0x2::bag::new(arg1));
        };
        0x2::dynamic_field::borrow_mut<ResourceBagKey, 0x2::bag::Bag>(arg0, resource_bag_key())
    }

    public fun has_coin<T0, T1: store, T2: drop>(arg0: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::Executable<T1>, arg1: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg2: T2, arg3: 0x1::string::String) : bool {
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::assert_current_action_witness<T1, T2>(arg0, arg1, arg2);
        let v0 = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::uid<T1>(arg0);
        if (!0x2::dynamic_field::exists_<ResourceBagKey>(v0, resource_bag_key())) {
            return false
        };
        0x2::bag::contains<0x1::string::String>(0x2::dynamic_field::borrow<ResourceBagKey, 0x2::bag::Bag>(v0, resource_bag_key()), coin_key<T0>(arg3))
    }

    public fun has_data<T0: store, T1: store, T2: drop>(arg0: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::Executable<T1>, arg1: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg2: T2, arg3: 0x1::string::String) : bool {
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::assert_current_action_witness<T1, T2>(arg0, arg1, arg2);
        let v0 = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::uid<T1>(arg0);
        if (!0x2::dynamic_field::exists_<ResourceBagKey>(v0, resource_bag_key())) {
            return false
        };
        0x2::bag::contains<0x1::string::String>(0x2::dynamic_field::borrow<ResourceBagKey, 0x2::bag::Bag>(v0, resource_bag_key()), data_key<T0>(arg3))
    }

    public fun has_object<T0: store + key, T1: store, T2: drop>(arg0: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::Executable<T1>, arg1: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg2: T2, arg3: 0x1::string::String) : bool {
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::assert_current_action_witness<T1, T2>(arg0, arg1, arg2);
        let v0 = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::uid<T1>(arg0);
        if (!0x2::dynamic_field::exists_<ResourceBagKey>(v0, resource_bag_key())) {
            return false
        };
        0x2::bag::contains<0x1::string::String>(0x2::dynamic_field::borrow<ResourceBagKey, 0x2::bag::Bag>(v0, resource_bag_key()), object_key<T0>(arg3))
    }

    fun object_key<T0>(arg0: 0x1::string::String) : 0x1::string::String {
        0x1::string::append(&mut arg0, 0x1::string::utf8(b"::object::"));
        0x1::string::append(&mut arg0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())));
        arg0
    }

    public fun provide_coin<T0, T1: store, T2: drop>(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::Executable<T1>, arg1: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg2: T2, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::assert_current_action_witness<T1, T2>(arg0, arg1, arg2);
        let v0 = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::uid_mut<T1>(arg0);
        let v1 = get_or_create_bag(v0, arg5);
        let v2 = coin_key<T0>(arg3);
        assert!(!0x2::bag::contains<0x1::string::String>(v1, v2), 3);
        0x2::bag::add<0x1::string::String, 0x2::coin::Coin<T0>>(v1, v2, arg4);
    }

    public fun provide_data<T0: store, T1: store, T2: drop>(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::Executable<T1>, arg1: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg2: T2, arg3: 0x1::string::String, arg4: T0, arg5: &mut 0x2::tx_context::TxContext) {
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::assert_current_action_witness<T1, T2>(arg0, arg1, arg2);
        let v0 = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::uid_mut<T1>(arg0);
        let v1 = get_or_create_bag(v0, arg5);
        let v2 = data_key<T0>(arg3);
        assert!(!0x2::bag::contains<0x1::string::String>(v1, v2), 3);
        0x2::bag::add<0x1::string::String, T0>(v1, v2, arg4);
    }

    public fun provide_object<T0: store + key, T1: store, T2: drop>(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::Executable<T1>, arg1: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg2: T2, arg3: 0x1::string::String, arg4: T0, arg5: &mut 0x2::tx_context::TxContext) {
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::assert_current_action_witness<T1, T2>(arg0, arg1, arg2);
        let v0 = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::uid_mut<T1>(arg0);
        let v1 = get_or_create_bag(v0, arg5);
        let v2 = object_key<T0>(arg3);
        assert!(!0x2::bag::contains<0x1::string::String>(v1, v2), 3);
        0x2::bag::add<0x1::string::String, T0>(v1, v2, arg4);
    }

    fun resource_bag_key() : ResourceBagKey {
        ResourceBagKey{_priv: false}
    }

    public fun take_coin<T0, T1: store, T2: drop>(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::Executable<T1>, arg1: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg2: T2, arg3: 0x1::string::String) : 0x2::coin::Coin<T0> {
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::assert_current_action_witness<T1, T2>(arg0, arg1, arg2);
        let v0 = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::uid_mut<T1>(arg0);
        let v1 = borrow_bag_mut(v0);
        let v2 = coin_key<T0>(arg3);
        assert!(0x2::bag::contains<0x1::string::String>(v1, v2), 1);
        0x2::bag::remove<0x1::string::String, 0x2::coin::Coin<T0>>(v1, v2)
    }

    public fun take_data<T0: store, T1: store, T2: drop>(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::Executable<T1>, arg1: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg2: T2, arg3: 0x1::string::String) : T0 {
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::assert_current_action_witness<T1, T2>(arg0, arg1, arg2);
        let v0 = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::uid_mut<T1>(arg0);
        let v1 = borrow_bag_mut(v0);
        let v2 = data_key<T0>(arg3);
        assert!(0x2::bag::contains<0x1::string::String>(v1, v2), 1);
        0x2::bag::remove<0x1::string::String, T0>(v1, v2)
    }

    public fun take_object<T0: store + key, T1: store, T2: drop>(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::Executable<T1>, arg1: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg2: T2, arg3: 0x1::string::String) : T0 {
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::assert_current_action_witness<T1, T2>(arg0, arg1, arg2);
        let v0 = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::uid_mut<T1>(arg0);
        let v1 = borrow_bag_mut(v0);
        let v2 = object_key<T0>(arg3);
        assert!(0x2::bag::contains<0x1::string::String>(v1, v2), 1);
        0x2::bag::remove<0x1::string::String, T0>(v1, v2)
    }

    // decompiled from Move bytecode v6
}

