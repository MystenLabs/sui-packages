module 0xc10d536b6580d809711b9bb8eee3945d5e96f92a346c84d74ff7a0697e664695::treasury {
    struct Treasury has store, key {
        id: 0x2::object::UID,
        allowed_versions: 0x2::vec_set::VecSet<u16>,
        disabled_versions: 0x2::vec_set::VecSet<u16>,
        deep_reserves: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
        deep_reserves_coverage_fees: 0x2::bag::Bag,
        protocol_fees: 0x2::bag::Bag,
    }

    struct ChargedFeeKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct DeepReservesWithdrawn<phantom T0> has copy, drop {
        treasury_id: 0x2::object::ID,
        amount: u64,
    }

    struct CoverageFeeWithdrawn<phantom T0> has copy, drop {
        treasury_id: 0x2::object::ID,
        amount: u64,
    }

    struct ProtocolFeeWithdrawn<phantom T0> has copy, drop {
        treasury_id: 0x2::object::ID,
        amount: u64,
    }

    struct DeepReservesDeposited<phantom T0> has copy, drop {
        treasury_id: 0x2::object::ID,
        amount: u64,
    }

    struct VersionEnabled has copy, drop {
        treasury_id: 0x2::object::ID,
        version: u16,
    }

    struct VersionDisabled has copy, drop {
        treasury_id: 0x2::object::ID,
        version: u16,
    }

    public fun deep_reserves(arg0: &Treasury) : u64 {
        0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.deep_reserves)
    }

    public fun deposit_into_reserves(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        verify_version(arg0);
        if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg1) == 0) {
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1);
            return
        };
        let v0 = DeepReservesDeposited<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>{
            treasury_id : 0x2::object::uid_to_inner(&arg0.id),
            amount      : 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg1),
        };
        0x2::event::emit<DeepReservesDeposited<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v0);
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_reserves, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1));
    }

    public fun disable_version(arg0: &mut Treasury, arg1: &0xc10d536b6580d809711b9bb8eee3945d5e96f92a346c84d74ff7a0697e664695::multisig_config::MultisigConfig, arg2: &0xc10d536b6580d809711b9bb8eee3945d5e96f92a346c84d74ff7a0697e664695::admin::AdminCap, arg3: u16, arg4: &mut 0x2::tx_context::TxContext) {
        0xc10d536b6580d809711b9bb8eee3945d5e96f92a346c84d74ff7a0697e664695::multisig_config::validate_sender_is_admin_multisig(arg1, arg4);
        assert!(arg3 <= 0xc10d536b6580d809711b9bb8eee3945d5e96f92a346c84d74ff7a0697e664695::helper::current_version(), 3);
        assert!(0x2::vec_set::contains<u16>(&arg0.allowed_versions, &arg3), 4);
        0x2::vec_set::remove<u16>(&mut arg0.allowed_versions, &arg3);
        0x2::vec_set::insert<u16>(&mut arg0.disabled_versions, arg3);
        let v0 = VersionDisabled{
            treasury_id : 0x2::object::uid_to_inner(&arg0.id),
            version     : arg3,
        };
        0x2::event::emit<VersionDisabled>(v0);
    }

    public fun enable_version(arg0: &mut Treasury, arg1: &0xc10d536b6580d809711b9bb8eee3945d5e96f92a346c84d74ff7a0697e664695::multisig_config::MultisigConfig, arg2: &0xc10d536b6580d809711b9bb8eee3945d5e96f92a346c84d74ff7a0697e664695::admin::AdminCap, arg3: u16, arg4: &mut 0x2::tx_context::TxContext) {
        0xc10d536b6580d809711b9bb8eee3945d5e96f92a346c84d74ff7a0697e664695::multisig_config::validate_sender_is_admin_multisig(arg1, arg4);
        assert!(!0x2::vec_set::contains<u16>(&arg0.disabled_versions, &arg3), 6);
        assert!(!0x2::vec_set::contains<u16>(&arg0.allowed_versions, &arg3), 2);
        0x2::vec_set::insert<u16>(&mut arg0.allowed_versions, arg3);
        let v0 = VersionEnabled{
            treasury_id : 0x2::object::uid_to_inner(&arg0.id),
            version     : arg3,
        };
        0x2::event::emit<VersionEnabled>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id                          : 0x2::object::new(arg0),
            allowed_versions            : 0x2::vec_set::singleton<u16>(0xc10d536b6580d809711b9bb8eee3945d5e96f92a346c84d74ff7a0697e664695::helper::current_version()),
            disabled_versions           : 0x2::vec_set::empty<u16>(),
            deep_reserves               : 0x2::balance::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(),
            deep_reserves_coverage_fees : 0x2::bag::new(arg0),
            protocol_fees               : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    public(friend) fun join_coverage_fee<T0>(arg0: &mut Treasury, arg1: 0x2::balance::Balance<T0>) {
        verify_version(arg0);
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = ChargedFeeKey<T0>{dummy_field: false};
        if (0x2::bag::contains<ChargedFeeKey<T0>>(&arg0.deep_reserves_coverage_fees, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<ChargedFeeKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.deep_reserves_coverage_fees, v0), arg1);
        } else {
            0x2::bag::add<ChargedFeeKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.deep_reserves_coverage_fees, v0, arg1);
        };
    }

    public(friend) fun join_protocol_fee<T0>(arg0: &mut Treasury, arg1: 0x2::balance::Balance<T0>) {
        verify_version(arg0);
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = ChargedFeeKey<T0>{dummy_field: false};
        if (0x2::bag::contains<ChargedFeeKey<T0>>(&arg0.protocol_fees, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<ChargedFeeKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.protocol_fees, v0), arg1);
        } else {
            0x2::bag::add<ChargedFeeKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.protocol_fees, v0, arg1);
        };
    }

    public(friend) fun split_deep_reserves(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        verify_version(arg0);
        assert!(arg1 <= 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.deep_reserves), 1);
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_reserves, arg1), arg2)
    }

    public(friend) fun verify_version(arg0: &Treasury) {
        let v0 = 0xc10d536b6580d809711b9bb8eee3945d5e96f92a346c84d74ff7a0697e664695::helper::current_version();
        assert!(0x2::vec_set::contains<u16>(&arg0.allowed_versions, &v0), 5);
    }

    public fun withdraw_coverage_fee<T0>(arg0: &mut Treasury, arg1: 0xc10d536b6580d809711b9bb8eee3945d5e96f92a346c84d74ff7a0697e664695::ticket::AdminTicket, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        verify_version(arg0);
        0xc10d536b6580d809711b9bb8eee3945d5e96f92a346c84d74ff7a0697e664695::ticket::validate_ticket(&arg1, 0xc10d536b6580d809711b9bb8eee3945d5e96f92a346c84d74ff7a0697e664695::ticket::withdraw_coverage_fee_ticket_type(), arg2, arg3);
        0xc10d536b6580d809711b9bb8eee3945d5e96f92a346c84d74ff7a0697e664695::ticket::destroy_ticket(arg1, arg2);
        let v0 = ChargedFeeKey<T0>{dummy_field: false};
        if (0x2::bag::contains<ChargedFeeKey<T0>>(&arg0.deep_reserves_coverage_fees, v0)) {
            let v2 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<ChargedFeeKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.deep_reserves_coverage_fees, v0)), arg3);
            let v3 = CoverageFeeWithdrawn<T0>{
                treasury_id : 0x2::object::uid_to_inner(&arg0.id),
                amount      : 0x2::coin::value<T0>(&v2),
            };
            0x2::event::emit<CoverageFeeWithdrawn<T0>>(v3);
            v2
        } else {
            0x2::coin::zero<T0>(arg3)
        }
    }

    public fun withdraw_deep_reserves(arg0: &mut Treasury, arg1: 0xc10d536b6580d809711b9bb8eee3945d5e96f92a346c84d74ff7a0697e664695::ticket::AdminTicket, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        verify_version(arg0);
        0xc10d536b6580d809711b9bb8eee3945d5e96f92a346c84d74ff7a0697e664695::ticket::validate_ticket(&arg1, 0xc10d536b6580d809711b9bb8eee3945d5e96f92a346c84d74ff7a0697e664695::ticket::withdraw_deep_reserves_ticket_type(), arg3, arg4);
        0xc10d536b6580d809711b9bb8eee3945d5e96f92a346c84d74ff7a0697e664695::ticket::destroy_ticket(arg1, arg3);
        let v0 = split_deep_reserves(arg0, arg2, arg4);
        let v1 = DeepReservesWithdrawn<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>{
            treasury_id : 0x2::object::uid_to_inner(&arg0.id),
            amount      : arg2,
        };
        0x2::event::emit<DeepReservesWithdrawn<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v1);
        v0
    }

    public fun withdraw_protocol_fee<T0>(arg0: &mut Treasury, arg1: 0xc10d536b6580d809711b9bb8eee3945d5e96f92a346c84d74ff7a0697e664695::ticket::AdminTicket, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        verify_version(arg0);
        0xc10d536b6580d809711b9bb8eee3945d5e96f92a346c84d74ff7a0697e664695::ticket::validate_ticket(&arg1, 0xc10d536b6580d809711b9bb8eee3945d5e96f92a346c84d74ff7a0697e664695::ticket::withdraw_protocol_fee_ticket_type(), arg2, arg3);
        0xc10d536b6580d809711b9bb8eee3945d5e96f92a346c84d74ff7a0697e664695::ticket::destroy_ticket(arg1, arg2);
        let v0 = ChargedFeeKey<T0>{dummy_field: false};
        if (0x2::bag::contains<ChargedFeeKey<T0>>(&arg0.protocol_fees, v0)) {
            let v2 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<ChargedFeeKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.protocol_fees, v0)), arg3);
            let v3 = ProtocolFeeWithdrawn<T0>{
                treasury_id : 0x2::object::uid_to_inner(&arg0.id),
                amount      : 0x2::coin::value<T0>(&v2),
            };
            0x2::event::emit<ProtocolFeeWithdrawn<T0>>(v3);
            v2
        } else {
            0x2::coin::zero<T0>(arg3)
        }
    }

    // decompiled from Move bytecode v6
}

