module 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::receiver {
    struct Receiver<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        mode: u8,
        dst_domain: u32,
        dst_recipient: address,
        cctp_recipient: vector<u8>,
        hook_target: address,
        referrer: address,
        balance: 0x2::balance::Balance<T0>,
        fee_accrued: u64,
        cctp_threshold: u64,
        deploy_nonce: u64,
    }

    struct ReceiverDeployed has copy, drop {
        receiver: address,
        owner: address,
        mode: u8,
        dst_domain: u32,
        dst_recipient: address,
        hook_target: address,
        referrer: address,
        deploy_nonce: u64,
    }

    struct DepositReceived has copy, drop {
        receiver: address,
        from: address,
        amount: u64,
    }

    struct Swept has copy, drop {
        receiver: address,
        caller: address,
        gross: u64,
        net: u64,
        total_fee: u64,
        sentinel_fee: u64,
        cctp_max_fee: u64,
        bean_min_fee: u64,
        cross_chain: bool,
    }

    struct CrossChainBurnRequested has copy, drop {
        receiver: address,
        bridge_custodian: address,
        dst_domain: u32,
        burn_amount: u64,
        net: u64,
        threshold: u64,
        cctp_max_fee: u64,
        hook_target: address,
    }

    struct CctpBurnTicket<phantom T0> {
        coin: 0x2::coin::Coin<T0>,
        receiver: address,
        dst_domain: u32,
        mint_recipient: address,
        hook_target: address,
        burn_amount: u64,
        net: u64,
        cctp_max_fee: u64,
        threshold: u64,
        hook_data: vector<u8>,
    }

    struct FeesFlushed has copy, drop {
        receiver: address,
        amount: u64,
        to_a: u64,
        to_b: u64,
        to_ref: u64,
        referrer: address,
    }

    struct CctpThresholdUpdated has copy, drop {
        receiver: address,
        old_threshold: u64,
        new_threshold: u64,
    }

    struct Recovered has copy, drop {
        receiver: address,
        to: address,
        amount: u64,
    }

    public fun cctp_threshold<T0>(arg0: &Receiver<T0>) : u64 {
        arg0.cctp_threshold
    }

    public fun deploy<T0>(arg0: &mut 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::Factory<T0>, arg1: address, arg2: u8, arg3: u32, arg4: address, arg5: vector<u8>, arg6: address, arg7: address, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 2);
        assert!(arg4 != @0x0 || 0x1::vector::length<u8>(&arg5) > 0, 3);
        assert!(arg2 == 0 || arg2 == 1, 4);
        assert!(0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::valid_threshold(arg8), 5);
        0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::assert_referrer_approved<T0>(arg0, arg7);
        let v0 = 0x2::object::new(arg9);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::total_deployed<T0>(arg0) + 1;
        0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::record_receiver_deployed<T0>(arg0);
        0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::mark_sponsored_owner<T0>(arg0, arg1);
        0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::mark_receiver<T0>(arg0, v1);
        let v3 = Receiver<T0>{
            id             : v0,
            owner          : arg1,
            mode           : arg2,
            dst_domain     : arg3,
            dst_recipient  : arg4,
            cctp_recipient : arg5,
            hook_target    : arg6,
            referrer       : arg7,
            balance        : 0x2::balance::zero<T0>(),
            fee_accrued    : 0,
            cctp_threshold : arg8,
            deploy_nonce   : v2,
        };
        0x2::transfer::share_object<Receiver<T0>>(v3);
        let v4 = ReceiverDeployed{
            receiver      : v1,
            owner         : arg1,
            mode          : arg2,
            dst_domain    : arg3,
            dst_recipient : arg4,
            hook_target   : arg6,
            referrer      : arg7,
            deploy_nonce  : v2,
        };
        0x2::event::emit<ReceiverDeployed>(v4);
    }

    public fun deposit<T0>(arg0: &mut Receiver<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = DepositReceived{
            receiver : 0x2::object::uid_to_address(&arg0.id),
            from     : 0x2::tx_context::sender(arg2),
            amount   : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<DepositReceived>(v0);
    }

    public fun dst_domain<T0>(arg0: &Receiver<T0>) : u32 {
        arg0.dst_domain
    }

    public fun dst_recipient<T0>(arg0: &Receiver<T0>) : address {
        arg0.dst_recipient
    }

    public fun fee_accrued<T0>(arg0: &Receiver<T0>) : u64 {
        arg0.fee_accrued
    }

    fun flush_all<T0>(arg0: &mut 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::Factory<T0>, arg1: &mut Receiver<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.fee_accrued;
        if (v0 == 0) {
            return
        };
        arg1.fee_accrued = 0;
        let (v1, v2, v3) = 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::split_protocol_fees<T0>(arg0, v0, arg1.referrer);
        0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::escrow_receiver_fee<T0>(arg0, 0x2::balance::split<T0>(&mut arg1.balance, v0), arg1.referrer);
        let v4 = FeesFlushed{
            receiver : 0x2::object::uid_to_address(&arg1.id),
            amount   : v0,
            to_a     : v1,
            to_b     : v2,
            to_ref   : v3,
            referrer : arg1.referrer,
        };
        0x2::event::emit<FeesFlushed>(v4);
    }

    public fun flush_fees<T0>(arg0: &mut 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::Factory<T0>, arg1: &mut Receiver<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        flush_all<T0>(arg0, arg1, arg2);
    }

    public fun hook_target<T0>(arg0: &Receiver<T0>) : address {
        arg0.hook_target
    }

    fun maybe_flush<T0>(arg0: &mut 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::Factory<T0>, arg1: &mut Receiver<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1.fee_accrued >= arg2) {
            flush_all<T0>(arg0, arg1, arg3);
        };
    }

    public fun mode<T0>(arg0: &Receiver<T0>) : u8 {
        arg0.mode
    }

    public fun owner<T0>(arg0: &Receiver<T0>) : address {
        arg0.owner
    }

    fun pay_if_nonzero<T0>(arg0: &mut Receiver<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg3), arg1);
    }

    public fun pending_balance<T0>(arg0: &Receiver<T0>) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        if (v0 > arg0.fee_accrued) {
            v0 - arg0.fee_accrued
        } else {
            0
        }
    }

    public fun prepare_cctp_burn<T0>(arg0: &mut 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::Factory<T0>, arg1: &mut Receiver<T0>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : CctpBurnTicket<T0> {
        assert!(arg1.dst_domain != 0, 8);
        assert!(!0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::memo::is_expired(&arg2, 0x2::clock::timestamp_ms(arg3) / 1000), 6);
        let v0 = pending_balance<T0>(arg1);
        assert!(v0 > 0, 7);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = v1 == arg1.owner;
        let v3 = if (v2) {
            0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::zero_fees<T0>(arg0, 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::is_fast_threshold(arg1.cctp_threshold))
        } else {
            0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::fees_for<T0>(arg0, v0, arg1.dst_domain, 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::is_fast_threshold(arg1.cctp_threshold))
        };
        let v4 = v3;
        let v5 = v0 - 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::total_fee(&v4);
        if (!v2) {
            arg1.fee_accrued = arg1.fee_accrued + 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::bean_min_fee(&v4);
            maybe_flush<T0>(arg0, arg1, 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::flush_threshold(&v4), arg4);
            pay_if_nonzero<T0>(arg1, v1, 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::sentinel_fee(&v4), arg4);
        };
        let v6 = 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::cctp_max_fee(&v4);
        let v7 = v5 + v6;
        let v8 = 0x2::object::uid_to_address(&arg1.id);
        let v9 = Swept{
            receiver     : v8,
            caller       : v1,
            gross        : v0,
            net          : v5,
            total_fee    : 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::total_fee(&v4),
            sentinel_fee : 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::sentinel_fee(&v4),
            cctp_max_fee : v6,
            bean_min_fee : 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::bean_min_fee(&v4),
            cross_chain  : true,
        };
        0x2::event::emit<Swept>(v9);
        CctpBurnTicket<T0>{
            coin           : 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v7), arg4),
            receiver       : v8,
            dst_domain     : arg1.dst_domain,
            mint_recipient : 0x2::address::from_bytes(arg1.cctp_recipient),
            hook_target    : arg1.hook_target,
            burn_amount    : v7,
            net            : v5,
            cctp_max_fee   : v6,
            threshold      : 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::threshold(&v4),
            hook_data      : 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::hook_data::encode(v8, v5, arg2),
        }
    }

    public fun receiver_balance<T0>(arg0: &Receiver<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun recover_available<T0>(arg0: &mut Receiver<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        assert!(arg1 != @0x0, 2);
        assert!(arg2 <= pending_balance<T0>(arg0), 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg3), arg1);
        let v0 = Recovered{
            receiver : 0x2::object::uid_to_address(&arg0.id),
            to       : arg1,
            amount   : arg2,
        };
        0x2::event::emit<Recovered>(v0);
    }

    public fun referrer<T0>(arg0: &Receiver<T0>) : address {
        arg0.referrer
    }

    public fun set_cctp_threshold<T0>(arg0: &mut Receiver<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::valid_threshold(arg1), 5);
        arg0.cctp_threshold = arg1;
        let v0 = CctpThresholdUpdated{
            receiver      : 0x2::object::uid_to_address(&arg0.id),
            old_threshold : arg0.cctp_threshold,
            new_threshold : arg1,
        };
        0x2::event::emit<CctpThresholdUpdated>(v0);
    }

    fun settle_same_chain_to_coin<T0>(arg0: &mut 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::Factory<T0>, arg1: &mut Receiver<T0>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::memo::is_expired(&arg2, 0x2::clock::timestamp_ms(arg3) / 1000), 6);
        let v0 = pending_balance<T0>(arg1);
        assert!(v0 > 0, 7);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = v1 == arg1.owner;
        let v3 = if (v2) {
            0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::zero_fees<T0>(arg0, 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::is_fast_threshold(arg1.cctp_threshold))
        } else {
            0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::fees_for<T0>(arg0, v0, arg1.dst_domain, 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::is_fast_threshold(arg1.cctp_threshold))
        };
        let v4 = v3;
        let v5 = v0 - 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::total_fee(&v4);
        if (!v2) {
            arg1.fee_accrued = arg1.fee_accrued + 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::bean_min_fee(&v4);
            maybe_flush<T0>(arg0, arg1, 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::flush_threshold(&v4), arg4);
            pay_if_nonzero<T0>(arg1, v1, 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::sentinel_fee(&v4), arg4);
        };
        let v6 = Swept{
            receiver     : 0x2::object::uid_to_address(&arg1.id),
            caller       : v1,
            gross        : v0,
            net          : v5,
            total_fee    : 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::total_fee(&v4),
            sentinel_fee : 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::sentinel_fee(&v4),
            cctp_max_fee : 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::cctp_max_fee(&v4),
            bean_min_fee : 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::bean_min_fee(&v4),
            cross_chain  : false,
        };
        0x2::event::emit<Swept>(v6);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v5), arg4)
    }

    public fun sweep<T0>(arg0: &mut 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::Factory<T0>, arg1: &mut Receiver<T0>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.dst_domain == 0, 9);
        assert!(!0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::memo::is_expired(&arg2, 0x2::clock::timestamp_ms(arg3) / 1000), 6);
        let v0 = pending_balance<T0>(arg1);
        assert!(v0 > 0, 7);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = v1 == arg1.owner;
        let v3 = if (v2) {
            0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::zero_fees<T0>(arg0, 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::is_fast_threshold(arg1.cctp_threshold))
        } else {
            0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::fees_for<T0>(arg0, v0, arg1.dst_domain, 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::is_fast_threshold(arg1.cctp_threshold))
        };
        let v4 = v3;
        let v5 = 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::total_fee(&v4);
        let v6 = v0 - v5;
        if (!v2) {
            arg1.fee_accrued = arg1.fee_accrued + 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::bean_min_fee(&v4);
            maybe_flush<T0>(arg0, arg1, 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::flush_threshold(&v4), arg4);
            pay_if_nonzero<T0>(arg1, v1, 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::sentinel_fee(&v4), arg4);
            0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::record_owner_sponsor_settlement<T0>(arg0, arg1.owner, v6, v5);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v6), arg4), arg1.dst_recipient);
        let v7 = Swept{
            receiver     : 0x2::object::uid_to_address(&arg1.id),
            caller       : v1,
            gross        : v0,
            net          : v6,
            total_fee    : v5,
            sentinel_fee : 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::sentinel_fee(&v4),
            cctp_max_fee : 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::cctp_max_fee(&v4),
            bean_min_fee : 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::bean_min_fee(&v4),
            cross_chain  : false,
        };
        0x2::event::emit<Swept>(v7);
    }

    public fun sweep_cross_chain<T0>(arg0: &mut 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::Factory<T0>, arg1: &mut Receiver<T0>, arg2: address, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 2);
        let v0 = 0x2::tx_context::sender(arg5) == arg1.owner;
        let v1 = pending_balance<T0>(arg1);
        let v2 = if (v0) {
            0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::zero_fees<T0>(arg0, 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::is_fast_threshold(arg1.cctp_threshold))
        } else {
            0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::fees_for<T0>(arg0, v1, arg1.dst_domain, 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::is_fast_threshold(arg1.cctp_threshold))
        };
        let v3 = v2;
        let v4 = 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::total_fee(&v3);
        let v5 = v1 - v4;
        let v6 = prepare_cctp_burn<T0>(arg0, arg1, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(ticket_into_coin<T0>(v6), arg2);
        if (!v0) {
            0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::record_owner_sponsor_settlement<T0>(arg0, arg1.owner, v5, v4);
        };
        let v7 = CrossChainBurnRequested{
            receiver         : 0x2::object::uid_to_address(&arg1.id),
            bridge_custodian : arg2,
            dst_domain       : arg1.dst_domain,
            burn_amount      : ticket_burn_amount<T0>(&v6),
            net              : v5,
            threshold        : 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::threshold(&v3),
            cctp_max_fee     : 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::cctp_max_fee(&v3),
            hook_target      : arg1.hook_target,
        };
        0x2::event::emit<CrossChainBurnRequested>(v7);
    }

    public fun sweep_to_passthrough_router<T0>(arg0: &mut 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::Factory<T0>, arg1: &mut Receiver<T0>, arg2: &mut 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::routers::PassthroughRouter<T0>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.dst_domain == 0, 9);
        assert!(arg1.dst_recipient == 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::routers::passthrough_address<T0>(arg2), 11);
        let v0 = settle_same_chain_to_coin<T0>(arg0, arg1, arg3, arg4, arg5);
        0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::routers::deposit_passthrough<T0>(arg2, v0);
        0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::routers::execute_passthrough<T0>(arg2, arg5);
    }

    public fun sweep_to_split_router<T0>(arg0: &mut 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory::Factory<T0>, arg1: &mut Receiver<T0>, arg2: &mut 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::routers::SplitRouter<T0>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.dst_domain == 0, 9);
        assert!(arg1.dst_recipient == 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::routers::split_address<T0>(arg2), 11);
        let v0 = settle_same_chain_to_coin<T0>(arg0, arg1, arg3, arg4, arg5);
        0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::routers::deposit_split<T0>(arg2, v0);
        0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::routers::execute_split<T0>(arg2, arg5);
    }

    public fun ticket_burn_amount<T0>(arg0: &CctpBurnTicket<T0>) : u64 {
        arg0.burn_amount
    }

    public fun ticket_cctp_max_fee<T0>(arg0: &CctpBurnTicket<T0>) : u64 {
        arg0.cctp_max_fee
    }

    public fun ticket_dst_domain<T0>(arg0: &CctpBurnTicket<T0>) : u32 {
        arg0.dst_domain
    }

    public fun ticket_hook_data<T0>(arg0: &CctpBurnTicket<T0>) : vector<u8> {
        arg0.hook_data
    }

    public fun ticket_hook_target<T0>(arg0: &CctpBurnTicket<T0>) : address {
        arg0.hook_target
    }

    public fun ticket_into_coin<T0>(arg0: CctpBurnTicket<T0>) : 0x2::coin::Coin<T0> {
        let CctpBurnTicket {
            coin           : v0,
            receiver       : _,
            dst_domain     : _,
            mint_recipient : _,
            hook_target    : _,
            burn_amount    : _,
            net            : _,
            cctp_max_fee   : _,
            threshold      : _,
            hook_data      : _,
        } = arg0;
        v0
    }

    public fun ticket_mint_recipient<T0>(arg0: &CctpBurnTicket<T0>) : address {
        arg0.mint_recipient
    }

    public fun ticket_net<T0>(arg0: &CctpBurnTicket<T0>) : u64 {
        arg0.net
    }

    public fun ticket_receiver<T0>(arg0: &CctpBurnTicket<T0>) : address {
        arg0.receiver
    }

    public fun ticket_threshold<T0>(arg0: &CctpBurnTicket<T0>) : u64 {
        arg0.threshold
    }

    public fun uid_ref<T0>(arg0: &Receiver<T0>) : &0x2::object::UID {
        &arg0.id
    }

    // decompiled from Move bytecode v7
}

