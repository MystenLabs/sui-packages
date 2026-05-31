module 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::delegate {
    struct Entry has store {
        by_service: 0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::KeyedBigVector,
        by_coin: 0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::KeyedBigVector,
    }

    struct Delegate has store {
        main_owner: address,
        entries: 0x2::table::Table<address, Entry>,
    }

    struct Initialized has copy, drop {
        wallet_id: 0x2::object::ID,
        main_owner: address,
    }

    struct Added has copy, drop {
        wallet_id: 0x2::object::ID,
        delegate: address,
    }

    struct Removed has copy, drop {
        wallet_id: 0x2::object::ID,
        delegate: address,
    }

    struct ServiceAllowanceChanged has copy, drop {
        wallet_id: 0x2::object::ID,
        delegate: address,
        service: 0x1::type_name::TypeName,
        new_amount: u64,
    }

    struct CoinAllowanceChanged has copy, drop {
        wallet_id: 0x2::object::ID,
        delegate: address,
        coin: 0x1::type_name::TypeName,
        new_amount: u64,
    }

    struct ServiceAllowanceDebited has copy, drop {
        wallet_id: 0x2::object::ID,
        spender: address,
        service: 0x1::type_name::TypeName,
        amount: u64,
        remaining: u64,
    }

    struct CoinAllowanceDebited has copy, drop {
        wallet_id: 0x2::object::ID,
        spender: address,
        coin: 0x1::type_name::TypeName,
        amount: u64,
        remaining: u64,
    }

    fun borrow(arg0: &0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet) : &Delegate {
        let v0 = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::uid(arg0);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(v0, b"delegate"), 1);
        0x2::dynamic_field::borrow<vector<u8>, Delegate>(v0, b"delegate")
    }

    fun borrow_mut(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet) : &mut Delegate {
        let v0 = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::uid_mut(arg0);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(v0, b"delegate"), 1);
        0x2::dynamic_field::borrow_mut<vector<u8>, Delegate>(v0, b"delegate")
    }

    public fun add(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::assert_owner(arg0, arg2);
        let v0 = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::id(arg0);
        let v1 = borrow_mut(arg0);
        assert!(arg1 != v1.main_owner, 11);
        assert!(!0x2::table::contains<address, Entry>(&v1.entries, arg1), 4);
        let v2 = Entry{
            by_service : 0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::new<0x1::type_name::TypeName, u64>(1024, arg2),
            by_coin    : 0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::new<0x1::type_name::TypeName, u64>(1024, arg2),
        };
        0x2::table::add<address, Entry>(&mut v1.entries, arg1, v2);
        let v3 = Added{
            wallet_id : v0,
            delegate  : arg1,
        };
        0x2::event::emit<Added>(v3);
    }

    public fun contains(arg0: &0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: address) : bool {
        if (!is_initialized(arg0)) {
            return false
        };
        0x2::table::contains<address, Entry>(&borrow(arg0).entries, arg1)
    }

    public fun remove(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::assert_owner(arg0, arg2);
        let v0 = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::id(arg0);
        let v1 = borrow_mut(arg0);
        assert!(0x2::table::contains<address, Entry>(&v1.entries, arg1), 3);
        let Entry {
            by_service : v2,
            by_coin    : v3,
        } = 0x2::table::remove<address, Entry>(&mut v1.entries, arg1);
        0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::completely_drop<0x1::type_name::TypeName, u64>(v2);
        0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::completely_drop<0x1::type_name::TypeName, u64>(v3);
        let v4 = Removed{
            wallet_id : v0,
            delegate  : arg1,
        };
        0x2::event::emit<Removed>(v4);
    }

    fun borrow_coin_mut(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: address) : &mut 0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::KeyedBigVector {
        let v0 = borrow_mut(arg0);
        assert!(arg1 != v0.main_owner, 11);
        assert!(0x2::table::contains<address, Entry>(&v0.entries, arg1), 3);
        &mut 0x2::table::borrow_mut<address, Entry>(&mut v0.entries, arg1).by_coin
    }

    fun borrow_service_mut(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: address) : &mut 0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::KeyedBigVector {
        let v0 = borrow_mut(arg0);
        assert!(arg1 != v0.main_owner, 11);
        assert!(0x2::table::contains<address, Entry>(&v0.entries, arg1), 3);
        &mut 0x2::table::borrow_mut<address, Entry>(&mut v0.entries, arg1).by_service
    }

    public fun coin_allowance<T0>(arg0: &0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: address) : u64 {
        if (!is_initialized(arg0)) {
            return 0
        };
        let v0 = borrow(arg0);
        if (arg1 == v0.main_owner) {
            return 18446744073709551615
        };
        if (!0x2::table::contains<address, Entry>(&v0.entries, arg1)) {
            return 0
        };
        let v1 = &0x2::table::borrow<address, Entry>(&v0.entries, arg1).by_coin;
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        if (0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::contains<0x1::type_name::TypeName>(v1, v2)) {
            *0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::borrow_by_key<0x1::type_name::TypeName, u64>(v1, v2)
        } else {
            0
        }
    }

    public fun coin_count(arg0: &0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: address) : u64 {
        let v0 = borrow(arg0);
        assert!(0x2::table::contains<address, Entry>(&v0.entries, arg1), 3);
        0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::length(&0x2::table::borrow<address, Entry>(&v0.entries, arg1).by_coin)
    }

    public(friend) fun debit_coin_allowance<T0>(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: address, arg2: u64) {
        let v0 = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::id(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = borrow_mut(arg0);
        if (arg1 == v2.main_owner) {
            let v3 = CoinAllowanceDebited{
                wallet_id : v0,
                spender   : arg1,
                coin      : v1,
                amount    : arg2,
                remaining : 18446744073709551615,
            };
            0x2::event::emit<CoinAllowanceDebited>(v3);
            return
        };
        assert!(0x2::table::contains<address, Entry>(&v2.entries, arg1), 9);
        let v4 = &mut 0x2::table::borrow_mut<address, Entry>(&mut v2.entries, arg1).by_coin;
        assert!(0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::contains<0x1::type_name::TypeName>(v4, v1), 6);
        let v5 = 0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::borrow_by_key_mut<0x1::type_name::TypeName, u64>(v4, v1);
        assert!(*v5 >= arg2, 8);
        *v5 = *v5 - arg2;
        let v6 = CoinAllowanceDebited{
            wallet_id : v0,
            spender   : arg1,
            coin      : v1,
            amount    : arg2,
            remaining : *v5,
        };
        0x2::event::emit<CoinAllowanceDebited>(v6);
    }

    public(friend) fun debit_service_allowance<T0>(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: address, arg2: u64) {
        let v0 = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::id(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = borrow_mut(arg0);
        if (arg1 == v2.main_owner) {
            let v3 = ServiceAllowanceDebited{
                wallet_id : v0,
                spender   : arg1,
                service   : v1,
                amount    : arg2,
                remaining : 18446744073709551615,
            };
            0x2::event::emit<ServiceAllowanceDebited>(v3);
            return
        };
        assert!(0x2::table::contains<address, Entry>(&v2.entries, arg1), 9);
        let v4 = &mut 0x2::table::borrow_mut<address, Entry>(&mut v2.entries, arg1).by_service;
        assert!(0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::contains<0x1::type_name::TypeName>(v4, v1), 5);
        let v5 = 0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::borrow_by_key_mut<0x1::type_name::TypeName, u64>(v4, v1);
        assert!(*v5 >= arg2, 7);
        *v5 = *v5 - arg2;
        let v6 = ServiceAllowanceDebited{
            wallet_id : v0,
            spender   : arg1,
            service   : v1,
            amount    : arg2,
            remaining : *v5,
        };
        0x2::event::emit<ServiceAllowanceDebited>(v6);
    }

    public fun decrease_coin_allowance<T0>(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::assert_owner(arg0, arg3);
        let v0 = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::id(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = borrow_coin_mut(arg0, arg1);
        assert!(0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::contains<0x1::type_name::TypeName>(v2, v1), 6);
        let v3 = 0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::borrow_by_key_mut<0x1::type_name::TypeName, u64>(v2, v1);
        assert!(*v3 >= arg2, 8);
        *v3 = *v3 - arg2;
        let v4 = CoinAllowanceChanged{
            wallet_id  : v0,
            delegate   : arg1,
            coin       : v1,
            new_amount : *v3,
        };
        0x2::event::emit<CoinAllowanceChanged>(v4);
    }

    public fun decrease_service_allowance<T0>(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::assert_owner(arg0, arg3);
        let v0 = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::id(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = borrow_service_mut(arg0, arg1);
        assert!(0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::contains<0x1::type_name::TypeName>(v2, v1), 5);
        let v3 = 0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::borrow_by_key_mut<0x1::type_name::TypeName, u64>(v2, v1);
        assert!(*v3 >= arg2, 7);
        *v3 = *v3 - arg2;
        let v4 = ServiceAllowanceChanged{
            wallet_id  : v0,
            delegate   : arg1,
            service    : v1,
            new_amount : *v3,
        };
        0x2::event::emit<ServiceAllowanceChanged>(v4);
    }

    public fun increase_coin_allowance<T0>(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::assert_owner(arg0, arg3);
        let v0 = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::id(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = borrow_coin_mut(arg0, arg1);
        let v3 = if (0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::contains<0x1::type_name::TypeName>(v2, v1)) {
            let v4 = 0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::borrow_by_key_mut<0x1::type_name::TypeName, u64>(v2, v1);
            *v4 = *v4 + arg2;
            *v4
        } else {
            0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::push_back<0x1::type_name::TypeName, u64>(v2, v1, arg2);
            arg2
        };
        let v5 = CoinAllowanceChanged{
            wallet_id  : v0,
            delegate   : arg1,
            coin       : v1,
            new_amount : v3,
        };
        0x2::event::emit<CoinAllowanceChanged>(v5);
    }

    public fun increase_service_allowance<T0>(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::assert_owner(arg0, arg3);
        let v0 = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::id(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = borrow_service_mut(arg0, arg1);
        let v3 = if (0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::contains<0x1::type_name::TypeName>(v2, v1)) {
            let v4 = 0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::borrow_by_key_mut<0x1::type_name::TypeName, u64>(v2, v1);
            *v4 = *v4 + arg2;
            *v4
        } else {
            0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::push_back<0x1::type_name::TypeName, u64>(v2, v1, arg2);
            arg2
        };
        let v5 = ServiceAllowanceChanged{
            wallet_id  : v0,
            delegate   : arg1,
            service    : v1,
            new_amount : v3,
        };
        0x2::event::emit<ServiceAllowanceChanged>(v5);
    }

    public fun initialize(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: &mut 0x2::tx_context::TxContext) {
        0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::assert_owner(arg0, arg1);
        let v0 = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::owner(arg0);
        let v1 = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::uid_mut(arg0);
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(v1, b"delegate"), 2);
        let v2 = Delegate{
            main_owner : v0,
            entries    : 0x2::table::new<address, Entry>(arg1),
        };
        0x2::dynamic_field::add<vector<u8>, Delegate>(v1, b"delegate", v2);
        let v3 = Initialized{
            wallet_id  : 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::id(arg0),
            main_owner : v0,
        };
        0x2::event::emit<Initialized>(v3);
    }

    public fun is_initialized(arg0: &0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet) : bool {
        0x2::dynamic_field::exists_<vector<u8>>(0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::uid(arg0), b"delegate")
    }

    public fun main_owner(arg0: &0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet) : address {
        borrow(arg0).main_owner
    }

    public fun service_allowance<T0>(arg0: &0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: address) : u64 {
        if (!is_initialized(arg0)) {
            return 0
        };
        let v0 = borrow(arg0);
        if (arg1 == v0.main_owner) {
            return 18446744073709551615
        };
        if (!0x2::table::contains<address, Entry>(&v0.entries, arg1)) {
            return 0
        };
        let v1 = &0x2::table::borrow<address, Entry>(&v0.entries, arg1).by_service;
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        if (0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::contains<0x1::type_name::TypeName>(v1, v2)) {
            *0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::borrow_by_key<0x1::type_name::TypeName, u64>(v1, v2)
        } else {
            0
        }
    }

    public fun service_count(arg0: &0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: address) : u64 {
        let v0 = borrow(arg0);
        assert!(0x2::table::contains<address, Entry>(&v0.entries, arg1), 3);
        0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::length(&0x2::table::borrow<address, Entry>(&v0.entries, arg1).by_service)
    }

    public fun set_coin_allowance<T0>(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::assert_owner(arg0, arg3);
        let v0 = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::id(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = borrow_coin_mut(arg0, arg1);
        if (0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::contains<0x1::type_name::TypeName>(v2, v1)) {
            *0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::borrow_by_key_mut<0x1::type_name::TypeName, u64>(v2, v1) = arg2;
        } else {
            0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::push_back<0x1::type_name::TypeName, u64>(v2, v1, arg2);
        };
        let v3 = CoinAllowanceChanged{
            wallet_id  : v0,
            delegate   : arg1,
            coin       : v1,
            new_amount : arg2,
        };
        0x2::event::emit<CoinAllowanceChanged>(v3);
    }

    public fun set_service_allowance<T0>(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::assert_owner(arg0, arg3);
        let v0 = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::id(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = borrow_service_mut(arg0, arg1);
        if (0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::contains<0x1::type_name::TypeName>(v2, v1)) {
            *0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::borrow_by_key_mut<0x1::type_name::TypeName, u64>(v2, v1) = arg2;
        } else {
            0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::key_bigvector::push_back<0x1::type_name::TypeName, u64>(v2, v1, arg2);
        };
        let v3 = ServiceAllowanceChanged{
            wallet_id  : v0,
            delegate   : arg1,
            service    : v1,
            new_amount : arg2,
        };
        0x2::event::emit<ServiceAllowanceChanged>(v3);
    }

    public fun spend<T0, T1>(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::is_authorized<T0, T1>(arg0), 10);
        let v0 = 0x2::tx_context::sender(arg3);
        debit_service_allowance<T0>(arg0, v0, arg1);
        debit_coin_allowance<T1>(arg0, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::pay_by_service<T0, T1>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v7
}

