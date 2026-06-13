module 0x525e259ff2267935a6b7007ffea52ebf6e51ef66e11c8903c1481ebc907b2911::vault {
    struct VaultAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        strategy: 0x1::string::String,
        apy_bps: u64,
        lp_apr_bps: u64,
        delta_apr_bps: u64,
        funds: 0x2::balance::Balance<T0>,
        depositor_count: u64,
        rewards_accrued: u64,
        last_update_ms: u64,
        positions: 0x2::table::Table<0x2::object::ID, Position>,
    }

    struct Position has copy, drop, store {
        owner: address,
        principal: u64,
        deposited_ms: u64,
    }

    struct VaultReceipt has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        principal: u64,
        deposited_ms: u64,
    }

    struct VaultCreated has copy, drop {
        vault: 0x2::object::ID,
        name: 0x1::string::String,
    }

    struct Deposited has copy, drop {
        vault: 0x2::object::ID,
        owner: address,
        principal: u64,
        receipt: 0x2::object::ID,
    }

    struct Withdrawn has copy, drop {
        vault: 0x2::object::ID,
        owner: address,
        principal: u64,
        receipt: 0x2::object::ID,
    }

    struct YieldUpdated has copy, drop {
        vault: 0x2::object::ID,
        apy_bps: u64,
        rewards_accrued: u64,
    }

    public fun admin_update_yield<T0>(arg0: &VaultAdminCap, arg1: &mut Vault<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        arg1.apy_bps = arg2;
        arg1.lp_apr_bps = arg3;
        arg1.delta_apr_bps = arg4;
        arg1.rewards_accrued = arg5;
        arg1.last_update_ms = 0x2::clock::timestamp_ms(arg6);
        let v0 = YieldUpdated{
            vault           : 0x2::object::id<Vault<T0>>(arg1),
            apy_bps         : arg2,
            rewards_accrued : arg5,
        };
        0x2::event::emit<YieldUpdated>(v0);
    }

    public fun apy_bps<T0>(arg0: &Vault<T0>) : u64 {
        arg0.apy_bps
    }

    public fun create_vault<T0>(arg0: &VaultAdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id              : 0x2::object::new(arg7),
            name            : 0x1::string::utf8(arg1),
            strategy        : 0x1::string::utf8(arg2),
            apy_bps         : arg3,
            lp_apr_bps      : arg4,
            delta_apr_bps   : arg5,
            funds           : 0x2::balance::zero<T0>(),
            depositor_count : 0,
            rewards_accrued : 0,
            last_update_ms  : 0x2::clock::timestamp_ms(arg6),
            positions       : 0x2::table::new<0x2::object::ID, Position>(arg7),
        };
        let v1 = VaultCreated{
            vault : 0x2::object::id<Vault<T0>>(&v0),
            name  : v0.name,
        };
        0x2::event::emit<VaultCreated>(v1);
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 1);
        0x2::balance::join<T0>(&mut arg0.funds, 0x2::coin::into_balance<T0>(arg1));
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = VaultReceipt{
            id           : 0x2::object::new(arg3),
            vault_id     : 0x2::object::id<Vault<T0>>(arg0),
            principal    : v0,
            deposited_ms : v1,
        };
        let v3 = 0x2::object::id<VaultReceipt>(&v2);
        let v4 = Position{
            owner        : 0x2::tx_context::sender(arg3),
            principal    : v0,
            deposited_ms : v1,
        };
        0x2::table::add<0x2::object::ID, Position>(&mut arg0.positions, v3, v4);
        arg0.depositor_count = arg0.depositor_count + 1;
        let v5 = Deposited{
            vault     : 0x2::object::id<Vault<T0>>(arg0),
            owner     : 0x2::tx_context::sender(arg3),
            principal : v0,
            receipt   : v3,
        };
        0x2::event::emit<Deposited>(v5);
        0x2::transfer::public_transfer<VaultReceipt>(v2, 0x2::tx_context::sender(arg3));
    }

    public fun depositor_count<T0>(arg0: &Vault<T0>) : u64 {
        arg0.depositor_count
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<VaultAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun rewards_accrued<T0>(arg0: &Vault<T0>) : u64 {
        arg0.rewards_accrued
    }

    public fun tvl<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: VaultReceipt, arg2: &mut 0x2::tx_context::TxContext) {
        let VaultReceipt {
            id           : v0,
            vault_id     : v1,
            principal    : v2,
            deposited_ms : _,
        } = arg1;
        let v4 = v0;
        assert!(v1 == 0x2::object::id<Vault<T0>>(arg0), 2);
        let v5 = 0x2::object::uid_to_inner(&v4);
        let v6 = 0x2::table::remove<0x2::object::ID, Position>(&mut arg0.positions, v5);
        assert!(v6.owner == 0x2::tx_context::sender(arg2), 3);
        assert!(0x2::balance::value<T0>(&arg0.funds) >= v2, 4);
        if (arg0.depositor_count > 0) {
            arg0.depositor_count = arg0.depositor_count - 1;
        };
        0x2::object::delete(v4);
        let v7 = Withdrawn{
            vault     : 0x2::object::id<Vault<T0>>(arg0),
            owner     : 0x2::tx_context::sender(arg2),
            principal : v2,
            receipt   : v5,
        };
        0x2::event::emit<Withdrawn>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.funds, v2, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

