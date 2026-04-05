module 0xaa422424f017d72be53e3033d67a0a3fa0fcb4b0a2c162f70e06a698102299d::executor {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        launch_ms: u64,
        total_arbs: u64,
        total_gross_profit: u64,
        total_keeper_paid: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        launch_ms: u64,
        admin: address,
    }

    struct ArbExecuted has copy, drop {
        vault_id: 0x2::object::ID,
        keeper: address,
        amount_in: u64,
        amount_out: u64,
        gross_profit: u64,
        keeper_reward: u64,
        reward_bps: u64,
    }

    public fun borrow_for_arb<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 4);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2)
    }

    public fun create_vault<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = Vault<T0>{
            id                 : 0x2::object::new(arg1),
            balance            : 0x2::balance::zero<T0>(),
            launch_ms          : v0,
            total_arbs         : 0,
            total_gross_profit : 0,
            total_keeper_paid  : 0,
        };
        let v2 = 0x2::object::id<Vault<T0>>(&v1);
        let v3 = AdminCap{
            id       : 0x2::object::new(arg1),
            vault_id : v2,
        };
        let v4 = VaultCreated{
            vault_id  : v2,
            launch_ms : v0,
            admin     : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<VaultCreated>(v4);
        0x2::transfer::share_object<Vault<T0>>(v1);
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun current_reward_bps<T0>(arg0: &Vault<T0>, arg1: &0x2::clock::Clock) : u64 {
        if (0x2::clock::timestamp_ms(arg1) - arg0.launch_ms < 2592000000) {
            5000
        } else {
            2000
        }
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: &AdminCap, arg2: 0x2::coin::Coin<T0>) {
        assert!(0x2::object::id<Vault<T0>>(arg0) == arg1.vault_id, 3);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun settle_arb<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= arg2 + arg3, 1);
        let v1 = v0 - arg2;
        let v2 = current_reward_bps<T0>(arg0, arg4);
        let v3 = v1 * v2 / 10000;
        let v4 = 0x2::coin::into_balance<T0>(arg1);
        0x2::balance::join<T0>(&mut arg0.balance, v4);
        arg0.total_arbs = arg0.total_arbs + 1;
        arg0.total_gross_profit = arg0.total_gross_profit + v1;
        arg0.total_keeper_paid = arg0.total_keeper_paid + v3;
        let v5 = 0x2::tx_context::sender(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v4, v3), arg5), v5);
        let v6 = ArbExecuted{
            vault_id      : 0x2::object::id<Vault<T0>>(arg0),
            keeper        : v5,
            amount_in     : arg2,
            amount_out    : v0,
            gross_profit  : v1,
            keeper_reward : v3,
            reward_bps    : v2,
        };
        0x2::event::emit<ArbExecuted>(v6);
    }

    public fun vault_balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun vault_launch_ms<T0>(arg0: &Vault<T0>) : u64 {
        arg0.launch_ms
    }

    public fun vault_stats<T0>(arg0: &Vault<T0>) : (u64, u64, u64) {
        (arg0.total_arbs, arg0.total_gross_profit, arg0.total_keeper_paid)
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Vault<T0>>(arg0) == arg1.vault_id, 3);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

