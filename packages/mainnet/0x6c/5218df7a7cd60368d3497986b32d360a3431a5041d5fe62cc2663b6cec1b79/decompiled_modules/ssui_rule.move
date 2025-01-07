module 0x6c5218df7a7cd60368d3497986b32d360a3431a5041d5fe62cc2663b6cec1b79::ssui_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun sui_amount_to_lst_amount<T0>(arg0: &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg1: u64) : u64 {
        let v0 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_sui_supply<T0>(arg0);
        let v1 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_lst_supply<T0>(arg0);
        if (v0 == 0 || v1 == 0) {
            return arg1
        };
        (((v1 as u128) * (arg1 as u128) / (v0 as u128)) as u64)
    }

    public fun update_price<T0: drop>(arg0: &mut 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg1: &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg2: &0x2::clock::Clock) {
        let (v0, v1) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<0x2::sui::SUI>(arg0, arg2);
        let v2 = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::borrow_single_oracle_mut<T0>(arg0);
        let v3 = Rule{dummy_field: false};
        0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::update_oracle_price_with_rule<T0, Rule>(v2, v3, arg2, (((0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::precision<T0>(v2) as u128) * (v0 as u128) / (sui_amount_to_lst_amount<T0>(arg1, v1) as u128)) as u64));
    }

    // decompiled from Move bytecode v6
}

