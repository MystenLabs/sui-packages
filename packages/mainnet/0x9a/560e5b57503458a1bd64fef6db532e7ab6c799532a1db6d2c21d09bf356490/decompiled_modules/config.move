module 0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::config {
    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        storage_count: u64,
        active_assistants: vector<0x2::object::ID>,
    }

    public(friend) fun new<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : Config {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13835339822316781571);
        Config{
            id                : 0x2::object::new(arg1),
            version           : 1,
            storage_count     : 8,
            active_assistants : 0x1::vector::empty<0x2::object::ID>(),
        }
    }

    public fun active_assistants(arg0: &Config) : vector<0x2::object::ID> {
        arg0.active_assistants
    }

    public fun assert_authority_cap_is_valid<T0>(arg0: &Config, arg1: &0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::AuthorityCap<0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::PACKAGE, T0>) {
        assert!(has_authority<T0>(arg0, arg1), 13835621889999110149);
    }

    public fun assert_package_version(arg0: &Config) {
        assert!(arg0.version == 1, 13835058909980655617);
    }

    public(friend) fun borrow_mut_id(arg0: &mut Config) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun derive_gas_pool_address_for_owner(arg0: &Config, arg1: address) : address {
        0x2::derived_object::derive_address<address>(0x2::object::uid_to_inner(&arg0.id), arg1)
    }

    public(friend) fun has_authority<T0>(arg0: &Config, arg1: &0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::AuthorityCap<0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::PACKAGE, T0>) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (v0 == 0x1::type_name::with_defining_ids<0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::ADMIN>()) {
            true
        } else if (v0 == 0x1::type_name::with_defining_ids<0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::ASSISTANT>()) {
            let v2 = 0x2::object::id<0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::AuthorityCap<0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::PACKAGE, T0>>(arg1);
            0x1::vector::contains<0x2::object::ID>(&arg0.active_assistants, &v2)
        } else {
            false
        }
    }

    public fun increase_storage_count(arg0: &mut Config, arg1: &0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::AuthorityCap<0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::PACKAGE, 0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::ADMIN>, arg2: u64) {
        assert_package_version(arg0);
        arg0.storage_count = arg0.storage_count + arg2;
    }

    public(friend) fun increment_storage_count(arg0: &mut Config) {
        arg0.storage_count = arg0.storage_count + 1;
    }

    public fun new_assistant_cap(arg0: &mut Config, arg1: &0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::AuthorityCap<0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::PACKAGE, 0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::AuthorityCap<0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::PACKAGE, 0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::ASSISTANT> {
        assert_package_version(arg0);
        let v0 = 0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::create_package_assistant_cap(arg2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.active_assistants, 0x2::object::id<0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::AuthorityCap<0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::PACKAGE, 0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::ASSISTANT>>(&v0));
        v0
    }

    public fun revoke_assistant_cap(arg0: &mut Config, arg1: &0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::AuthorityCap<0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::PACKAGE, 0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::ADMIN>, arg2: 0x2::object::ID) {
        assert_package_version(arg0);
        let v0 = &arg0.active_assistants;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x2::object::ID>(v0)) {
            if (0x1::vector::borrow<0x2::object::ID>(v0, v1) == &arg2) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                assert!(0x1::option::is_some<u64>(&v2), 13835903206062161927);
                0x1::vector::remove<0x2::object::ID>(&mut arg0.active_assistants, 0x1::option::extract<u64>(&mut v2));
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun share(arg0: Config) {
        0x2::transfer::share_object<Config>(arg0);
    }

    public fun storage_count(arg0: &Config) : u64 {
        arg0.storage_count
    }

    public fun upgrade_version(arg0: &mut Config, arg1: &0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::AuthorityCap<0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::PACKAGE, 0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::ADMIN>) {
        assert!(arg0.version < 1, 13835058579268173825);
        arg0.version = 1;
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

