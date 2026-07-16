module 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::delegate {
    struct Entry has store {
        by_service: 0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::KeyedBigVector,
        by_coin: 0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::KeyedBigVector,
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

    fun borrow(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet) : &Delegate {
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::uid(arg0);
        assert!(0x2::dynamic_field::exists<vector<u8>>(v0, b"delegate"), 1);
        0x2::dynamic_field::borrow<vector<u8>, Delegate>(v0, b"delegate")
    }

    fun borrow_mut(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet) : &mut Delegate {
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::uid_mut(arg0);
        assert!(0x2::dynamic_field::exists<vector<u8>>(v0, b"delegate"), 1);
        0x2::dynamic_field::borrow_mut<vector<u8>, Delegate>(v0, b"delegate")
    }

    public fun add(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::assert_owner(arg0, arg2);
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0);
        let v1 = borrow_mut(arg0);
        assert!(arg1 != v1.main_owner, 11);
        assert!(!0x2::table::contains<address, Entry>(&v1.entries, arg1), 4);
        let v2 = Entry{
            by_service : 0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::new<0x1::type_name::TypeName, u64>(1024, arg2),
            by_coin    : 0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::new<0x1::type_name::TypeName, u64>(1024, arg2),
        };
        0x2::table::add<address, Entry>(&mut v1.entries, arg1, v2);
        let v3 = Added{
            wallet_id : v0,
            delegate  : arg1,
        };
        0x2::event::emit<Added>(v3);
    }

    public fun contains(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: address) : bool {
        if (!is_initialized(arg0)) {
            return false
        };
        0x2::table::contains<address, Entry>(&borrow(arg0).entries, arg1)
    }

    public fun remove(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::assert_owner(arg0, arg2);
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0);
        let v1 = borrow_mut(arg0);
        assert!(0x2::table::contains<address, Entry>(&v1.entries, arg1), 3);
        let Entry {
            by_service : v2,
            by_coin    : v3,
        } = 0x2::table::remove<address, Entry>(&mut v1.entries, arg1);
        0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::completely_drop<0x1::type_name::TypeName, u64>(v2);
        0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::completely_drop<0x1::type_name::TypeName, u64>(v3);
        let v4 = Removed{
            wallet_id : v0,
            delegate  : arg1,
        };
        0x2::event::emit<Removed>(v4);
    }

    public fun any_coin_allowance(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: address) : u64 {
        coin_allowance<0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::AnyCoin>(arg0, arg1)
    }

    fun borrow_coin_mut(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: address) : &mut 0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::KeyedBigVector {
        let v0 = borrow_mut(arg0);
        assert!(arg1 != v0.main_owner, 11);
        assert!(0x2::table::contains<address, Entry>(&v0.entries, arg1), 3);
        &mut 0x2::table::borrow_mut<address, Entry>(&mut v0.entries, arg1).by_coin
    }

    fun borrow_service_mut(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: address) : &mut 0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::KeyedBigVector {
        let v0 = borrow_mut(arg0);
        assert!(arg1 != v0.main_owner, 11);
        assert!(0x2::table::contains<address, Entry>(&v0.entries, arg1), 3);
        &mut 0x2::table::borrow_mut<address, Entry>(&mut v0.entries, arg1).by_service
    }

    public fun coin_allowance<T0>(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: address) : u64 {
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
        if (0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::contains<0x1::type_name::TypeName>(v1, v2)) {
            return *0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::borrow_by_key<0x1::type_name::TypeName, u64>(v1, v2)
        };
        let v3 = 0x1::type_name::with_defining_ids<0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::AnyCoin>();
        if (0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::contains<0x1::type_name::TypeName>(v1, v3)) {
            *0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::borrow_by_key<0x1::type_name::TypeName, u64>(v1, v3)
        } else {
            0
        }
    }

    public fun coin_count(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: address) : u64 {
        let v0 = borrow(arg0);
        assert!(0x2::table::contains<address, Entry>(&v0.entries, arg1), 3);
        0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::length(&0x2::table::borrow<address, Entry>(&v0.entries, arg1).by_coin)
    }

    public(friend) fun debit_coin_allowance<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: address, arg2: u64) {
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0);
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
        let v5 = if (0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::contains<0x1::type_name::TypeName>(v4, v1)) {
            v1
        } else {
            let v6 = 0x1::type_name::with_defining_ids<0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::AnyCoin>();
            assert!(0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::contains<0x1::type_name::TypeName>(v4, v6), 6);
            v6
        };
        let v7 = 0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::borrow_by_key_mut<0x1::type_name::TypeName, u64>(v4, v5);
        if (*v7 == 18446744073709551615) {
            let v8 = CoinAllowanceDebited{
                wallet_id : v0,
                spender   : arg1,
                coin      : v5,
                amount    : arg2,
                remaining : 18446744073709551615,
            };
            0x2::event::emit<CoinAllowanceDebited>(v8);
            return
        };
        assert!(*v7 >= arg2, 8);
        *v7 = *v7 - arg2;
        let v9 = CoinAllowanceDebited{
            wallet_id : v0,
            spender   : arg1,
            coin      : v5,
            amount    : arg2,
            remaining : *v7,
        };
        0x2::event::emit<CoinAllowanceDebited>(v9);
    }

    public(friend) fun debit_service_allowance<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: address, arg2: u64) {
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0);
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
        assert!(0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::contains<0x1::type_name::TypeName>(v4, v1), 5);
        let v5 = 0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::borrow_by_key_mut<0x1::type_name::TypeName, u64>(v4, v1);
        if (*v5 == 18446744073709551615) {
            let v6 = ServiceAllowanceDebited{
                wallet_id : v0,
                spender   : arg1,
                service   : v1,
                amount    : arg2,
                remaining : 18446744073709551615,
            };
            0x2::event::emit<ServiceAllowanceDebited>(v6);
            return
        };
        assert!(*v5 >= arg2, 7);
        *v5 = *v5 - arg2;
        let v7 = ServiceAllowanceDebited{
            wallet_id : v0,
            spender   : arg1,
            service   : v1,
            amount    : arg2,
            remaining : *v5,
        };
        0x2::event::emit<ServiceAllowanceDebited>(v7);
    }

    public fun decrease_any_coin_allowance(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        decrease_coin_allowance<0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::AnyCoin>(arg0, arg1, arg2, arg3);
    }

    public fun decrease_coin_allowance<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::assert_owner(arg0, arg3);
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = borrow_coin_mut(arg0, arg1);
        assert!(0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::contains<0x1::type_name::TypeName>(v2, v1), 6);
        let v3 = 0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::borrow_by_key_mut<0x1::type_name::TypeName, u64>(v2, v1);
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

    public fun decrease_service_allowance<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::assert_owner(arg0, arg3);
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = borrow_service_mut(arg0, arg1);
        assert!(0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::contains<0x1::type_name::TypeName>(v2, v1), 5);
        let v3 = 0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::borrow_by_key_mut<0x1::type_name::TypeName, u64>(v2, v1);
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

    public fun increase_any_coin_allowance(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        increase_coin_allowance<0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::AnyCoin>(arg0, arg1, arg2, arg3);
    }

    public fun increase_coin_allowance<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::assert_owner(arg0, arg3);
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = borrow_coin_mut(arg0, arg1);
        let v3 = if (0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::contains<0x1::type_name::TypeName>(v2, v1)) {
            let v4 = 0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::borrow_by_key_mut<0x1::type_name::TypeName, u64>(v2, v1);
            *v4 = *v4 + arg2;
            *v4
        } else {
            0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::push_back<0x1::type_name::TypeName, u64>(v2, v1, arg2);
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

    public fun increase_service_allowance<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::assert_owner(arg0, arg3);
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = borrow_service_mut(arg0, arg1);
        let v3 = if (0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::contains<0x1::type_name::TypeName>(v2, v1)) {
            let v4 = 0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::borrow_by_key_mut<0x1::type_name::TypeName, u64>(v2, v1);
            *v4 = *v4 + arg2;
            *v4
        } else {
            0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::push_back<0x1::type_name::TypeName, u64>(v2, v1, arg2);
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

    public fun initialize(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &mut 0x2::tx_context::TxContext) {
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::assert_owner(arg0, arg1);
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::owner(arg0);
        let v1 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::uid_mut(arg0);
        assert!(!0x2::dynamic_field::exists<vector<u8>>(v1, b"delegate"), 2);
        let v2 = Delegate{
            main_owner : v0,
            entries    : 0x2::table::new<address, Entry>(arg1),
        };
        0x2::dynamic_field::add<vector<u8>, Delegate>(v1, b"delegate", v2);
        let v3 = Initialized{
            wallet_id  : 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0),
            main_owner : v0,
        };
        0x2::event::emit<Initialized>(v3);
    }

    public fun is_initialized(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet) : bool {
        0x2::dynamic_field::exists<vector<u8>>(0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::uid(arg0), b"delegate")
    }

    public fun is_service_authorized<T0>(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: address) : bool {
        if (!is_initialized(arg0)) {
            return false
        };
        let v0 = borrow(arg0);
        if (arg1 == v0.main_owner) {
            return true
        };
        if (!0x2::table::contains<address, Entry>(&v0.entries, arg1)) {
            return false
        };
        0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::contains<0x1::type_name::TypeName>(&0x2::table::borrow<address, Entry>(&v0.entries, arg1).by_service, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun main_owner(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet) : address {
        borrow(arg0).main_owner
    }

    public fun service_allowance<T0>(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: address) : u64 {
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
        if (0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::contains<0x1::type_name::TypeName>(v1, v2)) {
            return *0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::borrow_by_key<0x1::type_name::TypeName, u64>(v1, v2)
        };
        0
    }

    public fun service_count(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: address) : u64 {
        let v0 = borrow(arg0);
        assert!(0x2::table::contains<address, Entry>(&v0.entries, arg1), 3);
        0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::length(&0x2::table::borrow<address, Entry>(&v0.entries, arg1).by_service)
    }

    public fun set_any_coin_allowance(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        set_coin_allowance<0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::AnyCoin>(arg0, arg1, arg2, arg3);
    }

    public fun set_any_coin_unlimited_allowance(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: address, arg2: &0x2::tx_context::TxContext) {
        set_any_coin_allowance(arg0, arg1, 18446744073709551615, arg2);
    }

    public fun set_coin_allowance<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::assert_owner(arg0, arg3);
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = borrow_coin_mut(arg0, arg1);
        if (0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::contains<0x1::type_name::TypeName>(v2, v1)) {
            *0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::borrow_by_key_mut<0x1::type_name::TypeName, u64>(v2, v1) = arg2;
        } else {
            0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::push_back<0x1::type_name::TypeName, u64>(v2, v1, arg2);
        };
        let v3 = CoinAllowanceChanged{
            wallet_id  : v0,
            delegate   : arg1,
            coin       : v1,
            new_amount : arg2,
        };
        0x2::event::emit<CoinAllowanceChanged>(v3);
    }

    public fun set_coin_unlimited_allowance<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: address, arg2: &0x2::tx_context::TxContext) {
        set_coin_allowance<T0>(arg0, arg1, 18446744073709551615, arg2);
    }

    public fun set_service_allowance<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::assert_owner(arg0, arg3);
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = borrow_service_mut(arg0, arg1);
        if (0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::contains<0x1::type_name::TypeName>(v2, v1)) {
            *0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::borrow_by_key_mut<0x1::type_name::TypeName, u64>(v2, v1) = arg2;
        } else {
            0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::key_bigvector::push_back<0x1::type_name::TypeName, u64>(v2, v1, arg2);
        };
        let v3 = ServiceAllowanceChanged{
            wallet_id  : v0,
            delegate   : arg1,
            service    : v1,
            new_amount : arg2,
        };
        0x2::event::emit<ServiceAllowanceChanged>(v3);
    }

    public fun set_service_unlimited_allowance<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: address, arg2: &0x2::tx_context::TxContext) {
        set_service_allowance<T0>(arg0, arg1, 18446744073709551615, arg2);
    }

    public fun set_unlimited_allowance<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: address, arg2: &0x2::tx_context::TxContext) {
        set_service_allowance<T0>(arg0, arg1, 18446744073709551615, arg2);
        set_any_coin_allowance(arg0, arg1, 18446744073709551615, arg2);
    }

    public fun spend<T0: drop, T1>(arg0: T0, arg1: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::is_authorized<T0, T1>(arg1), 10);
        let v0 = 0x2::tx_context::sender(arg4);
        debit_service_allowance<T0>(arg1, v0, arg2);
        debit_coin_allowance<T1>(arg1, v0, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::pay_by_service<T0, T1>(arg1, arg2, arg4), arg3);
    }

    public fun unlimited_allowance() : u64 {
        18446744073709551615
    }

    // decompiled from Move bytecode v7
}

