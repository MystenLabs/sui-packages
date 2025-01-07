module 0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault {
    struct ChangeFeeCap has key {
        id: 0x2::object::UID,
        last_used_epoch: u64,
    }

    struct FeePercentages has store {
        total_protocol_fee: u64,
        treasury: u64,
        insurance_fund: u64,
        dev_wallet: u64,
        referee_discount: u64,
    }

    struct ProtocolFeeVault has store, key {
        id: 0x2::object::UID,
        version: u64,
        dev_wallet: address,
        fee_percentages: FeePercentages,
    }

    public fun transfer(arg0: ChangeFeeCap, arg1: address) {
        0x2::transfer::transfer<ChangeFeeCap>(arg0, arg1);
    }

    public fun assert_version(arg0: &ProtocolFeeVault) {
        assert!(arg0.version == 1, 0);
    }

    public entry fun change_fee_percentages(arg0: &mut ChangeFeeCap, arg1: &mut ProtocolFeeVault, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        let v0 = 0x2::tx_context::epoch(arg7);
        assert!(arg0.last_used_epoch < v0, 2);
        arg0.last_used_epoch = v0;
        if (0x1::option::is_some<u64>(&arg2)) {
            let v1 = 0x1::option::extract<u64>(&mut arg2);
            assert!(1000000000000 <= v1 && v1 <= 100000000000000, 3);
            arg1.fee_percentages.total_protocol_fee = v1;
        };
        if (0x1::option::is_some<u64>(&arg3)) {
            let v2 = 0x1::option::extract<u64>(&mut arg3);
            assert!(150000000000000000 <= v2 && v2 <= 750000000000000000, 4);
            arg1.fee_percentages.treasury = v2;
        };
        if (0x1::option::is_some<u64>(&arg4)) {
            let v3 = 0x1::option::extract<u64>(&mut arg4);
            assert!(150000000000000000 <= v3 && v3 <= 750000000000000000, 5);
            arg1.fee_percentages.insurance_fund = v3;
        };
        if (0x1::option::is_some<u64>(&arg5)) {
            let v4 = 0x1::option::extract<u64>(&mut arg5);
            assert!(100000000000000000 <= v4 && v4 <= 330000000000000000, 6);
            arg1.fee_percentages.dev_wallet = v4;
        };
        assert!(arg1.fee_percentages.treasury + arg1.fee_percentages.insurance_fund + arg1.fee_percentages.dev_wallet == 1000000000000000000, 9);
        if (0x1::option::is_some<u64>(&arg6)) {
            let v5 = 0x1::option::extract<u64>(&mut arg6);
            assert!(1000000000000000 <= v5 && v5 <= 100000000000000000, 7);
            arg1.fee_percentages.referee_discount = v5;
        };
    }

    public fun collect_fees<T0>(arg0: &ProtocolFeeVault, arg1: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg2: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg3: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg4: &mut 0x2::coin::Coin<T0>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::fixed::mul_by_fraction(0x2::coin::value<T0>(arg4), arg0.fee_percentages.total_protocol_fee);
        let v1 = if (0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::has_referrer(arg3, arg5)) {
            let v2 = 0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::fixed::mul_by_fraction(v0, arg0.fee_percentages.treasury);
            v2 - 0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::fixed::mul_by_fraction(v2, arg0.fee_percentages.referee_discount)
        } else {
            0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::fixed::mul_by_fraction(v0, arg0.fee_percentages.treasury)
        };
        if (v1 > 0) {
            0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::deposit<T0>(arg1, 0x2::coin::split<T0>(arg4, v1, arg6));
        };
        let v3 = 0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::fixed::mul_by_fraction(v0, arg0.fee_percentages.insurance_fund);
        if (v3 > 0) {
            0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::deposit<T0>(arg2, 0x2::coin::split<T0>(arg4, v3, arg6));
        };
        let v4 = 0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::fixed::mul_by_fraction(v0, arg0.fee_percentages.dev_wallet);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg4, v4, arg6), arg0.dev_wallet);
        };
    }

    public fun dev_wallet_fee(arg0: &ProtocolFeeVault) : u64 {
        arg0.fee_percentages.dev_wallet
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ChangeFeeCap{
            id              : 0x2::object::new(arg0),
            last_used_epoch : 0x2::tx_context::epoch(arg0),
        };
        0x2::transfer::transfer<ChangeFeeCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = FeePercentages{
            total_protocol_fee : 50000000000000,
            treasury           : 500000000000000000,
            insurance_fund     : 300000000000000000,
            dev_wallet         : 200000000000000000,
            referee_discount   : 50000000000000000,
        };
        let v2 = ProtocolFeeVault{
            id              : 0x2::object::new(arg0),
            version         : 1,
            dev_wallet      : @0x1fb0c0a6790860fc83c8f26f6fa089868ad94de9468348f98dfb4cdf89a53777,
            fee_percentages : v1,
        };
        0x2::transfer::share_object<ProtocolFeeVault>(v2);
    }

    public fun insurance_fund_fee(arg0: &ProtocolFeeVault) : u64 {
        arg0.fee_percentages.insurance_fund
    }

    public fun minimum_before_fees(arg0: &ProtocolFeeVault, arg1: u64) : u64 {
        assert_version(arg0);
        0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::fixed::div_up_by_fraction(arg1, 0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::fixed::complement64(arg0.fee_percentages.total_protocol_fee))
    }

    public fun referee_discount(arg0: &ProtocolFeeVault) : u64 {
        arg0.fee_percentages.referee_discount
    }

    public fun total_protocol_fee(arg0: &ProtocolFeeVault) : u64 {
        arg0.fee_percentages.total_protocol_fee
    }

    public fun treasury_fee(arg0: &ProtocolFeeVault) : u64 {
        arg0.fee_percentages.treasury
    }

    public entry fun update_dev_wallet_address(arg0: &mut ProtocolFeeVault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.dev_wallet, 1);
        arg0.dev_wallet = arg1;
    }

    // decompiled from Move bytecode v6
}

