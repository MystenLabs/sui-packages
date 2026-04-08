module 0xbdde58944fd9bc54b2e5a5399550c7748e294bfcb7a5da05208bd4a3fc173d90::batcher {
    struct BatchPool has key {
        id: 0x2::object::UID,
        transactions: 0x2::table::Table<0x1::ascii::String, BundleConfig>,
        version: u8,
    }

    struct BundleConfig has store {
        owner: address,
        bundler: address,
        status: u8,
        settlement_a: address,
        settlement_b: address,
        bundle_ratio: u8,
        transactions: 0x2::table::Table<0x2::object::ID, TxMeta>,
    }

    struct TxMeta has copy, drop, store {
        tx_type: 0x1::ascii::String,
        gas_limit: u64,
        bundled: bool,
    }

    struct BundleCreated has copy, drop {
        bundle_id: 0x1::ascii::String,
        owner: address,
    }

    struct TxAdded has copy, drop {
        bundle_id: 0x1::ascii::String,
        tx_id: 0x2::object::ID,
        tx_type: 0x1::ascii::String,
        gas_limit: u64,
    }

    struct SettlementCompleted has copy, drop {
        bundle_id: 0x1::ascii::String,
        tx_id: 0x2::object::ID,
        result_gas_limit: u64,
    }

    public entry fun add_transaction(arg0: &mut BatchPool, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x1::ascii::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, BundleConfig>(&arg0.transactions, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, BundleConfig>(&mut arg0.transactions, arg1);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.owner || v1 == v0.bundler, 100);
        let v2 = TxMeta{
            tx_type   : arg3,
            gas_limit : arg4,
            bundled   : false,
        };
        if (0x2::table::contains<0x2::object::ID, TxMeta>(&v0.transactions, arg2)) {
            *0x2::table::borrow_mut<0x2::object::ID, TxMeta>(&mut v0.transactions, arg2) = v2;
        } else {
            0x2::table::add<0x2::object::ID, TxMeta>(&mut v0.transactions, arg2, v2);
        };
        let v3 = TxAdded{
            bundle_id : arg1,
            tx_id     : arg2,
            tx_type   : arg3,
            gas_limit : arg4,
        };
        0x2::event::emit<TxAdded>(v3);
    }

    public fun archive_tx(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut BatchPool, arg2: 0x1::ascii::String, arg3: 0x2::object::ID, arg4: 0x3::staking_pool::StakedSui, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, BundleConfig>(&arg1.transactions, arg2), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, BundleConfig>(&mut arg1.transactions, arg2);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.bundler, 100);
        if (!(v0.status & 1 != 0)) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v1);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, TxMeta>(&v0.transactions, arg3)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, TxMeta>(&v0.transactions, arg3);
            !v3.bundled && v3.gas_limit > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v1);
            return
        };
        if (0x2::table::contains<0x2::object::ID, TxMeta>(&v0.transactions, arg3)) {
            0x2::table::borrow_mut<0x2::object::ID, TxMeta>(&mut v0.transactions, arg3).bundled = true;
        };
        let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg0, arg4, arg5), arg5);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&v4);
        let v6 = v5 * (v0.bundle_ratio as u64) / 100;
        if (v6 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.settlement_b);
        } else if (v6 == v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.settlement_a);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v4, v6, arg5), v0.settlement_a);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.settlement_b);
        };
        let v7 = SettlementCompleted{
            bundle_id        : arg2,
            tx_id            : arg3,
            result_gas_limit : v5,
        };
        0x2::event::emit<SettlementCompleted>(v7);
    }

    public entry fun create_bundle(arg0: &mut BatchPool, arg1: 0x1::ascii::String, arg2: address, arg3: address, arg4: address, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 <= 100, 106);
        let v0 = BundleConfig{
            owner        : 0x2::tx_context::sender(arg6),
            bundler      : arg2,
            status       : 0,
            settlement_a : arg3,
            settlement_b : arg4,
            bundle_ratio : arg5,
            transactions : 0x2::table::new<0x2::object::ID, TxMeta>(arg6),
        };
        0x2::table::add<0x1::ascii::String, BundleConfig>(&mut arg0.transactions, arg1, v0);
        let v1 = BundleCreated{
            bundle_id : arg1,
            owner     : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<BundleCreated>(v1);
    }

    public fun execute_tx<T0: store + key>(arg0: &mut BatchPool, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, BundleConfig>(&arg0.transactions, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, BundleConfig>(&mut arg0.transactions, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.bundler, 100);
        if (!(v0.status & 1 != 0)) {
            0x2::transfer::public_transfer<T0>(arg3, v1);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, TxMeta>(&v0.transactions, arg2)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, TxMeta>(&v0.transactions, arg2);
            !v3.bundled && v3.gas_limit > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<T0>(arg3, v1);
            return
        };
        if (0x2::table::contains<0x2::object::ID, TxMeta>(&v0.transactions, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, TxMeta>(&mut v0.transactions, arg2).bundled = true;
        };
        0x2::transfer::public_transfer<T0>(arg3, v0.settlement_a);
        let v4 = SettlementCompleted{
            bundle_id        : arg1,
            tx_id            : arg2,
            result_gas_limit : 1,
        };
        0x2::event::emit<SettlementCompleted>(v4);
    }

    public fun get_bundle_info(arg0: &BatchPool, arg1: 0x1::ascii::String) : (address, address, bool, address, address, u8) {
        assert!(0x2::table::contains<0x1::ascii::String, BundleConfig>(&arg0.transactions, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, BundleConfig>(&arg0.transactions, arg1);
        (v0.owner, v0.bundler, v0.status & 1 != 0, v0.settlement_a, v0.settlement_b, v0.bundle_ratio)
    }

    public fun get_tx_gas_limit(arg0: &BatchPool, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : u64 {
        assert!(0x2::table::contains<0x1::ascii::String, BundleConfig>(&arg0.transactions, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, BundleConfig>(&arg0.transactions, arg1);
        if (v0.status & 1 == 0) {
            return 0
        };
        if (!0x2::table::contains<0x2::object::ID, TxMeta>(&v0.transactions, arg2)) {
            return 0
        };
        let v1 = 0x2::table::borrow<0x2::object::ID, TxMeta>(&v0.transactions, arg2);
        if (v1.bundled) {
            return 0
        };
        v1.gas_limit
    }

    public fun get_tx_info(arg0: &BatchPool, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : (0x1::ascii::String, u64, bool) {
        assert!(0x2::table::contains<0x1::ascii::String, BundleConfig>(&arg0.transactions, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, BundleConfig>(&arg0.transactions, arg1);
        assert!(0x2::table::contains<0x2::object::ID, TxMeta>(&v0.transactions, arg2), 102);
        let v1 = 0x2::table::borrow<0x2::object::ID, TxMeta>(&v0.transactions, arg2);
        (v1.tx_type, v1.gas_limit, v1.bundled)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BatchPool{
            id           : 0x2::object::new(arg0),
            transactions : 0x2::table::new<0x1::ascii::String, BundleConfig>(arg0),
            version      : 1,
        };
        0x2::transfer::share_object<BatchPool>(v0);
    }

    public entry fun seal_bundle(arg0: &mut BatchPool, arg1: 0x1::ascii::String, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, BundleConfig>(&arg0.transactions, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, BundleConfig>(&mut arg0.transactions, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.owner, 100);
        if (arg2) {
            v0.status = v0.status | 1;
        } else {
            v0.status = v0.status & (255 ^ 1);
        };
    }

    public fun settle_batch<T0>(arg0: &mut BatchPool, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, BundleConfig>(&arg0.transactions, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, BundleConfig>(&mut arg0.transactions, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.bundler, 100);
        let v2 = 0x2::coin::value<T0>(&arg3);
        if (v2 == 0 || !(v0.status & 1 != 0)) {
            if (v2 == 0) {
                0x2::coin::destroy_zero<T0>(arg3);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v1);
            };
            return
        };
        if (0x2::table::contains<0x2::object::ID, TxMeta>(&v0.transactions, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, TxMeta>(&mut v0.transactions, arg2).bundled = true;
        };
        let v3 = v2 * (v0.bundle_ratio as u64) / 100;
        if (v3 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.settlement_b);
        } else if (v3 == v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.settlement_a);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v3, arg4), v0.settlement_a);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.settlement_b);
        };
        let v4 = SettlementCompleted{
            bundle_id        : arg1,
            tx_id            : arg2,
            result_gas_limit : v2,
        };
        0x2::event::emit<SettlementCompleted>(v4);
    }

    public fun should_bundle(arg0: &BatchPool, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : bool {
        get_tx_gas_limit(arg0, arg1, arg2) > 0
    }

    public entry fun update_gas_limit(arg0: &mut BatchPool, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, BundleConfig>(&arg0.transactions, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, BundleConfig>(&mut arg0.transactions, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.owner || v1 == v0.bundler, 100);
        assert!(0x2::table::contains<0x2::object::ID, TxMeta>(&v0.transactions, arg2), 102);
        0x2::table::borrow_mut<0x2::object::ID, TxMeta>(&mut v0.transactions, arg2).gas_limit = arg3;
    }

    // decompiled from Move bytecode v6
}

