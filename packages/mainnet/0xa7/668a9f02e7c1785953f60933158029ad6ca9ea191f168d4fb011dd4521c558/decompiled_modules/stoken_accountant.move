module 0xa7668a9f02e7c1785953f60933158029ad6ca9ea191f168d4fb011dd4521c558::stoken_accountant {
    struct AccountantAdminCap has store, key {
        id: 0x2::object::UID,
        accountant_id: 0x2::object::ID,
    }

    struct AccountantManagerCap has store, key {
        id: 0x2::object::UID,
        accountant_id: 0x2::object::ID,
    }

    struct AccountantProcessorCap has store, key {
        id: 0x2::object::UID,
        accountant_id: 0x2::object::ID,
    }

    struct AccountantParityStateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AccountantParityState has drop, store {
        pending_split: bool,
        pending_weight_a: u64,
        pending_weight_b: u64,
        pending_split_at: u64,
        pending_recipients: bool,
        pending_recipient_a: address,
        pending_recipient_b: address,
        pending_recipients_at: u64,
    }

    struct PendingManager has copy, drop, store {
        manager: address,
        proposed_at: u64,
    }

    struct PendingCooldown has copy, drop, store {
        cooldown_secs: u64,
        proposed_at: u64,
    }

    struct Accountant<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        manager: address,
        processor: address,
        recipient_a: address,
        recipient_b: address,
        recipient_a_weight_bps: u64,
        recipient_b_weight_bps: u64,
        role_change_cooldown_secs: u64,
        cooldown_change_cooldown_secs: u64,
        pending_manager: 0x1::option::Option<PendingManager>,
        pending_cooldown: 0x1::option::Option<PendingCooldown>,
        token_balance: 0x2::balance::Balance<T0>,
        native_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AccountantInitializedEvent has copy, drop {
        accountant_id: 0x2::object::ID,
        manager: address,
        processor: address,
    }

    struct AccountantRecipientsUpdatedEvent has copy, drop {
        accountant_id: 0x2::object::ID,
        recipient_a: address,
        recipient_b: address,
        weight_a: u64,
        weight_b: u64,
    }

    struct AccountantDistributedTokensEvent has copy, drop {
        accountant_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
    }

    struct AccountantNativeDistributedEvent has copy, drop {
        accountant_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
    }

    struct AccountantManagerProposedEvent has copy, drop {
        accountant_id: 0x2::object::ID,
        manager: address,
        valid_after: u64,
    }

    struct AccountantManagerAcceptedEvent has copy, drop {
        accountant_id: 0x2::object::ID,
        manager: address,
    }

    struct AccountantProcessorUpdatedEvent has copy, drop {
        accountant_id: 0x2::object::ID,
        processor: address,
    }

    struct AccountantManagerChangeCancelledEvent has copy, drop {
        accountant_id: 0x2::object::ID,
        cancelled_manager: address,
    }

    struct AccountantCooldownUpdatedEvent has copy, drop {
        accountant_id: 0x2::object::ID,
        cooldown_secs: u64,
    }

    public fun accept_cooldown<T0>(arg0: &mut Accountant<T0>, arg1: &AccountantManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 1);
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 1);
        assert!(0x1::option::is_some<PendingCooldown>(&arg0.pending_cooldown), 332);
        let v0 = 0x1::option::extract<PendingCooldown>(&mut arg0.pending_cooldown);
        assert!(now_secs(arg2) >= v0.proposed_at + arg0.cooldown_change_cooldown_secs, 330);
        arg0.role_change_cooldown_secs = v0.cooldown_secs;
        arg0.cooldown_change_cooldown_secs = v0.cooldown_secs;
        let v1 = AccountantCooldownUpdatedEvent{
            accountant_id : 0x2::object::id<Accountant<T0>>(arg0),
            cooldown_secs : v0.cooldown_secs,
        };
        0x2::event::emit<AccountantCooldownUpdatedEvent>(v1);
    }

    public fun accept_manager<T0>(arg0: &mut Accountant<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(0x1::option::is_some<PendingManager>(&arg0.pending_manager), 313);
        let v0 = 0x1::option::borrow<PendingManager>(&arg0.pending_manager);
        assert!(0x2::tx_context::sender(arg2) == v0.manager, 1);
        assert!(now_secs(arg1) >= v0.proposed_at + arg0.role_change_cooldown_secs, 310);
        let v1 = 0x1::option::extract<PendingManager>(&mut arg0.pending_manager);
        arg0.manager = v1.manager;
        let v2 = AccountantManagerCap{
            id            : 0x2::object::new(arg2),
            accountant_id : 0x2::object::id<Accountant<T0>>(arg0),
        };
        0x2::transfer::public_transfer<AccountantManagerCap>(v2, v1.manager);
        let v3 = AccountantManagerAcceptedEvent{
            accountant_id : 0x2::object::id<Accountant<T0>>(arg0),
            manager       : v1.manager,
        };
        0x2::event::emit<AccountantManagerAcceptedEvent>(v3);
    }

    public fun accept_recipients<T0>(arg0: &mut Accountant<T0>, arg1: &AccountantManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 1);
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 1);
        let v0 = arg0.role_change_cooldown_secs;
        let v1 = parity_state_mut<T0>(arg0);
        assert!(v1.pending_recipients, 303);
        assert!(now_secs(arg2) >= v1.pending_recipients_at + v0, 302);
        let v2 = v1.pending_recipient_a;
        let v3 = v1.pending_recipient_b;
        v1.pending_recipients = false;
        arg0.recipient_a = v2;
        arg0.recipient_b = v3;
        let v4 = AccountantRecipientsUpdatedEvent{
            accountant_id : 0x2::object::id<Accountant<T0>>(arg0),
            recipient_a   : v2,
            recipient_b   : v3,
            weight_a      : arg0.recipient_a_weight_bps,
            weight_b      : arg0.recipient_b_weight_bps,
        };
        0x2::event::emit<AccountantRecipientsUpdatedEvent>(v4);
    }

    public fun accept_split_ratio<T0>(arg0: &mut Accountant<T0>, arg1: &AccountantManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 1);
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 1);
        let v0 = arg0.role_change_cooldown_secs;
        let v1 = parity_state_mut<T0>(arg0);
        assert!(v1.pending_split, 303);
        assert!(now_secs(arg2) >= v1.pending_split_at + v0, 302);
        let v2 = v1.pending_weight_a;
        let v3 = v1.pending_weight_b;
        v1.pending_split = false;
        arg0.recipient_a_weight_bps = v2;
        arg0.recipient_b_weight_bps = v3;
        let v4 = AccountantRecipientsUpdatedEvent{
            accountant_id : 0x2::object::id<Accountant<T0>>(arg0),
            recipient_a   : arg0.recipient_a,
            recipient_b   : arg0.recipient_b,
            weight_a      : v2,
            weight_b      : v3,
        };
        0x2::event::emit<AccountantRecipientsUpdatedEvent>(v4);
    }

    fun add_parity_state<T0>(arg0: &mut Accountant<T0>) {
        let v0 = AccountantParityStateKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<AccountantParityStateKey, AccountantParityState>(&arg0.id, v0)) {
            let v1 = AccountantParityStateKey{dummy_field: false};
            let v2 = AccountantParityState{
                pending_split         : false,
                pending_weight_a      : 0,
                pending_weight_b      : 0,
                pending_split_at      : 0,
                pending_recipients    : false,
                pending_recipient_a   : @0x0,
                pending_recipient_b   : @0x0,
                pending_recipients_at : 0,
            };
            0x2::dynamic_field::add<AccountantParityStateKey, AccountantParityState>(&mut arg0.id, v1, v2);
        };
    }

    fun assert_version<T0>(arg0: &Accountant<T0>) {
        assert!(arg0.version == 1, 9);
    }

    public fun cancel_cooldown<T0>(arg0: &mut Accountant<T0>, arg1: &AccountantManagerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 1);
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 1);
        arg0.pending_cooldown = 0x1::option::none<PendingCooldown>();
    }

    public fun cancel_manager<T0>(arg0: &mut Accountant<T0>, arg1: &AccountantManagerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 1);
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 1);
        assert!(0x1::option::is_some<PendingManager>(&arg0.pending_manager), 313);
        let v0 = 0x1::option::extract<PendingManager>(&mut arg0.pending_manager);
        let v1 = AccountantManagerChangeCancelledEvent{
            accountant_id     : 0x2::object::id<Accountant<T0>>(arg0),
            cancelled_manager : v0.manager,
        };
        0x2::event::emit<AccountantManagerChangeCancelledEvent>(v1);
    }

    public fun cancel_recipients<T0>(arg0: &mut Accountant<T0>, arg1: &AccountantManagerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 1);
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 1);
        parity_state_mut<T0>(arg0).pending_recipients = false;
    }

    public fun cancel_split_ratio<T0>(arg0: &mut Accountant<T0>, arg1: &AccountantManagerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 1);
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 1);
        parity_state_mut<T0>(arg0).pending_split = false;
    }

    public fun create_accountant<T0>(arg0: address, arg1: address, arg2: address, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (AccountantAdminCap, AccountantManagerCap, AccountantProcessorCap) {
        assert!(arg0 != @0x0 && arg1 != @0x0, 5);
        assert!(arg2 != @0x0 && arg3 != @0x0, 5);
        assert!(arg2 != arg3, 5);
        assert!(arg4 > 0 && arg5 > 0, 5);
        assert!(arg6 >= 0xa7668a9f02e7c1785953f60933158029ad6ca9ea191f168d4fb011dd4521c558::stoken_math::min_cooldown_secs() && arg6 <= 0xa7668a9f02e7c1785953f60933158029ad6ca9ea191f168d4fb011dd4521c558::stoken_math::max_cooldown_secs(), 5);
        let v0 = Accountant<T0>{
            id                            : 0x2::object::new(arg8),
            version                       : 1,
            manager                       : arg0,
            processor                     : arg1,
            recipient_a                   : arg2,
            recipient_b                   : arg3,
            recipient_a_weight_bps        : arg4,
            recipient_b_weight_bps        : arg5,
            role_change_cooldown_secs     : arg6,
            cooldown_change_cooldown_secs : arg6,
            pending_manager               : 0x1::option::none<PendingManager>(),
            pending_cooldown              : 0x1::option::none<PendingCooldown>(),
            token_balance                 : 0x2::balance::zero<T0>(),
            native_balance                : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v1 = &mut v0;
        add_parity_state<T0>(v1);
        let v2 = 0x2::object::id<Accountant<T0>>(&v0);
        0x2::transfer::share_object<Accountant<T0>>(v0);
        let v3 = AccountantInitializedEvent{
            accountant_id : v2,
            manager       : arg0,
            processor     : arg1,
        };
        0x2::event::emit<AccountantInitializedEvent>(v3);
        let v4 = AccountantAdminCap{
            id            : 0x2::object::new(arg8),
            accountant_id : v2,
        };
        let v5 = AccountantManagerCap{
            id            : 0x2::object::new(arg8),
            accountant_id : v2,
        };
        let v6 = AccountantProcessorCap{
            id            : 0x2::object::new(arg8),
            accountant_id : v2,
        };
        (v4, v5, v6)
    }

    public fun current_module_version() : u64 {
        1
    }

    public fun deposit_native<T0>(arg0: &mut Accountant<T0>, arg1: &AccountantManagerCap, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 1);
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.native_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public fun deposit_tokens<T0>(arg0: &mut Accountant<T0>, arg1: &AccountantManagerCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 1);
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 1);
        0x2::balance::join<T0>(&mut arg0.token_balance, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun distribute_native<T0>(arg0: &mut Accountant<T0>, arg1: &AccountantProcessorCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 1);
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.processor, 1);
        assert!(arg2 > 0, 4);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.native_balance) >= arg2, 6);
        let v0 = 0xa7668a9f02e7c1785953f60933158029ad6ca9ea191f168d4fb011dd4521c558::stoken_math::mul_div(arg2, arg0.recipient_a_weight_bps, arg0.recipient_a_weight_bps + arg0.recipient_b_weight_bps);
        let v1 = arg2 - v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.native_balance, v0), arg3), arg0.recipient_a);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.native_balance, v1), arg3), arg0.recipient_b);
        let v2 = AccountantNativeDistributedEvent{
            accountant_id : 0x2::object::id<Accountant<T0>>(arg0),
            amount_a      : v0,
            amount_b      : v1,
        };
        0x2::event::emit<AccountantNativeDistributedEvent>(v2);
    }

    public fun distribute_tokens<T0>(arg0: &mut Accountant<T0>, arg1: &AccountantProcessorCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 1);
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.processor, 1);
        assert!(arg2 > 0, 4);
        assert!(0x2::balance::value<T0>(&arg0.token_balance) >= arg2, 6);
        let v0 = 0xa7668a9f02e7c1785953f60933158029ad6ca9ea191f168d4fb011dd4521c558::stoken_math::mul_div(arg2, arg0.recipient_a_weight_bps, arg0.recipient_a_weight_bps + arg0.recipient_b_weight_bps);
        let v1 = arg2 - v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_balance, v0), arg3), arg0.recipient_a);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_balance, v1), arg3), arg0.recipient_b);
        let v2 = AccountantDistributedTokensEvent{
            accountant_id : 0x2::object::id<Accountant<T0>>(arg0),
            amount_a      : v0,
            amount_b      : v1,
        };
        0x2::event::emit<AccountantDistributedTokensEvent>(v2);
    }

    public fun get_manager<T0>(arg0: &Accountant<T0>) : address {
        arg0.manager
    }

    public fun get_native_balance<T0>(arg0: &Accountant<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.native_balance)
    }

    public fun get_processor<T0>(arg0: &Accountant<T0>) : address {
        arg0.processor
    }

    public fun get_token_balance<T0>(arg0: &Accountant<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.token_balance)
    }

    public fun migrate<T0>(arg0: &mut Accountant<T0>, arg1: &AccountantAdminCap) {
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 1);
        assert!(arg0.version < 1, 10);
        add_parity_state<T0>(arg0);
        arg0.version = 1;
    }

    fun now_secs(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    fun parity_state_mut<T0>(arg0: &mut Accountant<T0>) : &mut AccountantParityState {
        let v0 = AccountantParityStateKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<AccountantParityStateKey, AccountantParityState>(&mut arg0.id, v0)
    }

    public fun propose_cooldown<T0>(arg0: &mut Accountant<T0>, arg1: &AccountantManagerCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 1);
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.manager, 1);
        assert!(arg2 >= 0xa7668a9f02e7c1785953f60933158029ad6ca9ea191f168d4fb011dd4521c558::stoken_math::min_cooldown_secs() && arg2 <= 0xa7668a9f02e7c1785953f60933158029ad6ca9ea191f168d4fb011dd4521c558::stoken_math::max_cooldown_secs(), 5);
        let v0 = PendingCooldown{
            cooldown_secs : arg2,
            proposed_at   : now_secs(arg3),
        };
        arg0.pending_cooldown = 0x1::option::some<PendingCooldown>(v0);
    }

    public fun propose_manager<T0>(arg0: &mut Accountant<T0>, arg1: &AccountantManagerCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 1);
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.manager, 1);
        assert!(arg2 != @0x0, 5);
        let v0 = now_secs(arg3);
        let v1 = PendingManager{
            manager     : arg2,
            proposed_at : v0,
        };
        arg0.pending_manager = 0x1::option::some<PendingManager>(v1);
        let v2 = AccountantManagerProposedEvent{
            accountant_id : 0x2::object::id<Accountant<T0>>(arg0),
            manager       : arg2,
            valid_after   : v0 + arg0.role_change_cooldown_secs,
        };
        0x2::event::emit<AccountantManagerProposedEvent>(v2);
    }

    public fun propose_recipients<T0>(arg0: &mut Accountant<T0>, arg1: &AccountantManagerCap, arg2: address, arg3: address, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 1);
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg5) == arg0.manager, 1);
        assert!(arg2 != @0x0 && arg3 != @0x0, 5);
        assert!(arg2 != arg3, 5);
        let v0 = parity_state_mut<T0>(arg0);
        v0.pending_recipients = true;
        v0.pending_recipient_a = arg2;
        v0.pending_recipient_b = arg3;
        v0.pending_recipients_at = now_secs(arg4);
    }

    public fun propose_split_ratio<T0>(arg0: &mut Accountant<T0>, arg1: &AccountantManagerCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 1);
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg5) == arg0.manager, 1);
        assert!(arg2 > 0 && arg3 > 0, 5);
        let v0 = parity_state_mut<T0>(arg0);
        v0.pending_split = true;
        v0.pending_weight_a = arg2;
        v0.pending_weight_b = arg3;
        v0.pending_split_at = now_secs(arg4);
    }

    public fun update_processor<T0>(arg0: &mut Accountant<T0>, arg1: &AccountantManagerCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 1);
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 1);
        assert!(arg2 != @0x0, 5);
        arg0.processor = arg2;
        let v0 = AccountantProcessorUpdatedEvent{
            accountant_id : 0x2::object::id<Accountant<T0>>(arg0),
            processor     : arg2,
        };
        0x2::event::emit<AccountantProcessorUpdatedEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

