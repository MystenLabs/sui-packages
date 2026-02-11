module 0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::config {
    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        active_assistants: vector<0x2::object::ID>,
    }

    public fun balance(arg0: &Config) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun join(arg0: &mut Config, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert_package_version(arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public(friend) fun new<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : Config {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13835339818021814275);
        Config{
            id                : 0x2::object::new(arg1),
            version           : 1,
            balance           : 0x2::balance::zero<0x2::sui::SUI>(),
            active_assistants : 0x1::vector::empty<0x2::object::ID>(),
        }
    }

    public fun active_assistants(arg0: &Config) : vector<0x2::object::ID> {
        arg0.active_assistants
    }

    public fun assert_authority_cap_is_valid<T0>(arg0: &Config, arg1: &0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::authority::AuthorityCap<0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::authority::PACKAGE, T0>) {
        assert!(has_authority<T0>(arg0, arg1), 13835621971603488773);
    }

    public fun assert_package_version(arg0: &Config) {
        assert!(arg0.version == 1, 13835058991585034241);
    }

    public(friend) fun borrow_mut_id(arg0: &mut Config) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun derive_gas_pool_address_for_owner(arg0: &Config, arg1: address) : address {
        0x2::derived_object::derive_address<address>(0x2::object::uid_to_inner(&arg0.id), arg1)
    }

    public(friend) fun has_authority<T0>(arg0: &Config, arg1: &0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::authority::AuthorityCap<0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::authority::PACKAGE, T0>) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (v0 == 0x1::type_name::with_defining_ids<0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::authority::ADMIN>()) {
            true
        } else if (v0 == 0x1::type_name::with_defining_ids<0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::authority::ASSISTANT>()) {
            let v2 = 0x2::object::id<0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::authority::AuthorityCap<0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::authority::PACKAGE, T0>>(arg1);
            0x1::vector::contains<0x2::object::ID>(&arg0.active_assistants, &v2)
        } else {
            false
        }
    }

    public fun new_assistant_cap(arg0: &mut Config, arg1: &0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::authority::AuthorityCap<0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::authority::PACKAGE, 0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::authority::AuthorityCap<0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::authority::PACKAGE, 0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::authority::ASSISTANT> {
        assert_package_version(arg0);
        let v0 = 0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::authority::create_package_assistant_cap(arg2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.active_assistants, 0x2::object::id<0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::authority::AuthorityCap<0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::authority::PACKAGE, 0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::authority::ASSISTANT>>(&v0));
        v0
    }

    public fun put(arg0: &mut Config, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        assert_package_version(arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    public fun revoke_assistant_cap(arg0: &mut Config, arg1: &0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::authority::AuthorityCap<0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::authority::PACKAGE, 0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::authority::ADMIN>, arg2: 0x2::object::ID) {
        assert_package_version(arg0);
        let v0 = &arg0.active_assistants;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x2::object::ID>(v0)) {
            if (0x1::vector::borrow<0x2::object::ID>(v0, v1) == &arg2) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                assert!(0x1::option::is_some<u64>(&v2), 13835903227536998407);
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

    public fun upgrade_version(arg0: &mut Config, arg1: &0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::authority::AuthorityCap<0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::authority::PACKAGE, 0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::authority::ADMIN>) {
        assert!(arg0.version < 1, 13835058652282617857);
        arg0.version = 1;
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    public fun withdraw<T0>(arg0: &mut Config, arg1: &0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::authority::AuthorityCap<0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::authority::PACKAGE, T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_package_version(arg0);
        assert_authority_cap_is_valid<T0>(arg0, arg1);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

