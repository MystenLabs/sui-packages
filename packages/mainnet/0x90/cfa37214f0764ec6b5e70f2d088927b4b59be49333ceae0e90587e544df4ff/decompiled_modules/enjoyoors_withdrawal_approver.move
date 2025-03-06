module 0x90cfa37214f0764ec6b5e70f2d088927b4b59be49333ceae0e90587e544df4ff::enjoyoors_withdrawal_approver {
    struct ENJOYOORS_WITHDRAWAL_APPROVER has drop {
        dummy_field: bool,
    }

    struct WithdrawalApproverConfig has store, key {
        id: 0x2::object::UID,
        withdrawal_period_ms: u64,
        admin: address,
        pending_admin: 0x1::option::Option<address>,
    }

    struct ApprovedClaims has store, key {
        id: 0x2::object::UID,
        approved_claims: 0x2::table::Table<u64, bool>,
    }

    struct Initialized has copy, drop {
        config_id: 0x2::object::ID,
        approved_claims_id: 0x2::object::ID,
        approved_claims_table_id: 0x2::object::ID,
    }

    struct WithdrawalPeriodChanged has copy, drop {
        old: u64,
        new: u64,
    }

    struct AdminRightsAccepted has copy, drop {
        by: address,
    }

    struct AdminRightsTransfer has copy, drop {
        from: address,
        to: address,
    }

    struct AdminRightsTransferCanceled has copy, drop {
        dummy_field: bool,
    }

    public fun accept_admin(arg0: &mut WithdrawalApproverConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg0.pending_admin), 77700);
        let v0 = *0x1::option::borrow<address>(&arg0.pending_admin);
        assert!(v0 == 0x2::tx_context::sender(arg1), 77700);
        arg0.admin = v0;
        arg0.pending_admin = 0x1::option::none<address>();
        let v1 = AdminRightsAccepted{by: 0x2::tx_context::sender(arg1)};
        0x2::event::emit<AdminRightsAccepted>(v1);
    }

    public fun cancel_admin_transfer(arg0: &mut WithdrawalApproverConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 77700);
        assert!(0x1::option::is_some<address>(&arg0.pending_admin), 77720);
        arg0.pending_admin = 0x1::option::none<address>();
        let v0 = AdminRightsTransferCanceled{dummy_field: false};
        0x2::event::emit<AdminRightsTransferCanceled>(v0);
    }

    public fun change_withdrawal_period(arg0: &mut WithdrawalApproverConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 77700);
        arg0.withdrawal_period_ms = arg1;
        let v0 = WithdrawalPeriodChanged{
            old : arg0.withdrawal_period_ms,
            new : arg1,
        };
        0x2::event::emit<WithdrawalPeriodChanged>(v0);
    }

    public fun claim_withdrawal<T0>(arg0: &WithdrawalApproverConfig, arg1: &mut ApprovedClaims, arg2: &0x2::clock::Clock, arg3: &mut 0x4e4c16d833abe593b81ebffb232e0798876b848fb2b55afef787c94db122edd4::enjoyoors_vault::VaultConfig, arg4: &mut 0x4e4c16d833abe593b81ebffb232e0798876b848fb2b55afef787c94db122edd4::enjoyoors_vault::WithdrawalStats, arg5: &mut 0x4e4c16d833abe593b81ebffb232e0798876b848fb2b55afef787c94db122edd4::enjoyoors_vault::CoinDepositsStorage<T0>, arg6: u64, arg7: 0x2::object::ID, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x4e4c16d833abe593b81ebffb232e0798876b848fb2b55afef787c94db122edd4::enjoyoors_vault::get_withdrawal_request_timestamp(0x4e4c16d833abe593b81ebffb232e0798876b848fb2b55afef787c94db122edd4::enjoyoors_vault::get_withdrawal_request_by_id(arg4, &arg6)) + arg0.withdrawal_period_ms <= 0x2::clock::timestamp_ms(arg2), 77718);
        0x2::table::add<u64, bool>(&mut arg1.approved_claims, arg6, true);
        0x4e4c16d833abe593b81ebffb232e0798876b848fb2b55afef787c94db122edd4::enjoyoors_vault::finalize_withdrawal<T0>(arg3, arg4, arg5, arg6, arg7, &arg1.approved_claims, arg8);
    }

    fun init(arg0: ENJOYOORS_WITHDRAWAL_APPROVER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<ENJOYOORS_WITHDRAWAL_APPROVER>(arg0, arg1);
        let v0 = WithdrawalApproverConfig{
            id                   : 0x2::object::new(arg1),
            withdrawal_period_ms : 0,
            admin                : 0x2::tx_context::sender(arg1),
            pending_admin        : 0x1::option::none<address>(),
        };
        let v1 = ApprovedClaims{
            id              : 0x2::object::new(arg1),
            approved_claims : 0x2::table::new<u64, bool>(arg1),
        };
        let v2 = Initialized{
            config_id                : 0x2::object::id<WithdrawalApproverConfig>(&v0),
            approved_claims_id       : 0x2::object::id<ApprovedClaims>(&v1),
            approved_claims_table_id : 0x2::object::id<0x2::table::Table<u64, bool>>(&v1.approved_claims),
        };
        0x2::event::emit<Initialized>(v2);
        0x2::transfer::share_object<WithdrawalApproverConfig>(v0);
        0x2::transfer::share_object<ApprovedClaims>(v1);
    }

    public fun transfer_admin(arg0: &mut WithdrawalApproverConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 77700);
        assert!(0x2::tx_context::sender(arg2) != arg1, 77719);
        assert!(0x1::option::is_none<address>(&arg0.pending_admin), 77721);
        arg0.pending_admin = 0x1::option::some<address>(arg1);
        let v0 = AdminRightsTransfer{
            from : 0x2::tx_context::sender(arg2),
            to   : arg1,
        };
        0x2::event::emit<AdminRightsTransfer>(v0);
    }

    // decompiled from Move bytecode v6
}

