module 0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::gas_pool {
    struct GasPool has key {
        id: 0x2::object::UID,
        owner: address,
        whitelisted: vector<address>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct GasPoolSharePolicy {
        pos0: 0x2::object::ID,
    }

    public fun balance(arg0: &GasPool, arg1: &0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::config::Config) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun join(arg0: &mut GasPool, arg1: &0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::config::Config, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::config::assert_package_version(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::events::emit_join_gas_pool_event(0x2::object::uid_to_inner(&arg0.id), 0x2::coin::value<0x2::sui::SUI>(&arg2));
    }

    public fun split(arg0: &mut GasPool, arg1: &0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::config::Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::config::assert_package_version(arg1);
        assert_sender_is_owner(arg0, 0x2::tx_context::sender(arg3));
        0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::events::emit_split_gas_pool_event(0x2::object::uid_to_inner(&arg0.id), arg2);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg2, arg3)
    }

    public(friend) fun assert_sender_is_owner(arg0: &GasPool, arg1: address) {
        assert!(arg0.owner == arg1, 13835340702785077251);
    }

    public fun authorize(arg0: &mut GasPool, arg1: &0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::config::Config, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::config::assert_package_version(arg1);
        assert_sender_is_owner(arg0, 0x2::tx_context::sender(arg3));
        assert!(!0x1::vector::contains<address>(&arg0.whitelisted, &arg2), 13835621812689698821);
        0x1::vector::push_back<address>(&mut arg0.whitelisted, arg2);
        0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::events::emit_authorize_gas_pool_address_event(0x2::object::uid_to_inner(&arg0.id), arg2);
    }

    public fun consume_policy_and_share(arg0: GasPool, arg1: GasPoolSharePolicy) {
        let GasPoolSharePolicy { pos0: v0 } = arg1;
        assert!(0x2::object::uid_to_inner(&arg0.id) == v0, 13835902948364124167);
        0x2::transfer::share_object<GasPool>(arg0);
    }

    public fun create_with_share_policy(arg0: &mut 0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::config::Config, arg1: &mut 0x2::tx_context::TxContext) : (GasPool, GasPoolSharePolicy) {
        0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::config::assert_package_version(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, v0);
        let v2 = GasPool{
            id          : 0x2::derived_object::claim<address>(0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::config::borrow_mut_id(arg0), v0),
            owner       : v0,
            whitelisted : v1,
            balance     : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v3 = 0x2::object::uid_to_inner(&v2.id);
        0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::events::emit_create_gas_pool_event(v3, v0);
        let v4 = GasPoolSharePolicy{pos0: v3};
        (v2, v4)
    }

    public fun deauthorize(arg0: &mut GasPool, arg1: &0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::config::Config, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::config::assert_package_version(arg1);
        assert_sender_is_owner(arg0, 0x2::tx_context::sender(arg3));
        if (arg0.owner == arg2) {
        } else {
            let v0 = &arg0.whitelisted;
            let v1 = 0;
            while (v1 < 0x1::vector::length<address>(v0)) {
                if (*0x1::vector::borrow<address>(v0, v1) == arg2) {
                    /* label 8 */
                    let v2 = 0x1::option::some<u64>(v1);
                    if (0x1::option::is_some<u64>(&v2)) {
                        0x1::vector::remove<address>(&mut arg0.whitelisted, 0x1::option::destroy_some<u64>(v2));
                        0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::events::emit_deauthorize_gas_pool_address_event(0x2::object::uid_to_inner(&arg0.id), arg2);
                        return
                    } else {
                        0x1::option::destroy_none<u64>(v2);
                        return
                    };
                } else {
                    /* goto 13 */
                };
            };
        };
        return
        /* label 13 */
        /* goto 3 */
        continue;
        /* goto 8 */
    }

    public fun deauthorize_self(arg0: &mut GasPool, arg1: &0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::config::Config, arg2: &0x2::tx_context::TxContext) {
        0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::config::assert_package_version(arg1);
        if (arg0.owner == 0x2::tx_context::sender(arg2)) {
        } else {
            let v0 = &arg0.whitelisted;
            let v1 = 0;
            while (v1 < 0x1::vector::length<address>(v0)) {
                if (*0x1::vector::borrow<address>(v0, v1) == 0x2::tx_context::sender(arg2)) {
                    /* label 8 */
                    let v2 = 0x1::option::some<u64>(v1);
                    if (0x1::option::is_some<u64>(&v2)) {
                        0x1::vector::remove<address>(&mut arg0.whitelisted, 0x1::option::destroy_some<u64>(v2));
                        0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::events::emit_deauthorize_gas_pool_address_event(0x2::object::uid_to_inner(&arg0.id), 0x2::tx_context::sender(arg2));
                        return
                    } else {
                        0x1::option::destroy_none<u64>(v2);
                        return
                    };
                } else {
                    /* goto 13 */
                };
            };
        };
        return
        /* label 13 */
        /* goto 3 */
        continue;
        /* goto 8 */
    }

    public fun derive_gas_pool_address(arg0: &0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::config::Config, arg1: address) : address {
        0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::config::derive_gas_pool_address_for_owner(arg0, arg1)
    }

    public fun is_authorized(arg0: &GasPool, arg1: &0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::config::Config, arg2: address) : bool {
        arg0.owner == arg2 || 0x1::vector::contains<address>(&arg0.whitelisted, &arg2)
    }

    public fun new(arg0: &mut 0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::config::Config, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_with_share_policy(arg0, arg1);
        consume_policy_and_share(v0, v1);
    }

    public fun owner(arg0: &GasPool, arg1: &0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::config::Config) : address {
        arg0.owner
    }

    public fun sponsor(arg0: &mut GasPool, arg1: &mut 0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::config::Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::config::assert_package_version(arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.owner == v0 || 0x1::vector::contains<address>(&arg0.whitelisted, &v0), 13835058768246734849);
        0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::config::put(arg1, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg2));
        0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::events::emit_sponsor_event(0x2::object::uid_to_inner(&arg0.id), v0, arg2);
    }

    // decompiled from Move bytecode v6
}

