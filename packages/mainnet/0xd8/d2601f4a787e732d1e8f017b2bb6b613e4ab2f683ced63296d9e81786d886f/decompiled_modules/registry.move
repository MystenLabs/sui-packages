module 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::registry {
    struct BankKey has copy, drop, store {
        lending_market_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
    }

    struct PoolKey has copy, drop, store {
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
    }

    struct FeeReceiversKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FeeReceivers has store {
        receivers: vector<address>,
        weights: vector<u64>,
        total_weight: u64,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        version: 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::version::Version,
        banks: 0x2::bag::Bag,
        pools: 0x2::bag::Bag,
    }

    struct BankData has store {
        bank_id: 0x2::object::ID,
        btoken_type: 0x1::type_name::TypeName,
        lending_market_type: 0x1::type_name::TypeName,
    }

    struct PoolData has copy, drop, store {
        pool_id: 0x2::object::ID,
        quoter_type: 0x1::type_name::TypeName,
        swap_fee_bps: u64,
        lp_token_type: 0x1::type_name::TypeName,
    }

    public(friend) fun btoken_type(arg0: &BankData) : 0x1::type_name::TypeName {
        arg0.btoken_type
    }

    public fun fee_receivers(arg0: &FeeReceivers) : &vector<address> {
        &arg0.receivers
    }

    public fun fee_total_weight(arg0: &FeeReceivers) : u64 {
        arg0.total_weight
    }

    public fun fee_weights(arg0: &FeeReceivers) : &vector<u64> {
        &arg0.weights
    }

    public(friend) fun get_bank_data<T0>(arg0: &Registry, arg1: 0x2::object::ID) : &BankData {
        let v0 = BankKey{
            lending_market_id : arg1,
            coin_type         : 0x1::type_name::get<T0>(),
        };
        0x2::bag::borrow<BankKey, BankData>(&arg0.banks, v0)
    }

    public fun get_fee_receivers(arg0: &Registry) : &FeeReceivers {
        let v0 = FeeReceiversKey{dummy_field: false};
        0x2::dynamic_field::borrow<FeeReceiversKey, FeeReceivers>(&arg0.id, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id      : 0x2::object::new(arg0),
            version : 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::version::new(1),
            banks   : 0x2::bag::new(arg0),
            pools   : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    entry fun migrate(arg0: &mut Registry, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::global_admin::GlobalAdmin) {
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::version::migrate_(&mut arg0.version, 1);
    }

    public(friend) fun register_bank(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName, arg4: 0x2::object::ID, arg5: 0x1::type_name::TypeName) {
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::version::assert_version_and_upgrade(&mut arg0.version, 1);
        let v0 = BankKey{
            lending_market_id : arg4,
            coin_type         : arg2,
        };
        assert!(!0x2::bag::contains<BankKey>(&arg0.banks, v0), 1);
        let v1 = BankData{
            bank_id             : arg1,
            btoken_type         : arg3,
            lending_market_type : arg5,
        };
        0x2::bag::add<BankKey, BankData>(&mut arg0.banks, v0, v1);
    }

    public(friend) fun register_pool(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName, arg4: 0x1::type_name::TypeName, arg5: u64, arg6: 0x1::type_name::TypeName) {
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::version::assert_version_and_upgrade(&mut arg0.version, 1);
        let v0 = PoolKey{
            coin_type_a : arg2,
            coin_type_b : arg3,
        };
        if (!0x2::bag::contains<PoolKey>(&arg0.pools, v0)) {
            0x2::bag::add<PoolKey, 0x2::vec_set::VecSet<PoolData>>(&mut arg0.pools, v0, 0x2::vec_set::empty<PoolData>());
        };
        let v1 = PoolData{
            pool_id       : arg1,
            quoter_type   : arg6,
            swap_fee_bps  : arg5,
            lp_token_type : arg4,
        };
        0x2::vec_set::insert<PoolData>(0x2::bag::borrow_mut<PoolKey, 0x2::vec_set::VecSet<PoolData>>(&mut arg0.pools, v0), v1);
    }

    public fun set_fee_receivers(arg0: &mut Registry, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::global_admin::GlobalAdmin, arg2: vector<address>, arg3: vector<u64>) {
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::version::assert_version_and_upgrade(&mut arg0.version, 1);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 2);
        assert!(0x1::vector::length<address>(&arg2) > 0, 2);
        let v0 = 0;
        0x1::vector::reverse<u64>(&mut arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg3)) {
            v0 = v0 + 0x1::vector::pop_back<u64>(&mut arg3);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg3);
        assert!(v0 > 0, 2);
        let v2 = FeeReceiversKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<FeeReceiversKey>(&arg0.id, v2)) {
            let v3 = FeeReceiversKey{dummy_field: false};
            let FeeReceivers {
                receivers    : _,
                weights      : _,
                total_weight : _,
            } = 0x2::dynamic_field::remove<FeeReceiversKey, FeeReceivers>(&mut arg0.id, v3);
        };
        let v7 = FeeReceiversKey{dummy_field: false};
        let v8 = FeeReceivers{
            receivers    : arg2,
            weights      : arg3,
            total_weight : v0,
        };
        0x2::dynamic_field::add<FeeReceiversKey, FeeReceivers>(&mut arg0.id, v7, v8);
    }

    // decompiled from Move bytecode v6
}

