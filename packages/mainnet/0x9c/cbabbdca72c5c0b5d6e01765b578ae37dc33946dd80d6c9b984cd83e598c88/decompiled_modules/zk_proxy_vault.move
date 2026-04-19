module 0x8f2534a77f1f0baf8c2bc44cf1cc5ada72ffd6be515f54f8f073dc434e1a3ca2::zk_proxy_vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GuardianCap has store, key {
        id: 0x2::object::UID,
        guardian_address: address,
    }

    struct UpgraderCap has store, key {
        id: 0x2::object::UID,
    }

    struct ProxyBinding has store, key {
        id: 0x2::object::UID,
        proxy_address: address,
        owner: address,
        zk_binding_hash: vector<u8>,
        deposited_amount: u64,
        created_at: u64,
        is_active: bool,
        nonce: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct PendingWithdrawal has store, key {
        id: 0x2::object::UID,
        withdrawal_id: vector<u8>,
        owner: address,
        proxy_id: 0x2::object::ID,
        amount: u64,
        unlock_time: u64,
        executed: bool,
        cancelled: bool,
    }

    struct ZKProxyVaultState has key {
        id: 0x2::object::UID,
        zk_verifier: 0x1::option::Option<0x2::object::ID>,
        time_lock_threshold: u64,
        time_lock_duration: u64,
        total_value_locked: u64,
        total_proxies: u64,
        paused: bool,
        owner_nonces: 0x2::table::Table<address, u64>,
        proxy_bindings: 0x2::table::Table<address, 0x2::object::ID>,
        owner_proxies: 0x2::table::Table<address, vector<0x2::object::ID>>,
        pending_withdrawals: 0x2::table::Table<vector<u8>, 0x2::object::ID>,
    }

    struct ProxyCreated has copy, drop {
        owner: address,
        proxy_address: address,
        proxy_id: 0x2::object::ID,
        zk_binding_hash: vector<u8>,
        timestamp: u64,
    }

    struct Deposited has copy, drop {
        proxy_id: 0x2::object::ID,
        proxy_address: address,
        owner: address,
        amount: u64,
        new_balance: u64,
    }

    struct WithdrawalRequested has copy, drop {
        withdrawal_id: vector<u8>,
        owner: address,
        proxy_id: 0x2::object::ID,
        amount: u64,
        unlock_time: u64,
    }

    struct WithdrawalExecuted has copy, drop {
        withdrawal_id: vector<u8>,
        owner: address,
        amount: u64,
    }

    struct WithdrawalCancelled has copy, drop {
        withdrawal_id: vector<u8>,
        canceller: address,
    }

    struct InstantWithdrawal has copy, drop {
        owner: address,
        proxy_id: 0x2::object::ID,
        amount: u64,
    }

    struct ZKVerifierUpdated has copy, drop {
        old_verifier: 0x1::option::Option<0x2::object::ID>,
        new_verifier: 0x1::option::Option<0x2::object::ID>,
    }

    public entry fun cancel_withdrawal(arg0: &mut PendingWithdrawal, arg1: &mut ProxyBinding, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.owner == v0, 0);
        assert!(!arg0.executed, 7);
        assert!(!arg0.cancelled, 8);
        arg0.cancelled = true;
        arg1.deposited_amount = arg1.deposited_amount + arg0.amount;
        let v1 = WithdrawalCancelled{
            withdrawal_id : arg0.withdrawal_id,
            canceller     : v0,
        };
        0x2::event::emit<WithdrawalCancelled>(v1);
    }

    public entry fun create_proxy(arg0: &mut ZKProxyVaultState, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 11);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = if (0x2::table::contains<address, u64>(&arg0.owner_nonces, v0)) {
            let v3 = *0x2::table::borrow<address, u64>(&arg0.owner_nonces, v0);
            *0x2::table::borrow_mut<address, u64>(&mut arg0.owner_nonces, v0) = v3 + 1;
            v3
        } else {
            0x2::table::add<address, u64>(&mut arg0.owner_nonces, v0, 1);
            0
        };
        let v4 = derive_proxy_address(v0, v2, &arg1);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.proxy_bindings, v4), 1);
        let v5 = ProxyBinding{
            id               : 0x2::object::new(arg3),
            proxy_address    : v4,
            owner            : v0,
            zk_binding_hash  : arg1,
            deposited_amount : 0,
            created_at       : v1,
            is_active        : true,
            nonce            : v2,
            balance          : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v6 = 0x2::object::id<ProxyBinding>(&v5);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.proxy_bindings, v4, v6);
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.owner_proxies, v0)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.owner_proxies, v0), v6);
        } else {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.owner_proxies, v0, 0x1::vector::singleton<0x2::object::ID>(v6));
        };
        arg0.total_proxies = arg0.total_proxies + 1;
        let v7 = ProxyCreated{
            owner           : v0,
            proxy_address   : v4,
            proxy_id        : v6,
            zk_binding_hash : arg1,
            timestamp       : v1,
        };
        0x2::event::emit<ProxyCreated>(v7);
        0x2::transfer::share_object<ProxyBinding>(v5);
    }

    public entry fun deposit(arg0: &mut ZKProxyVaultState, arg1: &mut ProxyBinding, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 11);
        assert!(arg1.is_active, 2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 9);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg1.deposited_amount = arg1.deposited_amount + v0;
        arg0.total_value_locked = arg0.total_value_locked + v0;
        let v1 = Deposited{
            proxy_id      : 0x2::object::id<ProxyBinding>(arg1),
            proxy_address : arg1.proxy_address,
            owner         : arg1.owner,
            amount        : v0,
            new_balance   : arg1.deposited_amount,
        };
        0x2::event::emit<Deposited>(v1);
    }

    fun derive_binding_hash(arg0: address, arg1: address) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1));
        0x2::hash::keccak256(&v0)
    }

    fun derive_proxy_address(arg0: address, arg1: u64, arg2: &vector<u8>) : address {
        let v0 = b"ZKVANGUARD_PDA_V1";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, *arg2);
        0x2::address::from_bytes(0x2::hash::keccak256(&v0))
    }

    fun derive_withdrawal_id(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0x2::hash::keccak256(&v0)
    }

    public entry fun execute_withdrawal(arg0: &mut ZKProxyVaultState, arg1: &mut PendingWithdrawal, arg2: &mut ProxyBinding, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg4), 3);
        assert!(!arg1.executed, 7);
        assert!(!arg1.cancelled, 8);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg1.unlock_time, 6);
        arg1.executed = true;
        arg0.total_value_locked = arg0.total_value_locked - arg1.amount;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2.balance, arg1.amount), arg4), arg1.owner);
        let v0 = WithdrawalExecuted{
            withdrawal_id : arg1.withdrawal_id,
            owner         : arg1.owner,
            amount        : arg1.amount,
        };
        0x2::event::emit<WithdrawalExecuted>(v0);
    }

    public fun get_owner_proxy_count(arg0: &ZKProxyVaultState, arg1: address) : u64 {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.owner_proxies, arg1)) {
            0x1::vector::length<0x2::object::ID>(0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.owner_proxies, arg1))
        } else {
            0
        }
    }

    public fun get_pending_withdrawal_info(arg0: &PendingWithdrawal) : (address, u64, u64, bool, bool) {
        (arg0.owner, arg0.amount, arg0.unlock_time, arg0.executed, arg0.cancelled)
    }

    public fun get_proxy_balance(arg0: &ProxyBinding) : u64 {
        arg0.deposited_amount
    }

    public fun get_proxy_info(arg0: &ProxyBinding) : (address, address, u64, bool) {
        (arg0.owner, arg0.proxy_address, arg0.deposited_amount, arg0.is_active)
    }

    public fun get_total_proxies(arg0: &ZKProxyVaultState) : u64 {
        arg0.total_proxies
    }

    public fun get_total_value_locked(arg0: &ZKProxyVaultState) : u64 {
        arg0.total_value_locked
    }

    public entry fun grant_guardian_role(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = GuardianCap{
            id               : 0x2::object::new(arg2),
            guardian_address : arg1,
        };
        0x2::transfer::transfer<GuardianCap>(v0, arg1);
    }

    public entry fun guardian_cancel_withdrawal(arg0: &GuardianCap, arg1: &mut PendingWithdrawal, arg2: &mut ProxyBinding, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.executed, 7);
        assert!(!arg1.cancelled, 8);
        arg1.cancelled = true;
        arg2.deposited_amount = arg2.deposited_amount + arg1.amount;
        let v0 = WithdrawalCancelled{
            withdrawal_id : arg1.withdrawal_id,
            canceller     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<WithdrawalCancelled>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = GuardianCap{
            id               : 0x2::object::new(arg0),
            guardian_address : v0,
        };
        0x2::transfer::transfer<GuardianCap>(v2, v0);
        let v3 = UpgraderCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<UpgraderCap>(v3, v0);
        let v4 = ZKProxyVaultState{
            id                  : 0x2::object::new(arg0),
            zk_verifier         : 0x1::option::none<0x2::object::ID>(),
            time_lock_threshold : 100000000000,
            time_lock_duration  : 86400000,
            total_value_locked  : 0,
            total_proxies       : 0,
            paused              : false,
            owner_nonces        : 0x2::table::new<address, u64>(arg0),
            proxy_bindings      : 0x2::table::new<address, 0x2::object::ID>(arg0),
            owner_proxies       : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            pending_withdrawals : 0x2::table::new<vector<u8>, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<ZKProxyVaultState>(v4);
    }

    public fun is_paused(arg0: &ZKProxyVaultState) : bool {
        arg0.paused
    }

    public entry fun pause(arg0: &GuardianCap, arg1: &mut ZKProxyVaultState) {
        arg1.paused = true;
    }

    public entry fun set_time_lock_params(arg0: &AdminCap, arg1: &mut ZKProxyVaultState, arg2: u64, arg3: u64) {
        arg1.time_lock_threshold = arg2;
        arg1.time_lock_duration = arg3;
    }

    public entry fun set_zk_verifier(arg0: &AdminCap, arg1: &mut ZKProxyVaultState, arg2: 0x2::object::ID) {
        arg1.zk_verifier = 0x1::option::some<0x2::object::ID>(arg2);
        let v0 = ZKVerifierUpdated{
            old_verifier : arg1.zk_verifier,
            new_verifier : arg1.zk_verifier,
        };
        0x2::event::emit<ZKVerifierUpdated>(v0);
    }

    public entry fun unpause(arg0: &AdminCap, arg1: &mut ZKProxyVaultState) {
        arg1.paused = false;
    }

    public fun verify_proxy_ownership(arg0: &ProxyBinding, arg1: address) : bool {
        arg0.owner == arg1 && arg0.is_active
    }

    fun verify_zk_proof(arg0: address, arg1: address, arg2: &vector<u8>, arg3: &vector<u8>, arg4: &vector<vector<u8>>) : bool {
        if (0x1::vector::length<u8>(arg3) < 64) {
            return false
        };
        if (0x1::vector::length<vector<u8>>(arg4) < 4) {
            return false
        };
        let v0 = derive_binding_hash(arg0, arg1);
        if (0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(arg4, 0)) != 0x1::vector::length<u8>(&v0)) {
            return false
        };
        true
    }

    public entry fun withdraw(arg0: &mut ZKProxyVaultState, arg1: &mut ProxyBinding, arg2: u64, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 11);
        assert!(arg2 > 0, 9);
        assert!(arg1.is_active, 2);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg1.owner == v0, 3);
        assert!(arg1.deposited_amount >= arg2, 5);
        assert!(verify_zk_proof(v0, arg1.proxy_address, &arg1.zk_binding_hash, &arg3, &arg4), 4);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        if (arg2 >= arg0.time_lock_threshold) {
            let v2 = derive_withdrawal_id(v0, 0x2::object::id<ProxyBinding>(arg1), arg2, v1);
            let v3 = PendingWithdrawal{
                id            : 0x2::object::new(arg6),
                withdrawal_id : v2,
                owner         : v0,
                proxy_id      : 0x2::object::id<ProxyBinding>(arg1),
                amount        : arg2,
                unlock_time   : v1 + arg0.time_lock_duration,
                executed      : false,
                cancelled     : false,
            };
            arg1.deposited_amount = arg1.deposited_amount - arg2;
            0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg0.pending_withdrawals, v2, 0x2::object::id<PendingWithdrawal>(&v3));
            let v4 = WithdrawalRequested{
                withdrawal_id : v2,
                owner         : v0,
                proxy_id      : 0x2::object::id<ProxyBinding>(arg1),
                amount        : arg2,
                unlock_time   : v3.unlock_time,
            };
            0x2::event::emit<WithdrawalRequested>(v4);
            0x2::transfer::share_object<PendingWithdrawal>(v3);
        } else {
            arg1.deposited_amount = arg1.deposited_amount - arg2;
            arg0.total_value_locked = arg0.total_value_locked - arg2;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, arg2), arg6), v0);
            let v5 = InstantWithdrawal{
                owner    : v0,
                proxy_id : 0x2::object::id<ProxyBinding>(arg1),
                amount   : arg2,
            };
            0x2::event::emit<InstantWithdrawal>(v5);
        };
    }

    // decompiled from Move bytecode v7
}

