module 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::insurance_fund {
    struct InsuranceFund has store {
        perp_id: 0x2::object::ID,
        active_account: address,
        security_account: address,
        transfer_interval: u64,
        transfer_amount_limit: u128,
        last_transfer_time: u64,
    }

    struct InsuranceFundUpdateActiveAccountEvent has copy, drop {
        perp_id: 0x2::object::ID,
        account: address,
    }

    struct InsuranceFundUpdateSecurityAccountEvent has copy, drop {
        perp_id: 0x2::object::ID,
        account: address,
    }

    struct InsuranceFundUpdateTransferIntervalEvent has copy, drop {
        perp_id: 0x2::object::ID,
        transfer_interval: u64,
    }

    struct InsuranceFundUpdateTransferAmountLimitEvent has copy, drop {
        perp_id: 0x2::object::ID,
        transfer_amount_limit: u128,
    }

    struct InsuranceFundCreateEvent has copy, drop {
        perp_id: 0x2::object::ID,
        active_account: address,
        security_account: address,
        transfer_interval: u64,
        transfer_amount_limit: u128,
    }

    struct InsuranceFundTransferEvent has copy, drop {
        perp_id: 0x2::object::ID,
        from_security_account: bool,
        amount: u128,
        timestamp: u64,
    }

    public(friend) fun active_account(arg0: &InsuranceFund) : address {
        arg0.active_account
    }

    public(friend) fun create_insurance_fund(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u128) : InsuranceFund {
        assert!(arg1 != @0x0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::address_cannot_be_zero());
        assert!(arg2 != @0x0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::address_cannot_be_zero());
        assert!(arg1 != arg2, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::insurance_fund_active_account_can_not_be_same_as_security_account());
        assert!(arg3 > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::insurance_fund_transfer_interval_not_met());
        assert!(arg4 > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::insurance_fund_transfer_amount_must_be_greater_than_zero());
        let v0 = InsuranceFund{
            perp_id               : arg0,
            active_account        : arg1,
            security_account      : arg2,
            transfer_interval     : arg3,
            transfer_amount_limit : arg4,
            last_transfer_time    : 0,
        };
        let v1 = InsuranceFundCreateEvent{
            perp_id               : arg0,
            active_account        : arg1,
            security_account      : arg2,
            transfer_interval     : arg3,
            transfer_amount_limit : arg4,
        };
        0x2::event::emit<InsuranceFundCreateEvent>(v1);
        v0
    }

    public(friend) fun last_transfer_time(arg0: &InsuranceFund) : u64 {
        arg0.last_transfer_time
    }

    public(friend) fun perp_id(arg0: &InsuranceFund) : 0x2::object::ID {
        arg0.perp_id
    }

    public(friend) fun security_account(arg0: &InsuranceFund) : address {
        arg0.security_account
    }

    public(friend) fun set_active_account(arg0: &mut InsuranceFund, arg1: address) {
        assert!(arg1 != @0x0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::address_cannot_be_zero());
        assert!(arg1 != arg0.security_account, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::insurance_fund_active_account_can_not_be_same_as_security_account());
        arg0.active_account = arg1;
        let v0 = InsuranceFundUpdateActiveAccountEvent{
            perp_id : arg0.perp_id,
            account : arg1,
        };
        0x2::event::emit<InsuranceFundUpdateActiveAccountEvent>(v0);
    }

    public(friend) fun set_amount_limit(arg0: &mut InsuranceFund, arg1: u128) {
        assert!(arg1 > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::insurance_fund_transfer_amount_must_be_greater_than_zero());
        arg0.transfer_amount_limit = arg1;
        let v0 = InsuranceFundUpdateTransferAmountLimitEvent{
            perp_id               : arg0.perp_id,
            transfer_amount_limit : arg1,
        };
        0x2::event::emit<InsuranceFundUpdateTransferAmountLimitEvent>(v0);
    }

    public(friend) fun set_security_account(arg0: &mut InsuranceFund, arg1: address) {
        assert!(arg1 != @0x0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::address_cannot_be_zero());
        assert!(arg1 != arg0.active_account, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::insurance_fund_active_account_can_not_be_same_as_security_account());
        arg0.security_account = arg1;
        let v0 = InsuranceFundUpdateSecurityAccountEvent{
            perp_id : arg0.perp_id,
            account : arg1,
        };
        0x2::event::emit<InsuranceFundUpdateSecurityAccountEvent>(v0);
    }

    public(friend) fun set_transfer_interval(arg0: &mut InsuranceFund, arg1: u64) {
        assert!(arg1 > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::insurance_fund_transfer_interval_not_met());
        arg0.transfer_interval = arg1;
        let v0 = InsuranceFundUpdateTransferIntervalEvent{
            perp_id           : arg0.perp_id,
            transfer_interval : arg1,
        };
        0x2::event::emit<InsuranceFundUpdateTransferIntervalEvent>(v0);
    }

    public(friend) fun transfer_amount_limit(arg0: &InsuranceFund) : u128 {
        arg0.transfer_amount_limit
    }

    public(friend) fun transfer_from_active_to_security<T0>(arg0: &InsuranceFund, arg1: &0x2::clock::Clock, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg3: u128, arg4: u128) {
        assert!(arg3 > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::insurance_fund_transfer_amount_must_be_greater_than_zero());
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg2, arg0.active_account, arg0.security_account, arg3, 0, arg4);
        let v0 = InsuranceFundTransferEvent{
            perp_id               : arg0.perp_id,
            from_security_account : false,
            amount                : arg3,
            timestamp             : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<InsuranceFundTransferEvent>(v0);
    }

    public(friend) fun transfer_from_security_to_active<T0>(arg0: &mut InsuranceFund, arg1: &0x2::clock::Clock, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg3: u128, arg4: u128) {
        assert!(arg3 > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::insurance_fund_transfer_amount_must_be_greater_than_zero());
        assert!(arg3 <= arg0.transfer_amount_limit, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::insurance_fund_transfer_amount_exceeds_limit());
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (arg0.last_transfer_time > 0) {
            assert!(v0 - arg0.last_transfer_time >= arg0.transfer_interval, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::insurance_fund_transfer_interval_not_met());
        };
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg2, arg0.security_account, arg0.active_account, arg3, 0, arg4);
        arg0.last_transfer_time = v0;
        let v1 = InsuranceFundTransferEvent{
            perp_id               : arg0.perp_id,
            from_security_account : true,
            amount                : arg3,
            timestamp             : v0,
        };
        0x2::event::emit<InsuranceFundTransferEvent>(v1);
    }

    public(friend) fun transfer_interval(arg0: &InsuranceFund) : u64 {
        arg0.transfer_interval
    }

    // decompiled from Move bytecode v6
}

