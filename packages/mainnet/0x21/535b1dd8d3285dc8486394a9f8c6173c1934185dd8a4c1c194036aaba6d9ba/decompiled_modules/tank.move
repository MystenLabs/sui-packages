module 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::tank {
    struct Tank<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        reserve: 0x2::balance::Balance<T0>,
        collateral_pool: 0x2::balance::Balance<T1>,
        current_p: u64,
        current_epoch: u64,
        epoch_scale_sum_map: 0x2::table::Table<EpochAndScale, u64>,
        current_scale: u64,
        bkt_pool: 0x2::balance::Balance<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bkt::BKT>,
        epoch_scale_gain_map: 0x2::table::Table<EpochAndScale, u64>,
        total_flash_loan_amount: u64,
    }

    struct ContributorToken<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        deposit_amount: u64,
        start_p: u64,
        start_s: u64,
        start_g: u64,
        start_epoch: u64,
        start_scale: u64,
        ctx_epoch: u64,
    }

    struct FlashReceipt<phantom T0, phantom T1> {
        amount: u64,
        fee: u64,
    }

    struct EpochAndScale has copy, drop, store {
        epoch: u64,
        scale: u64,
    }

    struct TANK has drop {
        dummy_field: bool,
    }

    public(friend) fun new<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) : Tank<T0, T1> {
        let v0 = 0x2::object::new(arg0);
        let v1 = new_table(arg0);
        Tank<T0, T1>{
            id                      : v0,
            reserve                 : 0x2::balance::zero<T0>(),
            collateral_pool         : 0x2::balance::zero<T1>(),
            current_p               : 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::constants::p_initial_value(),
            current_epoch           : 0,
            epoch_scale_sum_map     : v1,
            current_scale           : 0,
            bkt_pool                : 0x2::balance::zero<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bkt::BKT>(),
            epoch_scale_gain_map    : new_table(arg0),
            total_flash_loan_amount : 0,
        }
    }

    public fun claim<T0, T1>(arg0: &mut Tank<T0, T1>, arg1: &mut 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bkt::BktTreasury, arg2: &mut ContributorToken<T0, T1>, arg3: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bkt::BKT>) {
        let v0 = claim_bkt<T0, T1>(arg0, arg2);
        let v1 = &mut arg0.epoch_scale_sum_map;
        add_table(v1, arg2.start_epoch, arg2.start_scale + 1);
        let v2 = get_collateral_reward_amount<T0, T1>(arg0, arg2);
        let v3 = EpochAndScale{
            epoch : arg0.current_epoch,
            scale : arg0.current_scale,
        };
        let v4 = &mut arg0.epoch_scale_gain_map;
        add_table(v4, arg0.current_epoch, arg0.current_scale);
        let v5 = EpochAndScale{
            epoch : arg0.current_epoch,
            scale : arg0.current_scale,
        };
        arg2.deposit_amount = get_token_weight<T0, T1>(arg0, arg2);
        arg2.start_s = *0x2::table::borrow<EpochAndScale, u64>(&mut arg0.epoch_scale_sum_map, v3);
        arg2.start_p = arg0.current_p;
        arg2.start_g = *0x2::table::borrow<EpochAndScale, u64>(&mut arg0.epoch_scale_gain_map, v5);
        arg2.start_epoch = arg0.current_epoch;
        arg2.start_scale = arg0.current_scale;
        0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::tank_events::emit_withdraw<T1>(0, v2, 0x2::balance::value<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bkt::BKT>(&v0));
        let (v6, v7) = if (0x2::tx_context::epoch(arg3) - arg2.ctx_epoch > 7) {
            (v0, 0x2::balance::split<T1>(&mut arg0.collateral_pool, v2))
        } else {
            0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bkt::collect_bkt(arg1, v0);
            (0x2::balance::zero<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bkt::BKT>(), 0x2::balance::split<T1>(&mut arg0.collateral_pool, v2))
        };
        (v7, v6)
    }

    public(friend) fun collect_bkt<T0, T1>(arg0: &mut Tank<T0, T1>, arg1: 0x2::balance::Balance<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bkt::BKT>) {
        let v0 = 0x2::balance::value<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bkt::BKT>(&arg1);
        0x2::balance::join<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bkt::BKT>(&mut arg0.bkt_pool, arg1);
        let v1 = &mut arg0.epoch_scale_gain_map;
        add_table(v1, arg0.current_epoch, arg0.current_scale);
        let v2 = EpochAndScale{
            epoch : arg0.current_epoch,
            scale : arg0.current_scale,
        };
        let v3 = 0x2::table::borrow_mut<EpochAndScale, u64>(&mut arg0.epoch_scale_gain_map, v2);
        *v3 = *v3 + 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg0.current_p, v0, get_reserve_balance<T0, T1>(arg0));
        0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::tank_events::emit_collect_bkt<T1>(v0);
    }

    public(friend) fun absorb<T0, T1>(arg0: &mut Tank<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg1);
        let v1 = 0x2::balance::value<T0>(&arg0.reserve);
        let v2 = v1 - arg2;
        assert!(v1 > 0, 6);
        let v3 = &mut arg0.epoch_scale_sum_map;
        add_table(v3, arg0.current_epoch, arg0.current_scale);
        let v4 = EpochAndScale{
            epoch : arg0.current_epoch,
            scale : arg0.current_scale,
        };
        let v5 = 0x2::table::borrow_mut<EpochAndScale, u64>(&mut arg0.epoch_scale_sum_map, v4);
        *v5 = *v5 + 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg0.current_p, v0, v1);
        let v6 = 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg0.current_p, v2, v1);
        if (v2 == 0) {
            arg0.current_epoch = arg0.current_epoch + 1;
            arg0.current_p = 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::constants::p_initial_value();
            arg0.current_scale = 0;
            let v7 = &mut arg0.epoch_scale_sum_map;
            add_table(v7, arg0.current_epoch, arg0.current_scale);
        } else if (v6 < 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::constants::scale_factor()) {
            arg0.current_p = v6 * 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::constants::scale_factor();
            arg0.current_scale = arg0.current_scale + 1;
            let v8 = &mut arg0.epoch_scale_sum_map;
            add_table(v8, arg0.current_epoch, arg0.current_scale);
        } else {
            arg0.current_p = v6;
        };
        assert!(arg0.current_p > 0, 4);
        0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::tank_events::emit_absorb<T1>(arg2, v0);
        0x2::balance::join<T1>(&mut arg0.collateral_pool, arg1);
        0x2::balance::split<T0>(&mut arg0.reserve, arg2)
    }

    fun add_table(arg0: &mut 0x2::table::Table<EpochAndScale, u64>, arg1: u64, arg2: u64) {
        let v0 = EpochAndScale{
            epoch : arg1,
            scale : arg2,
        };
        if (!0x2::table::contains<EpochAndScale, u64>(arg0, v0)) {
            let v1 = EpochAndScale{
                epoch : arg1,
                scale : arg2,
            };
            0x2::table::add<EpochAndScale, u64>(arg0, v1, 0);
        };
    }

    public fun airdrop_bkt<T0, T1>(arg0: &mut Tank<T0, T1>, arg1: 0x2::balance::Balance<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bkt::BKT>) {
        0x2::balance::join<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bkt::BKT>(&mut arg0.bkt_pool, arg1);
    }

    public fun airdrop_collateral<T0, T1>(arg0: &mut Tank<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(&mut arg0.collateral_pool, arg1);
    }

    fun claim_bkt<T0, T1>(arg0: &mut Tank<T0, T1>, arg1: &mut ContributorToken<T0, T1>) : 0x2::balance::Balance<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bkt::BKT> {
        let v0 = &mut arg0.epoch_scale_gain_map;
        add_table(v0, arg1.start_epoch, arg1.start_scale);
        let v1 = &mut arg0.epoch_scale_gain_map;
        add_table(v1, arg1.start_epoch, arg1.start_scale + 1);
        0x2::balance::split<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bkt::BKT>(&mut arg0.bkt_pool, get_bkt_reward_amount<T0, T1>(arg0, arg1))
    }

    public fun deposit<T0, T1>(arg0: &mut Tank<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : ContributorToken<T0, T1> {
        assert!(is_not_locked<T0, T1>(arg0), 0);
        assert!(0x2::balance::value<T0>(&arg1) > 0, 7);
        let v0 = 0x2::balance::value<T0>(&arg1);
        0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::tank_events::emit_deposit<T1>(v0);
        0x2::balance::join<T0>(&mut arg0.reserve, arg1);
        let v1 = EpochAndScale{
            epoch : arg0.current_epoch,
            scale : arg0.current_scale,
        };
        let v2 = &mut arg0.epoch_scale_sum_map;
        add_table(v2, arg0.current_epoch, arg0.current_scale);
        let v3 = &mut arg0.epoch_scale_gain_map;
        add_table(v3, arg0.current_epoch, arg0.current_scale);
        ContributorToken<T0, T1>{
            id             : 0x2::object::new(arg2),
            deposit_amount : v0,
            start_p        : arg0.current_p,
            start_s        : *0x2::table::borrow<EpochAndScale, u64>(&mut arg0.epoch_scale_sum_map, v1),
            start_g        : *0x2::table::borrow<EpochAndScale, u64>(&mut arg0.epoch_scale_gain_map, v1),
            start_epoch    : arg0.current_epoch,
            start_scale    : arg0.current_scale,
            ctx_epoch      : 0x2::tx_context::epoch(arg2),
        }
    }

    public fun get_bkt_pool_balance<T0, T1>(arg0: &Tank<T0, T1>) : u64 {
        0x2::balance::value<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bkt::BKT>(&arg0.bkt_pool)
    }

    public fun get_bkt_reward_amount<T0, T1>(arg0: &Tank<T0, T1>, arg1: &ContributorToken<T0, T1>) : u64 {
        if (arg1.deposit_amount == 0) {
            return 0
        };
        let v0 = EpochAndScale{
            epoch : arg1.start_epoch,
            scale : arg1.start_scale,
        };
        let v1 = EpochAndScale{
            epoch : arg1.start_epoch,
            scale : arg1.start_scale + 1,
        };
        let v2 = if (0x2::table::contains<EpochAndScale, u64>(&arg0.epoch_scale_gain_map, v1)) {
            let v3 = EpochAndScale{
                epoch : arg1.start_epoch,
                scale : arg1.start_scale + 1,
            };
            *0x2::table::borrow<EpochAndScale, u64>(&arg0.epoch_scale_gain_map, v3) / 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::constants::scale_factor()
        } else {
            0
        };
        0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg1.deposit_amount, *0x2::table::borrow<EpochAndScale, u64>(&arg0.epoch_scale_gain_map, v0) - arg1.start_g + v2, arg1.start_p)
    }

    public fun get_collateral_pool_balance<T0, T1>(arg0: &Tank<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.collateral_pool)
    }

    public fun get_collateral_reward_amount<T0, T1>(arg0: &Tank<T0, T1>, arg1: &ContributorToken<T0, T1>) : u64 {
        let v0 = EpochAndScale{
            epoch : arg1.start_epoch,
            scale : arg1.start_scale,
        };
        assert!(0x2::table::contains<EpochAndScale, u64>(&arg0.epoch_scale_sum_map, v0), 3);
        let v1 = EpochAndScale{
            epoch : arg1.start_epoch,
            scale : arg1.start_scale + 1,
        };
        let v2 = if (!0x2::table::contains<EpochAndScale, u64>(&arg0.epoch_scale_sum_map, v1)) {
            0
        } else {
            let v3 = EpochAndScale{
                epoch : arg1.start_epoch,
                scale : arg1.start_scale + 1,
            };
            *0x2::table::borrow<EpochAndScale, u64>(&arg0.epoch_scale_sum_map, v3)
        };
        0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg1.deposit_amount, *0x2::table::borrow<EpochAndScale, u64>(&arg0.epoch_scale_sum_map, v0) - arg1.start_s + v2 / 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::constants::scale_factor(), arg1.start_p)
    }

    public fun get_contributor_token_value<T0, T1>(arg0: &ContributorToken<T0, T1>) : (u64, u64, u64, u64, u64, u64) {
        (arg0.deposit_amount, arg0.start_p, arg0.start_s, arg0.start_g, arg0.start_epoch, arg0.start_scale)
    }

    public fun get_current_epoch<T0, T1>(arg0: &Tank<T0, T1>) : u64 {
        arg0.current_epoch
    }

    public fun get_current_p<T0, T1>(arg0: &Tank<T0, T1>) : u64 {
        arg0.current_p
    }

    public fun get_current_scale<T0, T1>(arg0: &Tank<T0, T1>) : u64 {
        arg0.current_scale
    }

    public fun get_epoch_scale_gain_map<T0, T1>(arg0: &Tank<T0, T1>, arg1: u64, arg2: u64) : u64 {
        let v0 = EpochAndScale{
            epoch : arg1,
            scale : arg2,
        };
        *0x2::table::borrow<EpochAndScale, u64>(&arg0.epoch_scale_gain_map, v0)
    }

    public fun get_epoch_scale_sum_map<T0, T1>(arg0: &Tank<T0, T1>, arg1: u64, arg2: u64) : u64 {
        let v0 = EpochAndScale{
            epoch : arg1,
            scale : arg2,
        };
        *0x2::table::borrow<EpochAndScale, u64>(&arg0.epoch_scale_sum_map, v0)
    }

    public fun get_receipt_info<T0, T1>(arg0: &FlashReceipt<T0, T1>) : (u64, u64) {
        (arg0.amount, arg0.fee)
    }

    public fun get_reserve_balance<T0, T1>(arg0: &Tank<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.reserve)
    }

    public fun get_token_ctx_epoch<T0, T1>(arg0: &ContributorToken<T0, T1>) : u64 {
        arg0.ctx_epoch
    }

    public fun get_token_weight<T0, T1>(arg0: &Tank<T0, T1>, arg1: &ContributorToken<T0, T1>) : u64 {
        if (arg1.start_epoch < arg0.current_epoch) {
            return 0
        };
        let v0 = arg0.current_scale - arg1.start_scale;
        if (v0 == 0) {
            0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg1.deposit_amount, arg0.current_p, arg1.start_p)
        } else if (v0 == 1) {
            0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg1.deposit_amount, arg0.current_p, arg1.start_p) / 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::constants::scale_factor()
        } else {
            0
        }
    }

    public fun get_total_flash_loan_amount<T0, T1>(arg0: &Tank<T0, T1>) : u64 {
        arg0.total_flash_loan_amount
    }

    public(friend) fun handle_flash_borrow<T0, T1>(arg0: &mut Tank<T0, T1>, arg1: u64) : (0x2::balance::Balance<T0>, FlashReceipt<T0, T1>) {
        arg0.total_flash_loan_amount = arg0.total_flash_loan_amount + arg1;
        let v0 = 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg1, 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::constants::flash_loan_fee(), 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::constants::fee_precision());
        let v1 = v0;
        if (v0 == 0) {
            v1 = 1;
        };
        let v2 = FlashReceipt<T0, T1>{
            amount : arg1,
            fee    : v1,
        };
        (0x2::balance::split<T0>(&mut arg0.reserve, arg1), v2)
    }

    public(friend) fun handle_flash_repay<T0, T1>(arg0: &mut Tank<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: FlashReceipt<T0, T1>) : 0x2::balance::Balance<T0> {
        let FlashReceipt {
            amount : v0,
            fee    : v1,
        } = arg2;
        arg0.total_flash_loan_amount = arg0.total_flash_loan_amount - v0;
        assert!(0x2::balance::value<T0>(&arg1) >= v0 + v1, 1);
        0x2::balance::join<T0>(&mut arg0.reserve, 0x2::balance::split<T0>(&mut arg1, v0));
        arg1
    }

    fun init(arg0: TANK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<TANK>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun is_not_locked<T0, T1>(arg0: &Tank<T0, T1>) : bool {
        arg0.total_flash_loan_amount == 0
    }

    public fun new_table(arg0: &mut 0x2::tx_context::TxContext) : 0x2::table::Table<EpochAndScale, u64> {
        0x2::table::new<EpochAndScale, u64>(arg0)
    }

    public(friend) fun withdraw<T0, T1>(arg0: &mut Tank<T0, T1>, arg1: &mut 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bkt::BktTreasury, arg2: ContributorToken<T0, T1>, arg3: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bkt::BKT>) {
        let v0 = get_token_weight<T0, T1>(arg0, &arg2);
        let v1 = 0x2::balance::split<T0>(&mut arg0.reserve, v0);
        let v2 = &mut arg2;
        let (v3, v4) = claim<T0, T1>(arg0, arg1, v2, arg3);
        let v5 = v4;
        let ContributorToken {
            id             : v6,
            deposit_amount : _,
            start_p        : _,
            start_s        : _,
            start_g        : _,
            start_epoch    : _,
            start_scale    : _,
            ctx_epoch      : _,
        } = arg2;
        0x2::object::delete(v6);
        0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::tank_events::emit_withdraw<T1>(v0, 0x2::balance::value<T0>(&v1), 0x2::balance::value<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bkt::BKT>(&v5));
        (v1, v3, v5)
    }

    // decompiled from Move bytecode v6
}

