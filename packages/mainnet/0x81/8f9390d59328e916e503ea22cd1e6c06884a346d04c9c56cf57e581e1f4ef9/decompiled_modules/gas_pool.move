module 0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::gas_pool {
    struct GasPool has key {
        id: 0x2::object::UID,
        owner: address,
        whitelisted: vector<address>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        last_settled_checkpoint: u64,
    }

    struct GasPoolSharePolicy {
        pos0: 0x2::object::ID,
    }

    public fun balance(arg0: &GasPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun join(arg0: &mut GasPool, arg1: &0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::config::Config, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::config::assert_package_version(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::events::emit_join_gas_pool_event(0x2::object::uid_to_inner(&arg0.id), 0x2::coin::value<0x2::sui::SUI>(&arg2));
    }

    public fun split(arg0: &mut GasPool, arg1: &0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::config::Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::config::assert_package_version(arg1);
        assert_sender_is_owner(arg0, 0x2::tx_context::sender(arg3));
        assert_retains_minimum(arg0, arg1, arg2);
        0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::events::emit_split_gas_pool_event(0x2::object::uid_to_inner(&arg0.id), arg2);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg2, arg3)
    }

    public fun admin_join(arg0: &mut GasPool, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::PACKAGE, 0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::MAINTENANCE>, arg2: &0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::config::Config, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::config::assert_package_version(arg2);
        0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::config::assert_package_maintenance_cap_is_valid(arg2, arg1);
        let v0 = advance_settlement_checkpoint(arg0, arg4);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg3);
        if (v1 == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg3);
            return
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, arg3);
        0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::events::emit_admin_join_gas_pool_event(0x2::object::uid_to_inner(&arg0.id), v1, 0x2::tx_context::sender(arg5), v0, arg4);
    }

    public fun admin_split(arg0: &mut GasPool, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::PACKAGE, 0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::authority::MAINTENANCE>, arg2: &0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::config::Config, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::config::assert_package_version(arg2);
        0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::config::assert_package_maintenance_cap_is_valid(arg2, arg1);
        let v0 = advance_settlement_checkpoint(arg0, arg4);
        if (arg3 == 0) {
            return
        };
        let v1 = 0x2::tx_context::sender(arg5);
        0x2::balance::send_funds<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg3), v1);
        0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::events::emit_admin_split_gas_pool_event(0x2::object::uid_to_inner(&arg0.id), arg3, v1, v0, arg4);
    }

    public(friend) fun advance_settlement_checkpoint(arg0: &mut GasPool, arg1: u64) : u64 {
        let v0 = arg0.last_settled_checkpoint;
        assert!(arg1 > v0, 13836467083728781323);
        arg0.last_settled_checkpoint = arg1;
        v0
    }

    public(friend) fun assert_retains_minimum(arg0: &GasPool, arg1: &0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::config::Config, arg2: u64) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        assert!(v0 >= arg2 && v0 - arg2 >= 0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::config::min_pool_balance(arg1), 13836185668881481737);
    }

    public(friend) fun assert_sender_is_owner(arg0: &GasPool, arg1: address) {
        assert!(arg0.owner == arg1, 13835341162346577923);
    }

    public fun authorize(arg0: &mut GasPool, arg1: &0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::config::Config, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::config::assert_package_version(arg1);
        assert_sender_is_owner(arg0, 0x2::tx_context::sender(arg3));
        assert!(!0x1::vector::contains<address>(&arg0.whitelisted, &arg2), 13835622255071330309);
        0x1::vector::push_back<address>(&mut arg0.whitelisted, arg2);
        0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::events::emit_authorize_gas_pool_address_event(0x2::object::uid_to_inner(&arg0.id), arg2);
    }

    public fun consume_policy_and_share(arg0: GasPool, arg1: GasPoolSharePolicy) {
        let GasPoolSharePolicy { pos0: v0 } = arg1;
        assert!(0x2::object::uid_to_inner(&arg0.id) == v0, 13835903004198699015);
        0x2::transfer::share_object<GasPool>(arg0);
    }

    public fun create_with_share_policy(arg0: &mut 0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::config::Config, arg1: address) : (GasPool, GasPoolSharePolicy) {
        0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::config::assert_package_version(arg0);
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, arg1);
        let v1 = GasPool{
            id                      : 0x2::derived_object::claim<address>(0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::config::borrow_mut_id(arg0), arg1),
            owner                   : arg1,
            whitelisted             : v0,
            balance                 : 0x2::balance::zero<0x2::sui::SUI>(),
            last_settled_checkpoint : 0,
        };
        let v2 = 0x2::object::uid_to_inner(&v1.id);
        0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::events::emit_create_gas_pool_event(v2, arg1);
        let v3 = GasPoolSharePolicy{pos0: v2};
        (v1, v3)
    }

    public fun deauthorize(arg0: &mut GasPool, arg1: &0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::config::Config, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::config::assert_package_version(arg1);
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
                        0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::events::emit_deauthorize_gas_pool_address_event(0x2::object::uid_to_inner(&arg0.id), arg2);
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

    public fun deauthorize_self(arg0: &mut GasPool, arg1: &0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::config::Config, arg2: &0x2::tx_context::TxContext) {
        0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::config::assert_package_version(arg1);
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
                        0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::events::emit_deauthorize_gas_pool_address_event(0x2::object::uid_to_inner(&arg0.id), 0x2::tx_context::sender(arg2));
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

    public fun derive_gas_pool_address(arg0: &0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::config::Config, arg1: address) : address {
        0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::config::derive_gas_pool_address_for_owner(arg0, arg1)
    }

    public fun is_authorized(arg0: &GasPool, arg1: address) : bool {
        arg0.owner == arg1 || 0x1::vector::contains<address>(&arg0.whitelisted, &arg1)
    }

    public fun last_settled_checkpoint(arg0: &GasPool) : u64 {
        arg0.last_settled_checkpoint
    }

    public fun new(arg0: &mut 0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::config::Config, arg1: address) {
        let (v0, v1) = create_with_share_policy(arg0, arg1);
        consume_policy_and_share(v0, v1);
    }

    public fun owner(arg0: &GasPool) : address {
        arg0.owner
    }

    public fun rebate_sponsor(arg0: &mut GasPool, arg1: &0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::config::Config, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::config::assert_package_version(arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.owner == v0 || 0x1::vector::contains<address>(&arg0.whitelisted, &v0), 13835059189153529857);
        assert_retains_minimum(arg0, arg1, arg2);
        let v1 = 0x2::tx_context::sponsor(arg3);
        let v2 = 0x1::option::extract<address>(&mut v1);
        0x2::balance::send_funds<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg2), v2);
        0x818f9390d59328e916e503ea22cd1e6c06884a346d04c9c56cf57e581e1f4ef9::events::emit_sponsor_event(0x2::object::uid_to_inner(&arg0.id), v0, v2, arg2);
    }

    // decompiled from Move bytecode v7
}

