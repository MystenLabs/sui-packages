module 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_accountant {
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
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::unauthorized());
        assert!(0x1::option::is_some<PendingCooldown>(&arg0.pending_cooldown), 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::no_pending_cooldown_change());
        let v0 = 0x1::option::extract<PendingCooldown>(&mut arg0.pending_cooldown);
        assert!(now_secs(arg2) >= v0.proposed_at + arg0.cooldown_change_cooldown_secs, 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::cooldown_change_timelock_active());
        arg0.role_change_cooldown_secs = v0.cooldown_secs;
        arg0.cooldown_change_cooldown_secs = v0.cooldown_secs;
        let v1 = AccountantCooldownUpdatedEvent{
            accountant_id : 0x2::object::id<Accountant<T0>>(arg0),
            cooldown_secs : v0.cooldown_secs,
        };
        0x2::event::emit<AccountantCooldownUpdatedEvent>(v1);
    }

    public fun accept_manager<T0>(arg0: &mut Accountant<T0>, arg1: &AccountantManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::unauthorized());
        assert!(0x1::option::is_some<PendingManager>(&arg0.pending_manager), 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::no_pending_roles_change());
        let v0 = 0x1::option::extract<PendingManager>(&mut arg0.pending_manager);
        assert!(now_secs(arg2) >= v0.proposed_at + arg0.role_change_cooldown_secs, 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::role_change_timelock_active());
        arg0.manager = v0.manager;
        let v1 = AccountantManagerAcceptedEvent{
            accountant_id : 0x2::object::id<Accountant<T0>>(arg0),
            manager       : v0.manager,
        };
        0x2::event::emit<AccountantManagerAcceptedEvent>(v1);
    }

    fun assert_version<T0>(arg0: &Accountant<T0>) {
        assert!(arg0.version == 1, 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::wrong_version());
    }

    public fun cancel_cooldown<T0>(arg0: &mut Accountant<T0>, arg1: &AccountantManagerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::unauthorized());
        arg0.pending_cooldown = 0x1::option::none<PendingCooldown>();
    }

    public fun cancel_manager<T0>(arg0: &mut Accountant<T0>, arg1: &AccountantManagerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::unauthorized());
        assert!(0x1::option::is_some<PendingManager>(&arg0.pending_manager), 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::no_pending_roles_change());
        let v0 = 0x1::option::extract<PendingManager>(&mut arg0.pending_manager);
        let v1 = AccountantManagerChangeCancelledEvent{
            accountant_id     : 0x2::object::id<Accountant<T0>>(arg0),
            cancelled_manager : v0.manager,
        };
        0x2::event::emit<AccountantManagerChangeCancelledEvent>(v1);
    }

    public fun create_accountant<T0>(arg0: address, arg1: address, arg2: address, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (AccountantAdminCap, AccountantManagerCap, AccountantProcessorCap) {
        assert!(arg0 != @0x0 && arg1 != @0x0, 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::invalid_argument());
        assert!(arg2 != @0x0 && arg3 != @0x0, 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::invalid_argument());
        assert!(arg2 != arg3, 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::invalid_argument());
        assert!(arg4 > 0 && arg5 > 0, 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::invalid_argument());
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
        let v1 = 0x2::object::id<Accountant<T0>>(&v0);
        0x2::transfer::share_object<Accountant<T0>>(v0);
        let v2 = AccountantInitializedEvent{
            accountant_id : v1,
            manager       : arg0,
            processor     : arg1,
        };
        0x2::event::emit<AccountantInitializedEvent>(v2);
        let v3 = AccountantAdminCap{
            id            : 0x2::object::new(arg8),
            accountant_id : v1,
        };
        let v4 = AccountantManagerCap{
            id            : 0x2::object::new(arg8),
            accountant_id : v1,
        };
        let v5 = AccountantProcessorCap{
            id            : 0x2::object::new(arg8),
            accountant_id : v1,
        };
        (v3, v4, v5)
    }

    public fun current_module_version() : u64 {
        1
    }

    public fun deposit_native<T0>(arg0: &mut Accountant<T0>, arg1: &AccountantManagerCap, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::unauthorized());
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.native_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public fun deposit_tokens<T0>(arg0: &mut Accountant<T0>, arg1: &AccountantManagerCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::unauthorized());
        0x2::balance::join<T0>(&mut arg0.token_balance, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun distribute_native<T0>(arg0: &mut Accountant<T0>, arg1: &AccountantProcessorCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.processor, 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::unauthorized());
        assert!(arg2 > 0, 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::invalid_amount());
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.native_balance) >= arg2, 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::insufficient_balance());
        let v0 = 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_math::mul_div(arg2, arg0.recipient_a_weight_bps, arg0.recipient_a_weight_bps + arg0.recipient_b_weight_bps);
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
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.processor, 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::unauthorized());
        assert!(arg2 > 0, 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::invalid_amount());
        assert!(0x2::balance::value<T0>(&arg0.token_balance) >= arg2, 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::insufficient_balance());
        let v0 = 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_math::mul_div(arg2, arg0.recipient_a_weight_bps, arg0.recipient_a_weight_bps + arg0.recipient_b_weight_bps);
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
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::unauthorized());
        assert!(arg0.version < 1, 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::not_upgrade());
        arg0.version = 1;
    }

    fun now_secs(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun propose_cooldown<T0>(arg0: &mut Accountant<T0>, arg1: &AccountantManagerCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.manager, 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::unauthorized());
        let v0 = PendingCooldown{
            cooldown_secs : arg2,
            proposed_at   : now_secs(arg3),
        };
        arg0.pending_cooldown = 0x1::option::some<PendingCooldown>(v0);
    }

    public fun propose_manager<T0>(arg0: &mut Accountant<T0>, arg1: &AccountantManagerCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.manager, 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::unauthorized());
        assert!(arg2 != @0x0, 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::invalid_argument());
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

    public fun update_processor<T0>(arg0: &mut Accountant<T0>, arg1: &AccountantManagerCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::unauthorized());
        assert!(arg2 != @0x0, 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::invalid_argument());
        arg0.processor = arg2;
        let v0 = AccountantProcessorUpdatedEvent{
            accountant_id : 0x2::object::id<Accountant<T0>>(arg0),
            processor     : arg2,
        };
        0x2::event::emit<AccountantProcessorUpdatedEvent>(v0);
    }

    public fun update_recipients<T0>(arg0: &mut Accountant<T0>, arg1: &AccountantManagerCap, arg2: address, arg3: address, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.manager, 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::unauthorized());
        assert!(arg2 != @0x0 && arg3 != @0x0, 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::invalid_argument());
        assert!(arg2 != arg3, 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::invalid_argument());
        arg0.recipient_a = arg2;
        arg0.recipient_b = arg3;
        let v0 = AccountantRecipientsUpdatedEvent{
            accountant_id : 0x2::object::id<Accountant<T0>>(arg0),
            recipient_a   : arg2,
            recipient_b   : arg3,
            weight_a      : arg0.recipient_a_weight_bps,
            weight_b      : arg0.recipient_b_weight_bps,
        };
        0x2::event::emit<AccountantRecipientsUpdatedEvent>(v0);
    }

    public fun update_split_ratio<T0>(arg0: &mut Accountant<T0>, arg1: &AccountantManagerCap, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.accountant_id == 0x2::object::id<Accountant<T0>>(arg0), 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.manager, 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::unauthorized());
        assert!(arg2 > 0 && arg3 > 0, 0xcc86957162e17cc60b48df11b4b9516dea6d6a417ebb323e7ec2a2e10658ccc9::stoken_errors::invalid_argument());
        arg0.recipient_a_weight_bps = arg2;
        arg0.recipient_b_weight_bps = arg3;
        let v0 = AccountantRecipientsUpdatedEvent{
            accountant_id : 0x2::object::id<Accountant<T0>>(arg0),
            recipient_a   : arg0.recipient_a,
            recipient_b   : arg0.recipient_b,
            weight_a      : arg2,
            weight_b      : arg3,
        };
        0x2::event::emit<AccountantRecipientsUpdatedEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

