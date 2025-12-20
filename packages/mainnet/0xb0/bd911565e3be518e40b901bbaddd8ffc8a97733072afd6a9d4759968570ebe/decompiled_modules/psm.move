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
        assert!(arg1 >= arg2 && arg1 <= arg3, 1004);
        assert!(arg3 <= 10000, 1004);
        let v0 = PSM<T0>{
            id                   : 0x2::object::new(arg6),
            version              : 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION(),
            collateral_balance   : 0x2::balance::zero<T0>(),
            fee_balance          : 0x2::balance::zero<T0>(),
            collateral_decimals  : arg0,
            fee_bps              : arg1,
            min_fee_bps          : arg2,
            max_fee_bps          : arg3,
            max_total_balance    : arg4,
            max_swap_amount      : arg5,
            total_volume_in      : 0,
            total_volume_out     : 0,
            total_fees_collected : 0,
            paused               : false,
        };
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_psm_created_event(0x2::object::id<PSM<T0>>(&v0), arg1, arg4, arg5);
        0x2::transfer::share_object<PSM<T0>>(v0);
    }

    entry fun emergency_withdraw_collateral<T0>(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut PSM<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.paused, 1000);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_psm_emergency_withdraw_event(0x2::object::id<PSM<T0>>(arg1), arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.collateral_balance, arg2), arg4), arg3);
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
        assert!(arg1.version < 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION(), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ENotUpgrade());
        arg1.version = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION();
    }

    entry fun pause<T0>(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut PSM<T0>) {
        arg1.paused = true;
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_psm_paused_event(0x2::object::id<PSM<T0>>(arg1));
    }

    entry fun set_caps<T0>(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut PSM<T0>, arg2: u64, arg3: u64) {
        assert!(arg3 > 0, 1005);
        assert!(arg2 >= 0x2::balance::value<T0>(&arg1.collateral_balance), 1005);
        arg1.max_total_balance = arg2;
        arg1.max_swap_amount = arg3;
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_psm_caps_updated_event(0x2::object::id<PSM<T0>>(arg1), arg2, arg3);
    }

    entry fun set_fee_bps<T0>(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut PSM<T0>, arg2: u64) {
        assert!(arg2 >= arg1.min_fee_bps && arg2 <= arg1.max_fee_bps, 1004);
        arg1.fee_bps = arg2;
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_psm_fee_updated_event(0x2::object::id<PSM<T0>>(arg1), arg1.fee_bps, arg2);
    }

    entry fun set_fee_ranges<T0>(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut PSM<T0>, arg2: u64, arg3: u64) {
        assert!(arg2 <= arg3, 1004);
        assert!(arg3 <= 10000, 1004);
        arg1.min_fee_bps = arg2;
        arg1.max_fee_bps = arg3;
        if (arg1.fee_bps < arg2) {
            arg1.fee_bps = arg2;
        };
        if (arg1.fee_bps > arg3) {
            arg1.fee_bps = arg3;
        };
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_psm_fee_range_updated_event(0x2::object::id<PSM<T0>>(arg1), arg2, arg3);
    }

    public fun swap_to_collateral<T0>(arg0: &mut PSM<T0>, arg1: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION(), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EWrongPackageVersion());
        assert!(!arg0.paused, 1000);
        let v0 = 0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg1);
        assert!(v0 > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EValueZero());
        assert!((v0 as u256) <= (arg0.max_swap_amount as u256) * 1000000000 / (arg0.collateral_decimals as u256), 1002);
        let v1 = (v0 as u256) * (arg0.collateral_decimals as u256) / 1000000000;
        let v2 = v1 * (arg0.fee_bps as u256) / 10000;
        let v3 = v1 - v2;
        assert!((0x2::balance::value<T0>(&arg0.collateral_balance) as u256) >= v1, 1003);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::burn_dori_coin(arg2, arg1);
        0x2::balance::join<T0>(&mut arg0.fee_balance, 0x2::balance::split<T0>(&mut arg0.collateral_balance, (v2 as u64)));
        arg0.total_volume_out = arg0.total_volume_out + (v1 as u64);
        arg0.total_fees_collected = arg0.total_fees_collected + (v2 as u64);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_psm_swap_to_collateral_event(0x2::object::id<PSM<T0>>(arg0), 0x2::tx_context::sender(arg3), v0, (v3 as u64), (v2 as u64));
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.collateral_balance, (v3 as u64)), arg3)
    }

    public fun swap_to_dori<T0>(arg0: &mut PSM<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI> {
        assert!(arg0.version == 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION(), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EWrongPackageVersion());
        assert!(!arg0.paused, 1000);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EValueZero());
        assert!(v0 <= arg0.max_swap_amount, 1002);
        let v1 = (v0 as u256) * (arg0.fee_bps as u256) / 10000;
        let v2 = v0 - (v1 as u64);
        assert!(0x2::balance::value<T0>(&arg0.collateral_balance) + v2 <= arg0.max_total_balance, 1001);
        let v3 = (v2 as u256) * 1000000000 / (arg0.collateral_decimals as u256);
        let v4 = 0x2::coin::into_balance<T0>(arg1);
        0x2::balance::join<T0>(&mut arg0.fee_balance, 0x2::balance::split<T0>(&mut v4, (v1 as u64)));
        0x2::balance::join<T0>(&mut arg0.collateral_balance, v4);
        arg0.total_volume_in = arg0.total_volume_in + v0;
        arg0.total_fees_collected = arg0.total_fees_collected + (v1 as u64);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_psm_swap_to_dori_event(0x2::object::id<PSM<T0>>(arg0), 0x2::tx_context::sender(arg3), v0, (v3 as u64), (v1 as u64));
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::mint_dori_and_return_coin(arg2, (v3 as u64), arg3)
    }

    entry fun unpause<T0>(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut PSM<T0>) {
        arg1.paused = false;
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_psm_unpaused_event(0x2::object::id<PSM<T0>>(arg1));
    }

    entry fun withdraw_fees<T0>(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut PSM<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 0x2::balance::value<T0>(&arg1.fee_balance), 1003);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.fee_balance, arg2), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

