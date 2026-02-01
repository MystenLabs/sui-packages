module 0xd17ca794f5f95f4915a6afe8e45bb60596ea411014751a1ab97565bd5bd578cb::treasury {
    struct TreasuryCreated has copy, drop {
        treasury_id: 0x2::object::ID,
        admin: address,
        fee_bps: u64,
        created_at: u64,
    }

    struct TreasuryDeposit has copy, drop {
        treasury_id: 0x2::object::ID,
        amount: u64,
        total_collected: u64,
    }

    struct TreasuryWithdrawal has copy, drop {
        treasury_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
        total_withdrawn: u64,
    }

    struct TreasuryFeeProposed has copy, drop {
        treasury_id: 0x2::object::ID,
        current_fee_bps: u64,
        proposed_fee_bps: u64,
        effective_at: u64,
    }

    struct TreasuryFeeUpdated has copy, drop {
        treasury_id: 0x2::object::ID,
        old_fee_bps: u64,
        new_fee_bps: u64,
    }

    struct TreasuryAdminProposed has copy, drop {
        treasury_id: 0x2::object::ID,
        current_admin: address,
        proposed_admin: address,
    }

    struct TreasuryAdminTransferred has copy, drop {
        treasury_id: 0x2::object::ID,
        old_admin: address,
        new_admin: address,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        pending_admin: 0x1::option::Option<address>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_collected: u64,
        total_withdrawn: u64,
        fee_bps: u64,
        pending_fee_bps: 0x1::option::Option<u64>,
        fee_change_timestamp: 0x1::option::Option<u64>,
        created_at: u64,
    }

    public fun balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun id(arg0: &Treasury) : 0x2::object::ID {
        0x2::object::id<Treasury>(arg0)
    }

    public fun accept_admin_transfer(arg0: &mut Treasury, arg1: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::option::contains<address>(&arg0.pending_admin, &v0), 1);
        arg0.admin = v0;
        arg0.pending_admin = 0x1::option::none<address>();
        let v1 = TreasuryAdminTransferred{
            treasury_id : 0x2::object::id<Treasury>(arg0),
            old_admin   : arg0.admin,
            new_admin   : v0,
        };
        0x2::event::emit<TreasuryAdminTransferred>(v1);
    }

    public fun admin(arg0: &Treasury) : address {
        arg0.admin
    }

    fun assert_version(arg0: &Treasury) {
        assert!(arg0.version == 1, 30);
    }

    public fun cancel_admin_transfer(arg0: &mut Treasury, arg1: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 1);
        arg0.pending_admin = 0x1::option::none<address>();
    }

    public fun cancel_fee_change(arg0: &mut Treasury, arg1: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 1);
        arg0.pending_fee_bps = 0x1::option::none<u64>();
        arg0.fee_change_timestamp = 0x1::option::none<u64>();
    }

    public(friend) fun create(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg1);
        let v1 = 200;
        let v2 = Treasury{
            id                   : 0x2::object::new(arg1),
            version              : 1,
            admin                : arg0,
            pending_admin        : 0x1::option::none<address>(),
            balance              : 0x2::balance::zero<0x2::sui::SUI>(),
            total_collected      : 0,
            total_withdrawn      : 0,
            fee_bps              : v1,
            pending_fee_bps      : 0x1::option::none<u64>(),
            fee_change_timestamp : 0x1::option::none<u64>(),
            created_at           : v0,
        };
        let v3 = 0x2::object::id<Treasury>(&v2);
        let v4 = TreasuryCreated{
            treasury_id : v3,
            admin       : arg0,
            fee_bps     : v1,
            created_at  : v0,
        };
        0x2::event::emit<TreasuryCreated>(v4);
        0x2::transfer::share_object<Treasury>(v2);
        v3
    }

    public fun created_at(arg0: &Treasury) : u64 {
        arg0.created_at
    }

    public(friend) fun deposit(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_collected = arg0.total_collected + v0;
        let v1 = TreasuryDeposit{
            treasury_id     : 0x2::object::id<Treasury>(arg0),
            amount          : v0,
            total_collected : arg0.total_collected,
        };
        0x2::event::emit<TreasuryDeposit>(v1);
    }

    public fun emergency_withdraw(arg0: &mut Treasury, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance), arg2), arg1);
            arg0.total_withdrawn = arg0.total_withdrawn + v0;
            let v1 = TreasuryWithdrawal{
                treasury_id     : 0x2::object::id<Treasury>(arg0),
                amount          : v0,
                recipient       : arg1,
                total_withdrawn : arg0.total_withdrawn,
            };
            0x2::event::emit<TreasuryWithdrawal>(v1);
        };
    }

    public fun execute_fee_change(arg0: &mut Treasury, arg1: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 1);
        assert!(0x1::option::is_some<u64>(&arg0.pending_fee_bps), 2);
        assert!(0x2::tx_context::epoch_timestamp_ms(arg1) >= *0x1::option::borrow<u64>(&arg0.fee_change_timestamp), 17);
        let v0 = *0x1::option::borrow<u64>(&arg0.pending_fee_bps);
        arg0.fee_bps = v0;
        arg0.pending_fee_bps = 0x1::option::none<u64>();
        arg0.fee_change_timestamp = 0x1::option::none<u64>();
        let v1 = TreasuryFeeUpdated{
            treasury_id : 0x2::object::id<Treasury>(arg0),
            old_fee_bps : arg0.fee_bps,
            new_fee_bps : v0,
        };
        0x2::event::emit<TreasuryFeeUpdated>(v1);
    }

    public fun fee_bps(arg0: &Treasury) : u64 {
        arg0.fee_bps
    }

    public fun fee_change_timestamp(arg0: &Treasury) : 0x1::option::Option<u64> {
        arg0.fee_change_timestamp
    }

    public fun migrate(arg0: &mut Treasury, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 1);
        assert!(arg0.version < 1, 30);
        arg0.version = 1;
    }

    public fun pending_admin(arg0: &Treasury) : 0x1::option::Option<address> {
        arg0.pending_admin
    }

    public fun pending_fee_bps(arg0: &Treasury) : 0x1::option::Option<u64> {
        arg0.pending_fee_bps
    }

    public fun propose_admin_transfer(arg0: &mut Treasury, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        arg0.pending_admin = 0x1::option::some<address>(arg1);
        let v0 = TreasuryAdminProposed{
            treasury_id    : 0x2::object::id<Treasury>(arg0),
            current_admin  : arg0.admin,
            proposed_admin : arg1,
        };
        0x2::event::emit<TreasuryAdminProposed>(v0);
    }

    public fun propose_fee_change(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        assert!(arg1 >= 50 && arg1 <= 500, 16);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg2) + 604800000;
        arg0.pending_fee_bps = 0x1::option::some<u64>(arg1);
        arg0.fee_change_timestamp = 0x1::option::some<u64>(v0);
        let v1 = TreasuryFeeProposed{
            treasury_id      : 0x2::object::id<Treasury>(arg0),
            current_fee_bps  : arg0.fee_bps,
            proposed_fee_bps : arg1,
            effective_at     : v0,
        };
        0x2::event::emit<TreasuryFeeProposed>(v1);
    }

    public fun total_collected(arg0: &Treasury) : u64 {
        arg0.total_collected
    }

    public fun total_withdrawn(arg0: &Treasury) : u64 {
        arg0.total_withdrawn
    }

    public fun version(arg0: &Treasury) : u64 {
        arg0.version
    }

    public fun withdraw(arg0: &mut Treasury, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg1, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg3), arg2);
        arg0.total_withdrawn = arg0.total_withdrawn + arg1;
        let v0 = TreasuryWithdrawal{
            treasury_id     : 0x2::object::id<Treasury>(arg0),
            amount          : arg1,
            recipient       : arg2,
            total_withdrawn : arg0.total_withdrawn,
        };
        0x2::event::emit<TreasuryWithdrawal>(v0);
    }

    // decompiled from Move bytecode v6
}

