module 0x4849cd2f911440acf46bb19ba798379b57963608b3c8488c7fb9c52da454b48c::linq_vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry<phantom T0> has key {
        id: 0x2::object::UID,
        recovery_timelock_ms: u64,
        vault_count: u64,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        user_key: u64,
        owner: address,
        balance: 0x2::balance::Balance<T0>,
        recovery: 0x1::option::Option<Recovery>,
    }

    struct Recovery has copy, drop, store {
        new_owner: address,
        executable_at_ms: u64,
    }

    struct RegistryCreated has copy, drop {
        registry: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        recovery_timelock_ms: u64,
    }

    struct VaultCreated has copy, drop {
        vault: 0x2::object::ID,
        user_key: u64,
        owner: address,
    }

    struct Deposited has copy, drop {
        vault: 0x2::object::ID,
        amount: u64,
        source: u8,
    }

    struct Withdrawn has copy, drop {
        vault: 0x2::object::ID,
        amount: u64,
        recipient: address,
        withdrawal_id: vector<u8>,
    }

    struct OwnerChanged has copy, drop {
        vault: 0x2::object::ID,
        old_owner: address,
        new_owner: address,
    }

    struct RecoveryStarted has copy, drop {
        vault: 0x2::object::ID,
        new_owner: address,
        executable_at_ms: u64,
    }

    struct RecoveryCancelled has copy, drop {
        vault: 0x2::object::ID,
    }

    struct RecoveryFinalized has copy, drop {
        vault: 0x2::object::ID,
        old_owner: address,
        new_owner: address,
    }

    public fun balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    fun assert_member<T0>(arg0: &Registry<T0>, arg1: &Vault<T0>) {
        assert!(0x2::derived_object::derive_address<u64>(0x2::object::id<Registry<T0>>(arg0), arg1.user_key) == 0x2::object::uid_to_address(&arg1.id), 13837310997558198289);
    }

    public fun cancel_recovery<T0>(arg0: &mut Vault<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 13835340466561875971);
        assert!(0x1::option::is_some<Recovery>(&arg0.recovery), 13836747845741051917);
        arg0.recovery = 0x1::option::none<Recovery>();
        let v0 = RecoveryCancelled{vault: 0x2::object::id<Vault<T0>>(arg0)};
        0x2::event::emit<RecoveryCancelled>(v0);
    }

    public fun collect_balance<T0>(arg0: &mut Vault<T0>, arg1: &0x2::accumulator::AccumulatorRoot) {
        let v0 = 0x2::balance::settled_funds_value<T0>(arg1, 0x2::object::uid_to_address(&arg0.id));
        if (v0 == 0) {
            return
        };
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::balance::redeem_funds<T0>(0x2::balance::withdraw_funds_from_object<T0>(&mut arg0.id, v0)));
        let v1 = Deposited{
            vault  : 0x2::object::id<Vault<T0>>(arg0),
            amount : v0,
            source : 1,
        };
        0x2::event::emit<Deposited>(v1);
    }

    public fun collect_coin<T0>(arg0: &mut Vault<T0>, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) {
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1);
        let v1 = 0x2::coin::value<T0>(&v0);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(v0));
        if (v1 > 0) {
            let v2 = Deposited{
                vault  : 0x2::object::id<Vault<T0>>(arg0),
                amount : v1,
                source : 0,
            };
            0x2::event::emit<Deposited>(v2);
        };
    }

    public fun create_registry<T0>(arg0: &AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry<T0>{
            id                   : 0x2::object::new(arg2),
            recovery_timelock_ms : arg1,
            vault_count          : 0,
        };
        let v1 = RegistryCreated{
            registry             : 0x2::object::id<Registry<T0>>(&v0),
            coin_type            : 0x1::type_name::with_defining_ids<T0>(),
            recovery_timelock_ms : arg1,
        };
        0x2::event::emit<RegistryCreated>(v1);
        0x2::transfer::share_object<Registry<T0>>(v0);
    }

    public fun create_vault<T0>(arg0: &mut Registry<T0>, arg1: &AdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::derived_object::exists<u64>(&arg0.id, arg2), 13835058613627912193);
        assert!(arg3 != @0x0, 13836184517830246409);
        let v0 = Vault<T0>{
            id       : 0x2::derived_object::claim<u64>(&mut arg0.id, arg2),
            user_key : arg2,
            owner    : arg3,
            balance  : 0x2::balance::zero<T0>(),
            recovery : 0x1::option::none<Recovery>(),
        };
        arg0.vault_count = arg0.vault_count + 1;
        let v1 = VaultCreated{
            vault    : 0x2::object::id<Vault<T0>>(&v0),
            user_key : arg2,
            owner    : arg3,
        };
        0x2::event::emit<VaultCreated>(v1);
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public fun finalize_recovery<T0>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock) {
        assert!(0x1::option::is_some<Recovery>(&arg0.recovery), 13836747875805822989);
        let Recovery {
            new_owner        : v0,
            executable_at_ms : v1,
        } = *0x1::option::borrow<Recovery>(&arg0.recovery);
        assert!(0x2::clock::timestamp_ms(arg1) >= v1, 13837029359372599311);
        arg0.owner = v0;
        arg0.recovery = 0x1::option::none<Recovery>();
        let v2 = RecoveryFinalized{
            vault     : 0x2::object::id<Vault<T0>>(arg0),
            old_owner : arg0.owner,
            new_owner : v0,
        };
        0x2::event::emit<RecoveryFinalized>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun owner<T0>(arg0: &Vault<T0>) : address {
        arg0.owner
    }

    public fun pending_recovery<T0>(arg0: &Vault<T0>) : 0x1::option::Option<Recovery> {
        arg0.recovery
    }

    public fun recovery_executable_at_ms(arg0: &Recovery) : u64 {
        arg0.executable_at_ms
    }

    public fun recovery_new_owner(arg0: &Recovery) : address {
        arg0.new_owner
    }

    public fun recovery_timelock_ms<T0>(arg0: &Registry<T0>) : u64 {
        arg0.recovery_timelock_ms
    }

    public fun set_owner<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 13835340320532987907);
        assert!(arg1 != @0x0, 13836184749758480393);
        assert!(arg1 != arg0.owner, 13837873603914498069);
        arg0.owner = arg1;
        if (0x1::option::is_some<Recovery>(&arg0.recovery)) {
            arg0.recovery = 0x1::option::none<Recovery>();
            let v0 = RecoveryCancelled{vault: 0x2::object::id<Vault<T0>>(arg0)};
            0x2::event::emit<RecoveryCancelled>(v0);
        };
        let v1 = OwnerChanged{
            vault     : 0x2::object::id<Vault<T0>>(arg0),
            old_owner : arg0.owner,
            new_owner : arg1,
        };
        0x2::event::emit<OwnerChanged>(v1);
    }

    public fun start_recovery<T0>(arg0: &Registry<T0>, arg1: &AdminCap, arg2: &mut Vault<T0>, arg3: address, arg4: &0x2::clock::Clock) {
        assert_member<T0>(arg0, arg2);
        assert!(0x1::option::is_none<Recovery>(&arg2.recovery), 13836466323519569931);
        assert!(arg3 != @0x0, 13836184852837695497);
        assert!(arg3 != arg2.owner, 13837873706993713173);
        let v0 = 0x2::clock::timestamp_ms(arg4) + arg0.recovery_timelock_ms;
        let v1 = Recovery{
            new_owner        : arg3,
            executable_at_ms : v0,
        };
        arg2.recovery = 0x1::option::some<Recovery>(v1);
        let v2 = RecoveryStarted{
            vault            : 0x2::object::id<Vault<T0>>(arg2),
            new_owner        : arg3,
            executable_at_ms : v0,
        };
        0x2::event::emit<RecoveryStarted>(v2);
    }

    public fun user_key<T0>(arg0: &Vault<T0>) : u64 {
        arg0.user_key
    }

    public fun vault_address<T0>(arg0: &Registry<T0>, arg1: u64) : address {
        0x2::derived_object::derive_address<u64>(0x2::object::id<Registry<T0>>(arg0), arg1)
    }

    public fun vault_count<T0>(arg0: &Registry<T0>) : u64 {
        arg0.vault_count
    }

    public fun vault_exists<T0>(arg0: &Registry<T0>, arg1: u64) : bool {
        0x2::derived_object::exists<u64>(&arg0.id, arg1)
    }

    public fun withdraw_to<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: address, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 13835340268993380355);
        assert!(arg1 > 0, 13835903223242031111);
        assert!(0x1::vector::length<u8>(&arg3) <= 64, 13837592077398048787);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 13835621756855123973);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg4), arg2);
        let v0 = Withdrawn{
            vault         : 0x2::object::id<Vault<T0>>(arg0),
            amount        : arg1,
            recipient     : arg2,
            withdrawal_id : arg3,
        };
        0x2::event::emit<Withdrawn>(v0);
    }

    // decompiled from Move bytecode v6
}

