module 0x520bacaf980f39c9328fa6090fb47f8b348d4c60e640d165fabd4bc738169bee::deposits {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        operator: address,
        pending_owner: address,
        paused: bool,
        vault: 0x2::balance::Balance<T0>,
        snapshot_balance: u64,
        snapshot_epoch_ms: u64,
        withdrawn_since_snapshot: u64,
        withdraw_limit_pct: u64,
        withdraw_window_ms: u64,
    }

    struct DepositEvent has copy, drop {
        user_id: vector<u8>,
        amount: u64,
        sender: address,
    }

    struct PayoutEvent has copy, drop {
        wallet_id: vector<u8>,
        amount: u64,
        recipient: address,
        operator: address,
    }

    struct ForcedPayoutEvent has copy, drop {
        wallet_id: vector<u8>,
        amount: u64,
        recipient: address,
        owner: address,
    }

    struct AdminWithdrawEvent has copy, drop {
        wallet_id: vector<u8>,
        amount: u64,
        recipient: address,
        owner: address,
    }

    struct TopUpEvent has copy, drop {
        wallet_id: vector<u8>,
        amount: u64,
        owner: address,
    }

    struct LimitsUpdatedEvent has copy, drop {
        old_pct: u64,
        new_pct: u64,
        old_window_ms: u64,
        new_window_ms: u64,
        owner: address,
    }

    struct PausedEvent has copy, drop {
        paused: bool,
        owner: address,
    }

    struct OperatorUpdatedEvent has copy, drop {
        old_operator: address,
        new_operator: address,
        owner: address,
    }

    struct OwnerProposedEvent has copy, drop {
        current_owner: address,
        pending_owner: address,
    }

    struct OwnerAcceptedEvent has copy, drop {
        old_owner: address,
        new_owner: address,
    }

    public entry fun accept_owner<T0>(arg0: &mut Treasury<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.pending_owner != @0x0, 10);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.pending_owner, 9);
        arg0.owner = v0;
        arg0.pending_owner = @0x0;
        let v1 = OwnerAcceptedEvent{
            old_owner : arg0.owner,
            new_owner : v0,
        };
        0x2::event::emit<OwnerAcceptedEvent>(v1);
    }

    public entry fun admin_sweep<T0>(arg0: &mut Treasury<T0>, arg1: vector<u8>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.owner, 2);
        assert!(arg2 > 0, 4);
        assert!(0x2::balance::value<T0>(&arg0.vault) >= arg2, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, arg2), arg4), arg3);
        let v1 = AdminWithdrawEvent{
            wallet_id : arg1,
            amount    : arg2,
            recipient : arg3,
            owner     : v0,
        };
        0x2::event::emit<AdminWithdrawEvent>(v1);
    }

    public entry fun admin_top_up<T0>(arg0: &mut Treasury<T0>, arg1: vector<u8>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.owner, 2);
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg2));
        let v1 = TopUpEvent{
            wallet_id : arg1,
            amount    : 0x2::coin::value<T0>(&arg2),
            owner     : v0,
        };
        0x2::event::emit<TopUpEvent>(v1);
    }

    fun check_and_update_rate_limit<T0>(arg0: &mut Treasury<T0>, arg1: &0x2::clock::Clock, arg2: u64) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 - arg0.snapshot_epoch_ms >= arg0.withdraw_window_ms) {
            arg0.snapshot_balance = 0x2::balance::value<T0>(&arg0.vault);
            arg0.snapshot_epoch_ms = v0;
            arg0.withdrawn_since_snapshot = 0;
        };
        assert!(arg0.withdrawn_since_snapshot + arg2 <= arg0.snapshot_balance * arg0.withdraw_limit_pct / 100, 3);
        arg0.withdrawn_since_snapshot = arg0.withdrawn_since_snapshot + arg2;
    }

    public entry fun create_treasury<T0>(arg0: AdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = Treasury<T0>{
            id                       : 0x2::object::new(arg2),
            owner                    : v1,
            operator                 : v1,
            pending_owner            : @0x0,
            paused                   : false,
            vault                    : 0x2::balance::zero<T0>(),
            snapshot_balance         : 0,
            snapshot_epoch_ms        : 0x2::clock::timestamp_ms(arg1),
            withdrawn_since_snapshot : 0,
            withdraw_limit_pct       : 20,
            withdraw_window_ms       : 86400000,
        };
        0x2::transfer::share_object<Treasury<T0>>(v2);
    }

    public entry fun deposit<T0>(arg0: &mut Treasury<T0>, arg1: vector<u8>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 8);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 >= 1000000, 1);
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg2));
        let v1 = DepositEvent{
            user_id : arg1,
            amount  : v0,
            sender  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    public entry fun force_payout<T0>(arg0: &mut Treasury<T0>, arg1: vector<u8>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 8);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.owner, 2);
        assert!(arg2 > 0, 4);
        assert!(0x2::balance::value<T0>(&arg0.vault) >= arg2, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, arg2), arg4), arg3);
        let v1 = ForcedPayoutEvent{
            wallet_id : arg1,
            amount    : arg2,
            recipient : arg3,
            owner     : v0,
        };
        0x2::event::emit<ForcedPayoutEvent>(v1);
    }

    public fun get_operator<T0>(arg0: &Treasury<T0>) : address {
        arg0.operator
    }

    public fun get_owner<T0>(arg0: &Treasury<T0>) : address {
        arg0.owner
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_paused<T0>(arg0: &Treasury<T0>) : bool {
        arg0.paused
    }

    public entry fun payout<T0>(arg0: &mut Treasury<T0>, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 8);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == arg0.operator, 7);
        assert!(arg3 > 0, 4);
        assert!(0x2::balance::value<T0>(&arg0.vault) >= arg3, 5);
        check_and_update_rate_limit<T0>(arg0, arg1, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, arg3), arg5), arg4);
        let v1 = PayoutEvent{
            wallet_id : arg2,
            amount    : arg3,
            recipient : arg4,
            operator  : v0,
        };
        0x2::event::emit<PayoutEvent>(v1);
    }

    public entry fun propose_owner<T0>(arg0: &mut Treasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner, 2);
        arg0.pending_owner = arg1;
        let v1 = OwnerProposedEvent{
            current_owner : v0,
            pending_owner : arg1,
        };
        0x2::event::emit<OwnerProposedEvent>(v1);
    }

    public fun rate_limit_status<T0>(arg0: &Treasury<T0>, arg1: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg1) - arg0.snapshot_epoch_ms;
        if (v0 >= arg0.withdraw_window_ms) {
            let v5 = 0x2::balance::value<T0>(&arg0.vault);
            (v5, 0, v5 * arg0.withdraw_limit_pct / 100, 0)
        } else {
            (arg0.snapshot_balance, arg0.withdrawn_since_snapshot, arg0.snapshot_balance * arg0.withdraw_limit_pct / 100, arg0.withdraw_window_ms - v0)
        }
    }

    public entry fun set_limits<T0>(arg0: &mut Treasury<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.owner, 2);
        assert!(arg1 > 0 && arg1 <= 100, 6);
        assert!(arg2 > 0, 6);
        arg0.withdraw_limit_pct = arg1;
        arg0.withdraw_window_ms = arg2;
        let v1 = LimitsUpdatedEvent{
            old_pct       : arg0.withdraw_limit_pct,
            new_pct       : arg1,
            old_window_ms : arg0.withdraw_window_ms,
            new_window_ms : arg2,
            owner         : v0,
        };
        0x2::event::emit<LimitsUpdatedEvent>(v1);
    }

    public entry fun set_operator<T0>(arg0: &mut Treasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner, 2);
        arg0.operator = arg1;
        let v1 = OperatorUpdatedEvent{
            old_operator : arg0.operator,
            new_operator : arg1,
            owner        : v0,
        };
        0x2::event::emit<OperatorUpdatedEvent>(v1);
    }

    public entry fun set_paused<T0>(arg0: &mut Treasury<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner, 2);
        arg0.paused = arg1;
        let v1 = PausedEvent{
            paused : arg1,
            owner  : v0,
        };
        0x2::event::emit<PausedEvent>(v1);
    }

    public fun vault_balance<T0>(arg0: &Treasury<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.vault)
    }

    // decompiled from Move bytecode v6
}

