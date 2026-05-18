module 0x330aa337772418f68117556dce74034063f11a8de68f60a99acc9a5ee62f5fb3::stake_vault {
    struct Vault has key {
        id: 0x2::object::UID,
        total_staked: 0x2::balance::Balance<0x2::sui::SUI>,
        pending_yield: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct VaultAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StakeReceipt has store, key {
        id: 0x2::object::UID,
        owner: address,
        principal_mist: u64,
        deposit_ts_ms: u64,
        unlock_ts_ms: 0x1::option::Option<u64>,
    }

    struct Deposited has copy, drop {
        staker: address,
        amount_mist: u64,
        receipt_id: 0x2::object::ID,
    }

    struct UnstakeRequested has copy, drop {
        staker: address,
        receipt_id: 0x2::object::ID,
        unlock_ts_ms: u64,
    }

    struct Withdrawn has copy, drop {
        staker: address,
        amount_mist: u64,
    }

    entry fun add_yield(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pending_yield, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    entry fun deposit(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 1000000000, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.total_staked, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = StakeReceipt{
            id             : 0x2::object::new(arg3),
            owner          : 0x2::tx_context::sender(arg3),
            principal_mist : v0,
            deposit_ts_ms  : 0x2::clock::timestamp_ms(arg2),
            unlock_ts_ms   : 0x1::option::none<u64>(),
        };
        let v2 = Deposited{
            staker      : 0x2::tx_context::sender(arg3),
            amount_mist : v0,
            receipt_id  : 0x2::object::id<StakeReceipt>(&v1),
        };
        0x2::event::emit<Deposited>(v2);
        0x2::transfer::transfer<StakeReceipt>(v1, 0x2::tx_context::sender(arg3));
    }

    public fun harvest_yield(arg0: &mut Vault, arg1: &VaultAdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pending_yield, 0x2::balance::value<0x2::sui::SUI>(&arg0.pending_yield)), arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id            : 0x2::object::new(arg0),
            total_staked  : 0x2::balance::zero<0x2::sui::SUI>(),
            pending_yield : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Vault>(v0);
        let v1 = VaultAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<VaultAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun pending_yield_amount(arg0: &Vault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pending_yield)
    }

    public fun receipt_owner(arg0: &StakeReceipt) : address {
        arg0.owner
    }

    public fun receipt_principal(arg0: &StakeReceipt) : u64 {
        arg0.principal_mist
    }

    entry fun request_unstake(arg0: &mut StakeReceipt, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        assert!(0x1::option::is_none<u64>(&arg0.unlock_ts_ms), 3);
        let v0 = 0x2::clock::timestamp_ms(arg1) + 86400000;
        arg0.unlock_ts_ms = 0x1::option::some<u64>(v0);
        let v1 = UnstakeRequested{
            staker       : 0x2::tx_context::sender(arg2),
            receipt_id   : 0x2::object::id<StakeReceipt>(arg0),
            unlock_ts_ms : v0,
        };
        0x2::event::emit<UnstakeRequested>(v1);
    }

    public fun total_staked(arg0: &Vault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.total_staked)
    }

    entry fun withdraw(arg0: &mut Vault, arg1: StakeReceipt, arg2: &mut 0x330aa337772418f68117556dce74034063f11a8de68f60a99acc9a5ee62f5fb3::loyalty_tracker::LoyaltyRecord, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg4), 1);
        assert!(0x2::clock::timestamp_ms(arg3) >= *0x1::option::borrow<u64>(&arg1.unlock_ts_ms), 2);
        let StakeReceipt {
            id             : v0,
            owner          : _,
            principal_mist : v2,
            deposit_ts_ms  : _,
            unlock_ts_ms   : _,
        } = arg1;
        0x2::object::delete(v0);
        0x330aa337772418f68117556dce74034063f11a8de68f60a99acc9a5ee62f5fb3::loyalty_tracker::reset(arg2, arg3, arg4);
        let v5 = Withdrawn{
            staker      : 0x2::tx_context::sender(arg4),
            amount_mist : v2,
        };
        0x2::event::emit<Withdrawn>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.total_staked, v2), arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v7
}

