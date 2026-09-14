module 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::psm {
    struct PSM<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        collateral_balance: 0x2::balance::Balance<T0>,
        fee_balance: 0x2::balance::Balance<T0>,
        collateral_decimals: u64,
        fee_bps: u64,
        min_fee_bps: u64,
        max_fee_bps: u64,
        max_total_balance: u64,
        max_swap_amount: u64,
        total_volume_in: u64,
        total_volume_out: u64,
        total_fees_collected: u64,
        paused: bool,
    }

    public(friend) fun create_psm<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EWrongPackageVersion()
    }

    entry fun emergency_withdraw_collateral<T0>(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut PSM<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EWrongPackageVersion()
    }

    public fun get_caps<T0>(arg0: &PSM<T0>) : (u64, u64) {
        (arg0.max_total_balance, arg0.max_swap_amount)
    }

    public fun get_collateral_balance<T0>(arg0: &PSM<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.collateral_balance)
    }

    public fun get_collateral_decimals<T0>(arg0: &PSM<T0>) : u64 {
        arg0.collateral_decimals
    }

    public fun get_fee_balance<T0>(arg0: &PSM<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.fee_balance)
    }

    public fun get_fee_bps<T0>(arg0: &PSM<T0>) : u64 {
        arg0.fee_bps
    }

    public fun get_fee_ranges<T0>(arg0: &PSM<T0>) : (u64, u64) {
        (arg0.min_fee_bps, arg0.max_fee_bps)
    }

    public fun get_stats<T0>(arg0: &PSM<T0>) : (u64, u64, u64) {
        (arg0.total_volume_in, arg0.total_volume_out, arg0.total_fees_collected)
    }

    public fun get_version<T0>(arg0: &PSM<T0>) : u64 {
        arg0.version
    }

    public fun is_paused<T0>(arg0: &PSM<T0>) : bool {
        arg0.paused
    }

    entry fun migrate<T0>(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut PSM<T0>) {
        abort 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EWrongPackageVersion()
    }

    public entry fun migrate_v32<T0>(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut PSM<T0>) {
        abort 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EWrongPackageVersion()
    }

    entry fun pause<T0>(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut PSM<T0>) {
        abort 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EWrongPackageVersion()
    }

    fun saturating_add(arg0: u64, arg1: u64) : u64 {
        let v0 = 18446744073709551615;
        if (arg0 > v0 - arg1) {
            v0
        } else {
            arg0 + arg1
        }
    }

    entry fun set_caps<T0>(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut PSM<T0>, arg2: u64, arg3: u64) {
        abort 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EWrongPackageVersion()
    }

    entry fun set_fee_bps<T0>(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut PSM<T0>, arg2: u64) {
        abort 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EWrongPackageVersion()
    }

    entry fun set_fee_ranges<T0>(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut PSM<T0>, arg2: u64, arg3: u64) {
        abort 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EWrongPackageVersion()
    }

    public fun swap_to_collateral<T0>(arg0: &mut PSM<T0>, arg1: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EWrongPackageVersion()
    }

    public fun swap_to_dori<T0>(arg0: &mut PSM<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI> {
        abort 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EWrongPackageVersion()
    }

    entry fun unpause<T0>(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut PSM<T0>) {
        abort 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EWrongPackageVersion()
    }

    entry fun withdraw_fees<T0>(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut PSM<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EWrongPackageVersion()
    }

    // decompiled from Move bytecode v6
}

