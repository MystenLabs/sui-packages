module 0xbbc6f7baff99003dbd5aa90f46b5aa34a372e0559b3dc8ecbdae92956162a33f::getter {
    struct OracleInfo has copy, drop {
        oracle_id: u8,
        price: u256,
        decimals: u8,
        valid: bool,
    }

    struct UserStateInfo has copy, drop {
        asset_id: u8,
        borrow_balance: u256,
        supply_balance: u256,
    }

    struct ReserveDataInfo has copy, drop {
        id: u8,
        oracle_id: u8,
        coin_type: 0x1::ascii::String,
        supply_cap: u256,
        borrow_cap: u256,
        supply_rate: u256,
        borrow_rate: u256,
        supply_index: u256,
        borrow_index: u256,
        total_supply: u256,
        total_borrow: u256,
        last_update_at: u64,
        ltv: u256,
        treasury_factor: u256,
        treasury_balance: u256,
        base_rate: u256,
        multiplier: u256,
        jump_rate_multiplier: u256,
        reserve_factor: u256,
        optimal_utilization: u256,
        liquidation_ratio: u256,
        liquidation_bonus: u256,
        liquidation_threshold: u256,
    }

    public fun get_oracle_info(arg0: &0x2::clock::Clock, arg1: &0xe2e7f32c9b203878e79afcbc76d48552641727aae0c35142c7e51ab9efeb0c09::oracle::PriceOracle, arg2: vector<u8>) : vector<OracleInfo> {
        let v0 = 0x1::vector::empty<OracleInfo>();
        let v1 = 0x1::vector::length<u8>(&arg2);
        while (v1 > 0) {
            let v2 = 0x1::vector::borrow<u8>(&arg2, v1 - 1);
            let (v3, v4, v5) = 0xe2e7f32c9b203878e79afcbc76d48552641727aae0c35142c7e51ab9efeb0c09::oracle::get_token_price(arg0, arg1, *v2);
            let v6 = OracleInfo{
                oracle_id : *v2,
                price     : v4,
                decimals  : v5,
                valid     : v3,
            };
            0x1::vector::push_back<OracleInfo>(&mut v0, v6);
            v1 = v1 - 1;
        };
        v0
    }

    public fun get_reserve_data(arg0: &mut 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::storage::Storage) : vector<ReserveDataInfo> {
        let v0 = 0x1::vector::empty<ReserveDataInfo>();
        let v1 = 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::storage::get_reserves_count(arg0);
        while (v1 > 0) {
            let v2 = v1 - 1;
            let (v3, v4) = 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::storage::get_current_rate(arg0, v2);
            let (v5, v6) = 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::storage::get_index(arg0, v2);
            let (v7, v8) = 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::storage::get_total_supply(arg0, v2);
            let (v9, v10, v11, v12, v13) = 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::storage::get_borrow_rate_factors(arg0, v2);
            let (v14, v15, v16) = 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::storage::get_liquidation_factors(arg0, v2);
            let v17 = ReserveDataInfo{
                id                    : v2,
                oracle_id             : 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::storage::get_oracle_id(arg0, v2),
                coin_type             : 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::storage::get_coin_type(arg0, v2),
                supply_cap            : 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::storage::get_supply_cap_ceiling(arg0, v2),
                borrow_cap            : 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::storage::get_borrow_cap_ceiling_ratio(arg0, v2),
                supply_rate           : v3,
                borrow_rate           : v4,
                supply_index          : v5,
                borrow_index          : v6,
                total_supply          : v7,
                total_borrow          : v8,
                last_update_at        : 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::storage::get_last_update_timestamp(arg0, v2),
                ltv                   : 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::storage::get_asset_ltv(arg0, v2),
                treasury_factor       : 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::storage::get_treasury_factor(arg0, v2),
                treasury_balance      : 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::storage::get_treasury_balance(arg0, v2),
                base_rate             : v9,
                multiplier            : v10,
                jump_rate_multiplier  : v11,
                reserve_factor        : v12,
                optimal_utilization   : v13,
                liquidation_ratio     : v14,
                liquidation_bonus     : v15,
                liquidation_threshold : v16,
            };
            0x1::vector::push_back<ReserveDataInfo>(&mut v0, v17);
            v1 = v1 - 1;
        };
        v0
    }

    public fun get_user_state(arg0: &mut 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::storage::Storage, arg1: address) : vector<UserStateInfo> {
        let v0 = 0x1::vector::empty<UserStateInfo>();
        let v1 = 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::storage::get_reserves_count(arg0);
        while (v1 > 0) {
            let (v2, v3) = 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::storage::get_user_balance(arg0, v1 - 1, arg1);
            let v4 = UserStateInfo{
                asset_id       : v1 - 1,
                borrow_balance : v3,
                supply_balance : v2,
            };
            0x1::vector::push_back<UserStateInfo>(&mut v0, v4);
            v1 = v1 - 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

