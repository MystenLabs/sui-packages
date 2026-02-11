module 0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::gas_pool {
    struct GasPool has key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        whitelisted: vector<address>,
    }

    public fun balance(arg0: &GasPool, arg1: &0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::config::Config) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun join(arg0: &mut GasPool, arg1: &0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::config::Config, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::config::assert_package_version(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::events::emit_join_gas_pool_event(0x2::object::uid_to_inner(&arg0.id), 0x2::coin::value<0x2::sui::SUI>(&arg2));
    }

    public(friend) fun assert_sender_is_owner(arg0: &GasPool, arg1: address) {
        assert!(arg0.owner == arg1, 13835340436497104899);
    }

    public fun authorize(arg0: &mut GasPool, arg1: &0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::config::Config, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::config::assert_package_version(arg1);
        assert_sender_is_owner(arg0, 0x2::tx_context::sender(arg3));
        assert!(!0x1::vector::contains<address>(&arg0.whitelisted, &arg2), 13835621533516824581);
        0x1::vector::push_back<address>(&mut arg0.whitelisted, arg2);
        0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::events::emit_authorize_gas_pool_address_event(0x2::object::uid_to_inner(&arg0.id), arg2);
    }

    public fun deauthorize(arg0: &mut GasPool, arg1: &0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::config::Config, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::config::assert_package_version(arg1);
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
                        0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::events::emit_deauthorize_gas_pool_address_event(0x2::object::uid_to_inner(&arg0.id), arg2);
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

    public fun deauthorize_self(arg0: &mut GasPool, arg1: &0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::config::Config, arg2: &0x2::tx_context::TxContext) {
        0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::config::assert_package_version(arg1);
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
                        0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::events::emit_deauthorize_gas_pool_address_event(0x2::object::uid_to_inner(&arg0.id), 0x2::tx_context::sender(arg2));
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

    public fun derive_gas_pool_address(arg0: &0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::config::Config, arg1: address) : address {
        0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::config::derive_gas_pool_address_for_owner(arg0, arg1)
    }

    public fun is_authorized(arg0: &GasPool, arg1: &0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::config::Config, arg2: address) : bool {
        arg0.owner == arg2 || 0x1::vector::contains<address>(&arg0.whitelisted, &arg2)
    }

    public fun new(arg0: &mut 0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::config::Config, arg1: &mut 0x2::tx_context::TxContext) {
        0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::config::assert_package_version(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, v0);
        let v2 = GasPool{
            id          : 0x2::derived_object::claim<address>(0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::config::borrow_mut_id(arg0), v0),
            owner       : v0,
            balance     : 0x2::balance::zero<0x2::sui::SUI>(),
            whitelisted : v1,
        };
        0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::events::emit_create_gas_pool_event(0x2::object::uid_to_inner(&v2.id), v0);
        0x2::transfer::share_object<GasPool>(v2);
    }

    public fun owner(arg0: &GasPool, arg1: &0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::config::Config) : address {
        arg0.owner
    }

    public fun split(arg0: &mut GasPool, arg1: &0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::config::Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::config::assert_package_version(arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.owner == v0 || 0x1::vector::contains<address>(&arg0.whitelisted, &v0), 13835058493368827905);
        0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::events::emit_split_gas_pool_event(0x2::object::uid_to_inner(&arg0.id), v0, arg2);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

