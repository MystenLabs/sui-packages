module 0x50a0583be0008d76f2d94988b1d81960b61e18a647deb3004052f0ce038341bb::treasury {
    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        wal: 0x2::balance::Balance<T0>,
        claimed: 0x2::table::Table<address, bool>,
    }

    struct TreasuryDeposit has copy, drop {
        sui_in: u64,
        wal_in: u64,
        post_sui: u64,
        post_wal: u64,
    }

    struct TreasuryDraw has copy, drop {
        recipient: address,
        sui_out: u64,
        wal_out: u64,
        post_sui: u64,
        post_wal: u64,
    }

    public fun balances<T0>(arg0: &Treasury<T0>) : (u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui), 0x2::balance::value<T0>(&arg0.wal))
    }

    entry fun claim_provision<T0>(arg0: &mut Treasury<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x2::table::contains<address, bool>(&arg0.claimed, v0), 1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui) >= 11000000, 2);
        assert!(0x2::balance::value<T0>(&arg0.wal) >= 53000000, 3);
        0x2::table::add<address, bool>(&mut arg0.claimed, v0, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui, 11000000), arg1), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.wal, 53000000), arg1), v0);
        let v1 = TreasuryDraw{
            recipient : v0,
            sui_out   : 11000000,
            wal_out   : 53000000,
            post_sui  : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui),
            post_wal  : 0x2::balance::value<T0>(&arg0.wal),
        };
        0x2::event::emit<TreasuryDraw>(v1);
    }

    entry fun create_treasury<T0>(arg0: &OperatorCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury<T0>{
            id      : 0x2::object::new(arg1),
            sui     : 0x2::balance::zero<0x2::sui::SUI>(),
            wal     : 0x2::balance::zero<T0>(),
            claimed : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<Treasury<T0>>(v0);
    }

    entry fun deposit_sui<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = TreasuryDeposit{
            sui_in   : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            wal_in   : 0,
            post_sui : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui),
            post_wal : 0x2::balance::value<T0>(&arg0.wal),
        };
        0x2::event::emit<TreasuryDeposit>(v0);
    }

    entry fun deposit_wal<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.wal, 0x2::coin::into_balance<T0>(arg1));
        let v0 = TreasuryDeposit{
            sui_in   : 0,
            wal_in   : 0x2::coin::value<T0>(&arg1),
            post_sui : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui),
            post_wal : 0x2::balance::value<T0>(&arg0.wal),
        };
        0x2::event::emit<TreasuryDeposit>(v0);
    }

    public fun has_claimed<T0>(arg0: &Treasury<T0>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.claimed, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OperatorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun provision_amounts() : (u64, u64) {
        (11000000, 53000000)
    }

    public fun thresholds() : (u64, u64, u64, u64) {
        (7200000000, 309000000000, 2900000000, 124000000000)
    }

    entry fun withdraw<T0>(arg0: &OperatorCap, arg1: &mut Treasury<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        if (arg2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui, arg2), arg4), v0);
        };
        if (arg3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.wal, arg3), arg4), v0);
        };
        let v1 = TreasuryDraw{
            recipient : v0,
            sui_out   : arg2,
            wal_out   : arg3,
            post_sui  : 0x2::balance::value<0x2::sui::SUI>(&arg1.sui),
            post_wal  : 0x2::balance::value<T0>(&arg1.wal),
        };
        0x2::event::emit<TreasuryDraw>(v1);
    }

    // decompiled from Move bytecode v7
}

