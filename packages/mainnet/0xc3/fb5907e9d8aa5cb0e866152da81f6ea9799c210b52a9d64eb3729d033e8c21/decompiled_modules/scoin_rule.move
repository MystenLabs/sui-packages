module 0xe8e2e65d77e92fee59b9027ad0e29da5d932c6a5fb46c9d4eecbcc747e33d38a::scoin_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct SCoinPair has copy, drop, store {
        scoin_type: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
    }

    struct Config has key {
        id: 0x2::object::UID,
        scoin_pairs: 0x2::vec_set::VecSet<SCoinPair>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun add_scoin_pair<T0, T1>(arg0: &mut Config, arg1: &AdminCap) {
        0x2::vec_set::insert<SCoinPair>(&mut arg0.scoin_pairs, new_scoin_pair<T0, T1>());
    }

    fun err_invalid_scoin_type_inputs() {
        abort 0
    }

    public fun exists_pair<T0, T1>(arg0: &Config) : bool {
        let v0 = new_scoin_pair<T0, T1>();
        0x2::vec_set::contains<SCoinPair>(&arg0.scoin_pairs, &v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id          : 0x2::object::new(arg0),
            scoin_pairs : 0x2::vec_set::empty<SCoinPair>(),
        };
        0x2::transfer::share_object<Config>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun new_scoin_pair<T0, T1>() : SCoinPair {
        SCoinPair{
            scoin_type : 0x1::type_name::get<T0>(),
            coin_type  : 0x1::type_name::get<T1>(),
        }
    }

    public fun remove_scoin_pair<T0, T1>(arg0: &mut Config, arg1: &AdminCap) {
        let v0 = new_scoin_pair<T0, T1>();
        0x2::vec_set::remove<SCoinPair>(&mut arg0.scoin_pairs, &v0);
    }

    public fun update_price<T0, T1>(arg0: &Config, arg1: &mut 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock) {
        if (!exists_pair<T0, T1>(arg0)) {
            err_invalid_scoin_type_inputs();
        };
        let (v0, v1) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<T1>(arg1, arg4);
        let v2 = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::borrow_single_oracle_mut<T0>(arg1);
        let v3 = Rule{dummy_field: false};
        0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::update_oracle_price_with_rule<T0, Rule>(v2, v3, arg4, (((0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::precision<T0>(v2) as u128) * (v0 as u128) / (0xe8e2e65d77e92fee59b9027ad0e29da5d932c6a5fb46c9d4eecbcc747e33d38a::utils::calc_coin_to_scoin(arg2, arg3, 0x1::type_name::get<T1>(), arg4, v1) as u128)) as u64));
    }

    // decompiled from Move bytecode v6
}

