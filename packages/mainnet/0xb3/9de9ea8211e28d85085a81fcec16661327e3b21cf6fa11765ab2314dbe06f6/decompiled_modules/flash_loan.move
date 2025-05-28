module 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::flash_loan {
    struct FlashLoanGlobalConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        protocol_fee_percent_base_18: u64,
        staker_interest_percent_base_18: u64,
        total_staked: u64,
    }

    struct Receipt<phantom T0> {
        user: address,
        amount: u64,
        typeName: vector<u8>,
        protocol_fee_percent_base_18: u64,
        staker_interest_percent_base_18: u64,
    }

    public fun change_fee_percentages(arg0: &0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::admin::AdminCap, arg1: &mut FlashLoanGlobalConfig, arg2: &mut 0x1::option::Option<u64>, arg3: &mut 0x1::option::Option<u64>, arg4: &mut 0x1::option::Option<u64>) {
        if (0x1::option::is_some<u64>(arg2)) {
            arg1.version = 0x1::option::extract<u64>(arg2);
        };
        if (0x1::option::is_some<u64>(arg3)) {
            arg1.protocol_fee_percent_base_18 = 0x1::option::extract<u64>(arg3);
        };
        if (0x1::option::is_some<u64>(arg4)) {
            arg1.staker_interest_percent_base_18 = 0x1::option::extract<u64>(arg4);
        };
    }

    fun check_version(arg0: &FlashLoanGlobalConfig) {
        0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::version::check_version(arg0.version);
    }

    public(friend) fun create_config<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : FlashLoanGlobalConfig {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 1);
        FlashLoanGlobalConfig{
            id                              : 0x2::object::new(arg1),
            version                         : 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::version::current_version(),
            protocol_fee_percent_base_18    : 0,
            staker_interest_percent_base_18 : 0,
            total_staked                    : 0,
        }
    }

    public fun loan<T0>(arg0: &FlashLoanGlobalConfig, arg1: &0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::nft::NftConfig, arg2: &mut 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::treasury::Treasury, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (Receipt<T0>, 0x2::coin::Coin<T0>) {
        check_version(arg0);
        let v0 = Receipt<T0>{
            user                            : 0x2::tx_context::sender(arg5),
            amount                          : arg3,
            typeName                        : 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::utils::type_to_bytes<T0>(),
            protocol_fee_percent_base_18    : arg0.protocol_fee_percent_base_18,
            staker_interest_percent_base_18 : arg0.staker_interest_percent_base_18,
        };
        if (0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::nft::check_before_tge(arg1, arg4)) {
            let v1 = arg3 / 25 / 1000000000;
            if (v1 == 0) {
                0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::nft::zero_obj_mint_with_points(arg1, arg2, 10, arg4, arg5);
            };
            if (v1 > 0 && v1 <= 50) {
                0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::nft::zero_obj_mint_with_points(arg1, arg2, v1, arg4, arg5);
            };
            if (v1 >= 50) {
                0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::nft::zero_obj_mint_with_points(arg1, arg2, 50, arg4, arg5);
            };
        } else {
            let v2 = arg3 / 25;
            if (v2 == 0) {
                0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::nft::zero_obj_mint_with_no_points(10, arg5);
            };
            if (v2 > 0 && v2 <= 50) {
                0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::nft::zero_obj_mint_with_no_points(v2, arg5);
            };
            if (v2 >= 50) {
                0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::nft::zero_obj_mint_with_no_points(50, arg5);
            };
        };
        (v0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::treasury::borrow_from_treasury<T0>(arg2), arg3), arg5))
    }

    public fun repay<T0>(arg0: &mut 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::treasury::Treasury, arg1: Receipt<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = arg1.amount + 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::protocol_fee::take_percent_base_18(arg1.amount, arg1.protocol_fee_percent_base_18);
        assert!(0x2::coin::value<T0>(&arg2) >= v0, 0);
        0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::treasury::deposit<T0>(arg0, 0x2::coin::split<T0>(&mut arg2, v0, arg3));
        let Receipt {
            user                            : _,
            amount                          : v2,
            typeName                        : _,
            protocol_fee_percent_base_18    : _,
            staker_interest_percent_base_18 : _,
        } = arg1;
        0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::events::emit_flashloan_event(0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::utils::type_to_bytes<T0>(), v2, arg3);
        arg2
    }

    // decompiled from Move bytecode v6
}

