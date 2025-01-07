module 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::history {
    struct Volumes has copy, drop, store {
        total_volume: u128,
        total_staked_volume: u128,
        total_fees_collected: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balances::Balances,
        historic_median: u128,
        trade_params: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::trade_params::TradeParams,
    }

    struct History has store {
        epoch: u64,
        epoch_created: u64,
        volumes: Volumes,
        historic_volumes: 0x2::table::Table<u64, Volumes>,
        balance_to_burn: u64,
    }

    public(friend) fun empty(arg0: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::trade_params::TradeParams, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : History {
        let v0 = Volumes{
            total_volume         : 0,
            total_staked_volume  : 0,
            total_fees_collected : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balances::empty(),
            historic_median      : 0,
            trade_params         : arg0,
        };
        let v1 = History{
            epoch            : 0x2::tx_context::epoch(arg2),
            epoch_created    : arg1,
            volumes          : v0,
            historic_volumes : 0x2::table::new<u64, Volumes>(arg2),
            balance_to_burn  : 0,
        };
        0x2::table::add<u64, Volumes>(&mut v1.historic_volumes, 0x2::tx_context::epoch(arg2), v0);
        v1
    }

    public(friend) fun add_total_fees_collected(arg0: &mut History, arg1: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balances::Balances) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balances::add_balances(&mut arg0.volumes.total_fees_collected, arg1);
    }

    public(friend) fun add_volume(arg0: &mut History, arg1: u64, arg2: u64) {
        if (arg1 == 0) {
            return
        };
        let v0 = (arg1 as u128);
        arg0.volumes.total_volume = arg0.volumes.total_volume + v0;
        if (arg2 >= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::trade_params::stake_required(&arg0.volumes.trade_params)) {
            arg0.volumes.total_staked_volume = arg0.volumes.total_staked_volume + v0;
        };
    }

    public(friend) fun balance_to_burn(arg0: &History) : u64 {
        arg0.balance_to_burn
    }

    public(friend) fun calculate_rebate_amount(arg0: &mut History, arg1: u64, arg2: u128, arg3: u64) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balances::Balances {
        assert!(0x2::table::contains<u64, Volumes>(&arg0.historic_volumes, arg1), 0);
        let v0 = 0x2::table::borrow_mut<u64, Volumes>(&mut arg0.historic_volumes, arg1);
        if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::trade_params::stake_required(&v0.trade_params) > arg3) {
            return 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balances::empty()
        };
        let v1 = (arg2 as u128);
        let v2 = if (v0.historic_median > 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling_u128() - 0x1::u128::min(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling_u128(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::div_u128(v0.total_volume - v1, v0.historic_median))
        } else {
            0
        };
        let v3 = if (v0.total_staked_volume > 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::div_u128(v1, v0.total_staked_volume)
        } else {
            0
        };
        let v4 = (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul_u128(v3, (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balances::deep(&v0.total_fees_collected) as u128)) as u64);
        let v5 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul((v2 as u64), v4);
        arg0.balance_to_burn = arg0.balance_to_burn + v4 - v5;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balances::new(0, 0, v5)
    }

    public(friend) fun historic_maker_fee(arg0: &History, arg1: u64) : u64 {
        assert!(0x2::table::contains<u64, Volumes>(&arg0.historic_volumes, arg1), 0);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::trade_params::maker_fee(&0x2::table::borrow<u64, Volumes>(&arg0.historic_volumes, arg1).trade_params)
    }

    public(friend) fun reset_balance_to_burn(arg0: &mut History) : u64 {
        arg0.balance_to_burn = 0;
        arg0.balance_to_burn
    }

    public(friend) fun reset_volumes(arg0: &mut History, arg1: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::trade_params::TradeParams) {
        let v0 = Volumes{
            total_volume         : 0,
            total_staked_volume  : 0,
            total_fees_collected : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balances::empty(),
            historic_median      : 0,
            trade_params         : arg1,
        };
        arg0.volumes = v0;
    }

    public(friend) fun update(arg0: &mut History, arg1: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::trade_params::TradeParams, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        if (arg0.epoch == v0) {
            return
        };
        if (0x2::table::contains<u64, Volumes>(&arg0.historic_volumes, arg0.epoch)) {
            0x2::table::remove<u64, Volumes>(&mut arg0.historic_volumes, arg0.epoch);
        };
        update_historic_median(arg0);
        0x2::table::add<u64, Volumes>(&mut arg0.historic_volumes, arg0.epoch, arg0.volumes);
        arg0.epoch = v0;
        reset_volumes(arg0, arg1);
        0x2::table::add<u64, Volumes>(&mut arg0.historic_volumes, arg0.epoch, arg0.volumes);
    }

    public(friend) fun update_historic_median(arg0: &mut History) {
        if (arg0.epoch - arg0.epoch_created < 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::phase_out_epochs()) {
            arg0.volumes.historic_median = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_u128();
            return
        };
        let v0 = vector[];
        let v1 = arg0.epoch - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::phase_out_epochs();
        while (v1 < arg0.epoch) {
            if (0x2::table::contains<u64, Volumes>(&arg0.historic_volumes, v1)) {
                0x1::vector::push_back<u128>(&mut v0, 0x2::table::borrow<u64, Volumes>(&arg0.historic_volumes, v1).total_volume);
            } else {
                0x1::vector::push_back<u128>(&mut v0, 0);
            };
            v1 = v1 + 1;
        };
        arg0.volumes.historic_median = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::median(v0);
    }

    // decompiled from Move bytecode v6
}

