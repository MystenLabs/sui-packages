module 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::staking {
    struct StakeConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        tge_time: u64,
        ratio_base_18: u64,
        max_stake_limit: u64,
        total_staked: u64,
    }

    public fun change_stake_config(arg0: &0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::admin::AdminCap, arg1: &mut StakeConfig, arg2: &mut 0x1::option::Option<u64>, arg3: &mut 0x1::option::Option<u64>, arg4: &mut 0x1::option::Option<u64>, arg5: &mut 0x1::option::Option<u64>) {
        if (0x1::option::is_some<u64>(arg2)) {
            arg1.version = 0x1::option::extract<u64>(arg2);
        };
        if (0x1::option::is_some<u64>(arg3)) {
            arg1.tge_time = 0x1::option::extract<u64>(arg3);
        };
        if (0x1::option::is_some<u64>(arg4)) {
            arg1.ratio_base_18 = 0x1::option::extract<u64>(arg4);
        };
        if (0x1::option::is_some<u64>(arg5)) {
            arg1.max_stake_limit = 0x1::option::extract<u64>(arg5);
        };
    }

    fun check_version(arg0: &StakeConfig) {
        0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::version::check_version(arg0.version);
    }

    public(friend) fun create_config<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : StakeConfig {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 1);
        StakeConfig{
            id              : 0x2::object::new(arg1),
            version         : 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::version::current_version(),
            tge_time        : 1746057600000,
            ratio_base_18   : 25000000000000000,
            max_stake_limit : 180000000000000,
            total_staked    : 0,
        }
    }

    public fun stake(arg0: &mut 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::csui::CSUITreasuryCoinfig, arg1: &mut StakeConfig, arg2: &mut 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::treasury::Treasury, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::csui::CSUI> {
        check_version(arg1);
        let v0 = (((0x2::coin::value<0x2::sui::SUI>(&arg3) as u128) * 1000000000 / (1000000000 + ((0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::protocol_fee::take_percent_base_18(1000000000, arg1.ratio_base_18) * (0x2::clock::timestamp_ms(arg4) - arg1.tge_time) / 31536000000) as u128))) as u64);
        arg1.total_staked = 0x2::coin::value<0x2::sui::SUI>(&arg3) + arg1.total_staked;
        assert!(arg1.total_staked <= arg1.max_stake_limit, 0);
        0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::treasury::deposit<0x2::sui::SUI>(arg2, arg3);
        0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::events::emit_stake_event(v0, arg5);
        0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::csui::mint_csui(arg0, v0, arg5)
    }

    public fun unstake(arg0: &mut 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::csui::CSUITreasuryCoinfig, arg1: &mut StakeConfig, arg2: &mut 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::treasury::Treasury, arg3: 0x2::coin::Coin<0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::csui::CSUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check_version(arg1);
        let v0 = (((0x2::coin::value<0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::csui::CSUI>(&arg3) as u128) * (1000000000 + ((0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::protocol_fee::take_percent_base_18(1000000000, arg1.ratio_base_18) * (0x2::clock::timestamp_ms(arg4) - arg1.tge_time) / 31536000000) as u128)) / 1000000000) as u64);
        arg1.total_staked = arg1.total_staked - v0;
        assert!(arg1.total_staked >= v0, 0);
        0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::csui::burn_csui(arg0, arg3);
        0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::events::emit_unstake_event(v0, arg5);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::treasury::borrow_from_treasury<0x2::sui::SUI>(arg2), v0), arg5)
    }

    // decompiled from Move bytecode v6
}

