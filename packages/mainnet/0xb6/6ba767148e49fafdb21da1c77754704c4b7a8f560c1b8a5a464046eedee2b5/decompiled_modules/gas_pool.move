module 0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::gas_pool {
    struct GasPool has key {
        id: 0x2::object::UID,
        owner: address,
        whitelisted: vector<address>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct GasPoolSharePolicy {
        pos0: 0x2::object::ID,
    }

    public fun balance(arg0: &GasPool, arg1: &0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::config::Config) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun join(arg0: &mut GasPool, arg1: &0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::config::Config, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::config::assert_package_version(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::events::emit_join_gas_pool_event(0x2::object::uid_to_inner(&arg0.id), 0x2::coin::value<0x2::sui::SUI>(&arg2));
    }

    public fun split(arg0: &mut GasPool, arg1: &0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::config::Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::config::assert_package_version(arg1);
        assert_sender_is_owner(arg0, 0x2::tx_context::sender(arg3));
        0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::events::emit_split_gas_pool_event(0x2::object::uid_to_inner(&arg0.id), arg2);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg2, arg3)
    }

    public(friend) fun assert_sender_is_owner(arg0: &GasPool, arg1: address) {
        assert!(arg0.owner == arg1, 13835340711375011843);
    }

    public fun authorize(arg0: &mut GasPool, arg1: &0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::config::Config, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::config::assert_package_version(arg1);
        assert_sender_is_owner(arg0, 0x2::tx_context::sender(arg3));
        assert!(!0x1::vector::contains<address>(&arg0.whitelisted, &arg2), 13835621821279633413);
        0x1::vector::push_back<address>(&mut arg0.whitelisted, arg2);
        0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::events::emit_authorize_gas_pool_address_event(0x2::object::uid_to_inner(&arg0.id), arg2);
    }

    public fun consume_policy_and_share(arg0: GasPool, arg1: GasPoolSharePolicy) {
        let GasPoolSharePolicy { pos0: v0 } = arg1;
        assert!(0x2::object::uid_to_inner(&arg0.id) == v0, 13835902952659091463);
        0x2::transfer::share_object<GasPool>(arg0);
    }

    public fun create_with_share_policy(arg0: &mut 0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::config::Config, arg1: address) : (GasPool, GasPoolSharePolicy) {
        0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::config::assert_package_version(arg0);
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, arg1);
        let v1 = GasPool{
            id          : 0x2::derived_object::claim<address>(0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::config::borrow_mut_id(arg0), arg1),
            owner       : arg1,
            whitelisted : v0,
            balance     : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v2 = 0x2::object::uid_to_inner(&v1.id);
        0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::events::emit_create_gas_pool_event(v2, arg1);
        let v3 = GasPoolSharePolicy{pos0: v2};
        (v1, v3)
    }

    public fun deauthorize(arg0: &mut GasPool, arg1: &0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::config::Config, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::config::assert_package_version(arg1);
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
                        0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::events::emit_deauthorize_gas_pool_address_event(0x2::object::uid_to_inner(&arg0.id), arg2);
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

    public fun deauthorize_self(arg0: &mut GasPool, arg1: &0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::config::Config, arg2: &0x2::tx_context::TxContext) {
        0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::config::assert_package_version(arg1);
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
                        0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::events::emit_deauthorize_gas_pool_address_event(0x2::object::uid_to_inner(&arg0.id), 0x2::tx_context::sender(arg2));
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

    public fun derive_gas_pool_address(arg0: &0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::config::Config, arg1: address) : address {
        0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::config::derive_gas_pool_address_for_owner(arg0, arg1)
    }

    public fun is_authorized(arg0: &GasPool, arg1: &0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::config::Config, arg2: address) : bool {
        arg0.owner == arg2 || 0x1::vector::contains<address>(&arg0.whitelisted, &arg2)
    }

    public fun new(arg0: &mut 0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::config::Config, arg1: address) {
        let (v0, v1) = create_with_share_policy(arg0, arg1);
        consume_policy_and_share(v0, v1);
    }

    public fun owner(arg0: &GasPool, arg1: &0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::config::Config) : address {
        arg0.owner
    }

    public fun rebate_sponsor(arg0: &mut GasPool, arg1: &mut 0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::storage::Storage, arg2: &0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::config::Config, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::config::assert_package_version(arg2);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.owner == v0 || 0x1::vector::contains<address>(&arg0.whitelisted, &v0), 13835058772541702145);
        0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::storage::put(arg1, arg2, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg3));
        0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::events::emit_sponsor_event(0x2::object::uid_to_inner(&arg0.id), 0x2::object::id<0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::storage::Storage>(arg1), v0, arg3);
    }

    // decompiled from Move bytecode v6
}

