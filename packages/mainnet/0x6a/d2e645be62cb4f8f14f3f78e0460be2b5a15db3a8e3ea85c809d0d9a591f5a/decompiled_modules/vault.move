module 0x6ad2e645be62cb4f8f14f3f78e0460be2b5a15db3a8e3ea85c809d0d9a591f5a::vault {
    struct VaultAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OrderCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        admin: 0x2::object::ID,
        taker_balances: 0x2::table::Table<address, u64>,
        balance: 0x2::balance::Balance<T0>,
    }

    struct Deposited has copy, drop {
        trader: address,
        amount: u64,
    }

    struct Withdrawn has copy, drop {
        trader: address,
        amount: u64,
    }

    public fun add_funds<T0>(arg0: &OrderCap, arg1: &mut Vault<T0>, arg2: 0x2::coin::Coin<T0>) {
        assert!(arg1.version == 1, 13906835278150696972);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun adjust_taker_balance<T0>(arg0: &OrderCap, arg1: &mut Vault<T0>, arg2: address, arg3: u64, arg4: bool) {
        assert!(arg1.version == 1, 13906835067697299468);
        if (arg4) {
            if (0x2::table::contains<address, u64>(&arg1.taker_balances, arg2)) {
                0x2::table::add<address, u64>(&mut arg1.taker_balances, arg2, 0x2::table::remove<address, u64>(&mut arg1.taker_balances, arg2) + arg3);
            } else {
                0x2::table::add<address, u64>(&mut arg1.taker_balances, arg2, arg3);
            };
        } else if (0x2::table::contains<address, u64>(&arg1.taker_balances, arg2)) {
            let v0 = 0x2::table::remove<address, u64>(&mut arg1.taker_balances, arg2);
            if (v0 > arg3) {
                0x2::table::add<address, u64>(&mut arg1.taker_balances, arg2, v0 - arg3);
            };
        };
    }

    public fun check_vault_balance<T0>(arg0: &Vault<T0>, arg1: u64) : bool {
        0x2::balance::value<T0>(&arg0.balance) >= arg1
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906834659675406348);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 13906834672559652866);
        let v1 = 0x2::tx_context::sender(arg2);
        if (0x2::table::contains<address, u64>(&arg0.taker_balances, v1)) {
            0x2::table::add<address, u64>(&mut arg0.taker_balances, v1, 0x2::table::remove<address, u64>(&mut arg0.taker_balances, v1) + v0);
        } else {
            0x2::table::add<address, u64>(&mut arg0.taker_balances, v1, v0);
        };
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v2 = Deposited{
            trader : v1,
            amount : v0,
        };
        0x2::event::emit<Deposited>(v2);
    }

    public fun get_withdrawable_balance_with_locked<T0>(arg0: &OrderCap, arg1: &Vault<T0>, arg2: address, arg3: u64) : u64 {
        assert!(arg1.version == 1, 13906835402704748556);
        let v0 = taker_balance<T0>(arg1, arg2);
        if (v0 >= arg3) {
            v0 - arg3
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<VaultAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun initialize<T0>(arg0: &VaultAdminCap, arg1: &mut 0x2::tx_context::TxContext) : OrderCap {
        let v0 = OrderCap{id: 0x2::object::new(arg1)};
        let v1 = Vault<T0>{
            id             : 0x2::object::new(arg1),
            version        : 1,
            admin          : 0x2::object::id<VaultAdminCap>(arg0),
            taker_balances : 0x2::table::new<address, u64>(arg1),
            balance        : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Vault<T0>>(v1);
        v0
    }

    entry fun migrate<T0>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap) {
        assert!(arg0.admin == 0x2::object::id<VaultAdminCap>(arg1), 13906834938848018440);
        assert!(arg0.version < 1, 13906834943143116810);
        arg0.version = 1;
    }

    public fun taker_balance<T0>(arg0: &Vault<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.taker_balances, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.taker_balances, arg1)
        } else {
            0
        }
    }

    public fun total_asset_available<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun transfer_fee_to_treasury<T0>(arg0: &OrderCap, arg1: &mut Vault<T0>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.version == 1, 13906835187956383756);
        if (0x2::table::contains<address, u64>(&arg1.taker_balances, arg2)) {
            let v0 = 0x2::table::remove<address, u64>(&mut arg1.taker_balances, arg2);
            if (v0 > arg3) {
                0x2::table::add<address, u64>(&mut arg1.taker_balances, arg2, v0 - arg3);
            };
        };
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg3), arg4)
    }

    public fun transfer_to_maker_vault<T0>(arg0: &OrderCap, arg1: &mut Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.version == 1, 13906835007567757324);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg3)
    }

    public fun validate_address(arg0: address) {
        assert!(arg0 != @0x0, 13906835505783439364);
    }

    public fun validate_amount(arg0: u64) {
        assert!(arg0 > 0, 13906835484308471810);
    }

    public fun withdraw<T0>(arg0: &OrderCap, arg1: &mut Vault<T0>, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.version == 1, 13906834809999261708);
        assert!(arg3 > 0, 13906834814293573634);
        assert!(arg3 <= get_withdrawable_balance_with_locked<T0>(arg0, arg1, arg2, arg4), 13906834831473704966);
        let v0 = 0x2::table::remove<address, u64>(&mut arg1.taker_balances, arg2);
        if (v0 > arg3) {
            0x2::table::add<address, u64>(&mut arg1.taker_balances, arg2, v0 - arg3);
        };
        let v1 = Withdrawn{
            trader : arg2,
            amount : arg3,
        };
        0x2::event::emit<Withdrawn>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg3), arg5)
    }

    // decompiled from Move bytecode v6
}

