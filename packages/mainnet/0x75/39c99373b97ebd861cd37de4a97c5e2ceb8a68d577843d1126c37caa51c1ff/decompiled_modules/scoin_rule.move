module 0x7539c99373b97ebd861cd37de4a97c5e2ceb8a68d577843d1126c37caa51c1ff::scoin_rule {
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
            scoin_type : 0x1::type_name::with_defining_ids<T0>(),
            coin_type  : 0x1::type_name::with_defining_ids<T1>(),
        }
    }

    public fun remove_scoin_pair<T0, T1>(arg0: &mut Config, arg1: &AdminCap) {
        let v0 = new_scoin_pair<T0, T1>();
        0x2::vec_set::remove<SCoinPair>(&mut arg0.scoin_pairs, &v0);
    }

    public fun update_price<T0, T1>(arg0: &Config, arg1: &mut 0x49e7d33a8df46c0f450fd0219cd19b471bf42ce4f307197c61b45609a59c22d8::stingray_oracle::StingrayOracle, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock) {
        if (!exists_pair<T0, T1>(arg0)) {
            err_invalid_scoin_type_inputs();
        };
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = 0x49e7d33a8df46c0f450fd0219cd19b471bf42ce4f307197c61b45609a59c22d8::stingray_oracle::get_price(arg1, arg4, 0x1::type_name::into_string(v0));
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        let v3 = Rule{dummy_field: false};
        0x49e7d33a8df46c0f450fd0219cd19b471bf42ce4f307197c61b45609a59c22d8::oracle_aggregator::update_oracle_price_with_rule<Rule>(0x49e7d33a8df46c0f450fd0219cd19b471bf42ce4f307197c61b45609a59c22d8::stingray_oracle::borrow_oracle_aggregator_mut(arg1, 0x1::type_name::into_string(v2)), v3, arg4, (((0x1::u64::pow(10, 0x49e7d33a8df46c0f450fd0219cd19b471bf42ce4f307197c61b45609a59c22d8::stingray_oracle::get_decimal(arg1, 0x1::type_name::into_string(v2))) as u128) * (0x49e7d33a8df46c0f450fd0219cd19b471bf42ce4f307197c61b45609a59c22d8::oracle_aggregator::price(&v1) as u128) / (0x7539c99373b97ebd861cd37de4a97c5e2ceb8a68d577843d1126c37caa51c1ff::utils::calc_coin_to_scoin(arg2, arg3, v0, arg4, 0x1::u64::pow(10, 0x49e7d33a8df46c0f450fd0219cd19b471bf42ce4f307197c61b45609a59c22d8::oracle_aggregator::decimals(&v1))) as u128)) as u64));
    }

    // decompiled from Move bytecode v6
}

