module 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration {
    struct Configuration has store, key {
        id: 0x2::object::UID,
        lender_fee_percent: u64,
        borrower_fee_percent: u64,
        liquidation_fee_percent: u64,
        max_offer_interest: u64,
        min_health_ratio: u64,
        hot_wallet: address,
        relayer_wallet: address,
        max_vaa_age_seconds: u64,
    }

    public(friend) fun borrow<T0: copy + drop + store, T1: store>(arg0: &Configuration, arg1: T0) : &T1 {
        0x2::dynamic_field::borrow<T0, T1>(&arg0.id, arg1)
    }

    public(friend) fun borrow_mut<T0: copy + drop + store, T1: store>(arg0: &mut Configuration, arg1: T0) : &mut T1 {
        0x2::dynamic_field::borrow_mut<T0, T1>(&mut arg0.id, arg1)
    }

    public(friend) fun add<T0: copy + drop + store, T1: store>(arg0: &mut Configuration, arg1: T0, arg2: T1) {
        0x2::dynamic_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
    }

    public(friend) fun remove<T0: copy + drop + store, T1: store>(arg0: &mut Configuration, arg1: T0) : T1 {
        0x2::dynamic_field::remove<T0, T1>(&mut arg0.id, arg1)
    }

    public(friend) fun new(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: address, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = Configuration{
            id                      : 0x2::object::new(arg8),
            lender_fee_percent      : arg0,
            borrower_fee_percent    : arg1,
            liquidation_fee_percent : arg2,
            max_offer_interest      : arg3,
            min_health_ratio        : arg4,
            hot_wallet              : arg5,
            relayer_wallet          : arg6,
            max_vaa_age_seconds     : arg7,
        };
        0x2::transfer::public_share_object<Configuration>(v0);
    }

    public fun borrower_fee_percent(arg0: &Configuration) : u64 {
        arg0.borrower_fee_percent
    }

    public(friend) fun contain<T0: copy + drop + store, T1: store>(arg0: &Configuration, arg1: T0) : bool {
        0x2::dynamic_field::exists_with_type<T0, T1>(&arg0.id, arg1)
    }

    public fun hot_wallet(arg0: &Configuration) : address {
        arg0.hot_wallet
    }

    public fun lender_fee_percent(arg0: &Configuration) : u64 {
        arg0.lender_fee_percent
    }

    public fun liquidation_fee_percent(arg0: &Configuration) : u64 {
        arg0.liquidation_fee_percent
    }

    public fun max_offer_interest(arg0: &Configuration) : u64 {
        arg0.max_offer_interest
    }

    public fun max_vaa_age_seconds(arg0: &Configuration) : u64 {
        arg0.max_vaa_age_seconds
    }

    public fun min_health_ratio(arg0: &Configuration) : u64 {
        arg0.min_health_ratio
    }

    public fun relayer_wallet(arg0: &Configuration) : address {
        arg0.relayer_wallet
    }

    public(friend) fun update(arg0: &mut Configuration, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: address, arg8: u64) {
        arg0.lender_fee_percent = arg1;
        arg0.borrower_fee_percent = arg2;
        arg0.liquidation_fee_percent = arg3;
        arg0.max_offer_interest = arg4;
        arg0.min_health_ratio = arg5;
        arg0.hot_wallet = arg6;
        arg0.relayer_wallet = arg7;
        arg0.max_vaa_age_seconds = arg8;
    }

    // decompiled from Move bytecode v6
}

