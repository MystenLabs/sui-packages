module 0x50b4040c270ab7a2bd071218814a33f7c97e4d69c280e5132d26f1f4cff08ff0::vault {
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

    public fun collect_fees<T0>(arg0: &ProtocolFeeVault, arg1: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg2: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg3: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg4: &mut 0x2::coin::Coin<T0>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x78548ffea3a06853d89dded8c6cdbed1fafc69d89469c4693c2373d6d600f666::fixed::mul_by_fraction(0x2::coin::value<T0>(arg4), arg0.fee_percentages.total_protocol_fee);
        let v1 = if (0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::has_referrer(arg3, arg5)) {
            let v2 = 0x78548ffea3a06853d89dded8c6cdbed1fafc69d89469c4693c2373d6d600f666::fixed::mul_by_fraction(v0, arg0.fee_percentages.treasury);
            v2 - 0x78548ffea3a06853d89dded8c6cdbed1fafc69d89469c4693c2373d6d600f666::fixed::mul_by_fraction(v2, arg0.fee_percentages.referee_discount)
        } else {
            0x78548ffea3a06853d89dded8c6cdbed1fafc69d89469c4693c2373d6d600f666::fixed::mul_by_fraction(v0, arg0.fee_percentages.treasury)
        };
        if (v1 > 0) {
            0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::deposit<T0>(arg1, 0x2::coin::split<T0>(arg4, v1, arg6));
        };
        let v3 = 0x78548ffea3a06853d89dded8c6cdbed1fafc69d89469c4693c2373d6d600f666::fixed::mul_by_fraction(v0, arg0.fee_percentages.insurance_fund);
        if (v3 > 0) {
            0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::deposit<T0>(arg2, 0x2::coin::split<T0>(arg4, v3, arg6));
        };
        let v4 = 0x78548ffea3a06853d89dded8c6cdbed1fafc69d89469c4693c2373d6d600f666::fixed::mul_by_fraction(v0, arg0.fee_percentages.dev_wallet);
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
        0x78548ffea3a06853d89dded8c6cdbed1fafc69d89469c4693c2373d6d600f666::fixed::div_up_by_fraction(arg1, 0x78548ffea3a06853d89dded8c6cdbed1fafc69d89469c4693c2373d6d600f666::fixed::complement64(arg0.fee_percentages.total_protocol_fee))
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

