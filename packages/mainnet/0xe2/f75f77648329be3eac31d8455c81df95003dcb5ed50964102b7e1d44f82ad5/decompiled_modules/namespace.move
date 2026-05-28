module 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::namespace {
    struct Namespace has key {
        id: 0x2::object::UID,
        upgrade_cap_id: 0x1::option::Option<0x2::object::ID>,
        versioning: 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::versioning::Versioning,
    }

    public fun account_address(arg0: &Namespace, arg1: address) : address {
        0x2::derived_object::derive_address<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::keys::AccountKey>(0x2::object::uid_to_inner(&arg0.id), 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::keys::account_key(arg1))
    }

    public(friend) fun account_address_from_id(arg0: 0x2::object::ID, arg1: address) : address {
        0x2::derived_object::derive_address<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::keys::AccountKey>(arg0, 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::keys::account_key(arg1))
    }

    public fun account_exists(arg0: &Namespace, arg1: address) : bool {
        0x2::derived_object::exists<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::keys::AccountKey>(&arg0.id, 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::keys::account_key(arg1))
    }

    public fun block_version(arg0: &mut Namespace, arg1: &0x2::package::UpgradeCap, arg2: u64) {
        assert!(is_valid_upgrade_cap(arg0, arg1), 13835339796546977795);
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::versioning::block_version(&mut arg0.versioning, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Namespace{
            id             : 0x2::object::new(arg0),
            upgrade_cap_id : 0x1::option::none<0x2::object::ID>(),
            versioning     : 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::versioning::new(),
        };
        0x2::transfer::share_object<Namespace>(v0);
    }

    fun is_valid_upgrade_cap(arg0: &Namespace, arg1: &0x2::package::UpgradeCap) : bool {
        let v0 = &arg0.upgrade_cap_id;
        if (0x1::option::is_some<0x2::object::ID>(v0)) {
            let v2 = 0x2::object::id<0x2::package::UpgradeCap>(arg1);
            0x1::option::borrow<0x2::object::ID>(v0) == &v2
        } else {
            false
        }
    }

    public fun policy_address<T0>(arg0: &Namespace) : address {
        0x2::derived_object::derive_address<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::keys::PolicyKey<T0>>(0x2::object::uid_to_inner(&arg0.id), 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::keys::policy_key<T0>())
    }

    public fun policy_exists<T0>(arg0: &Namespace) : bool {
        0x2::derived_object::exists<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::keys::PolicyKey<T0>>(&arg0.id, 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::keys::policy_key<T0>())
    }

    entry fun setup(arg0: &mut Namespace, arg1: &0x2::package::UpgradeCap) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.upgrade_cap_id), 13835058257145626625);
        let v0 = 0x1::type_name::with_defining_ids<Namespace>();
        let v1 = 0x2::package::upgrade_package(arg1);
        assert!(0x1::type_name::address_string(&v0) == 0x2::address::to_ascii_string(0x2::object::id_to_address(&v1)), 13835339753597304835);
        arg0.upgrade_cap_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::package::UpgradeCap>(arg1));
    }

    public(friend) fun uid_mut(arg0: &mut Namespace) : &mut 0x2::object::UID {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.upgrade_cap_id), 13835621443322511365);
        &mut arg0.id
    }

    public fun unblock_version(arg0: &mut Namespace, arg1: &0x2::package::UpgradeCap, arg2: u64) {
        assert!(is_valid_upgrade_cap(arg0, arg1), 13835339822316781571);
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::versioning::unblock_version(&mut arg0.versioning, arg2);
    }

    public(friend) fun versioning(arg0: &Namespace) : 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::versioning::Versioning {
        arg0.versioning
    }

    // decompiled from Move bytecode v7
}

