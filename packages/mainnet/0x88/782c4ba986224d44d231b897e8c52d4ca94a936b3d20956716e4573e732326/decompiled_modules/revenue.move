module 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::revenue {
    struct Vault has key {
        id: 0x2::object::UID,
        version: u64,
        pool: 0x2::balance::Balance<0x2::sui::SUI>,
        shares: 0x2::vec_map::VecMap<address, u64>,
        owed: 0x2::vec_map::VecMap<address, u64>,
    }

    struct Deposited has copy, drop {
        amount: u64,
    }

    struct Claimed has copy, drop {
        who: address,
        amount: u64,
    }

    struct SharesSet has copy, drop {
        n: u64,
    }

    public fun new(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: 0x2::vec_map::VecMap<address, u64>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0x2::vec_map::length<address, u64>(&arg1);
        let v2 = 0;
        while (v2 < v1) {
            let (_, v4) = 0x2::vec_map::get_entry_by_idx<address, u64>(&arg1, v2);
            v0 = v0 + *v4;
            v2 = v2 + 1;
        };
        assert!(v0 == 10000 && v1 > 0, 0);
        let v5 = 0x2::vec_map::empty<address, u64>();
        v2 = 0;
        while (v2 < v1) {
            let (v6, _) = 0x2::vec_map::get_entry_by_idx<address, u64>(&arg1, v2);
            0x2::vec_map::insert<address, u64>(&mut v5, *v6, 0);
            v2 = v2 + 1;
        };
        let v8 = Vault{
            id      : 0x2::object::new(arg2),
            version : 1,
            pool    : 0x2::balance::zero<0x2::sui::SUI>(),
            shares  : arg1,
            owed    : v5,
        };
        0x2::transfer::share_object<Vault>(v8);
    }

    public fun claim(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.version == 1, 2);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.owed, &v0);
        let v2 = *v1;
        assert!(v2 > 0, 1);
        *v1 = 0;
        let v3 = Claimed{
            who    : v0,
            amount : v2,
        };
        0x2::event::emit<Claimed>(v3);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.pool, v2, arg1)
    }

    public fun deposit(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(arg0.version == 1, 2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = 0x2::vec_map::length<address, u64>(&arg0.shares);
        let v2 = 0;
        let v3 = 0;
        while (v2 < v1) {
            let (v4, v5) = 0x2::vec_map::get_entry_by_idx<address, u64>(&arg0.shares, v2);
            let v6 = *v4;
            let v7 = if (v2 + 1 == v1) {
                v0 - v3
            } else {
                (((v0 as u128) * (*v5 as u128) / (10000 as u128)) as u64)
            };
            v3 = v3 + v7;
            let v8 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.owed, &v6);
            *v8 = *v8 + v7;
            v2 = v2 + 1;
        };
        let v9 = Deposited{amount: v0};
        0x2::event::emit<Deposited>(v9);
    }

    public fun migrate(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut Vault) {
        assert!(arg1.version < 1, 2);
        arg1.version = 1;
    }

    public fun owed_of(arg0: &Vault, arg1: address) : u64 {
        if (0x2::vec_map::contains<address, u64>(&arg0.owed, &arg1)) {
            *0x2::vec_map::get<address, u64>(&arg0.owed, &arg1)
        } else {
            0
        }
    }

    public fun rotate_address(arg0: &mut Vault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_map::contains<address, u64>(&arg0.shares, &v0), 3);
        assert!(!0x2::vec_map::contains<address, u64>(&arg0.shares, &arg1), 4);
        let (_, v2) = 0x2::vec_map::remove<address, u64>(&mut arg0.shares, &v0);
        0x2::vec_map::insert<address, u64>(&mut arg0.shares, arg1, v2);
        let (_, v4) = 0x2::vec_map::remove<address, u64>(&mut arg0.owed, &v0);
        if (0x2::vec_map::contains<address, u64>(&arg0.owed, &arg1)) {
            let v5 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.owed, &arg1);
            *v5 = *v5 + v4;
        } else {
            0x2::vec_map::insert<address, u64>(&mut arg0.owed, arg1, v4);
        };
    }

    public fun set_shares(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut Vault, arg2: 0x2::vec_map::VecMap<address, u64>) {
        assert!(arg1.version == 1, 2);
        let v0 = 0;
        let v1 = 0x2::vec_map::length<address, u64>(&arg2);
        let v2 = 0;
        while (v2 < v1) {
            let (_, v4) = 0x2::vec_map::get_entry_by_idx<address, u64>(&arg2, v2);
            v0 = v0 + *v4;
            v2 = v2 + 1;
        };
        assert!(v0 == 10000 && v1 > 0, 0);
        v2 = 0;
        while (v2 < v1) {
            let (v5, _) = 0x2::vec_map::get_entry_by_idx<address, u64>(&arg2, v2);
            if (!0x2::vec_map::contains<address, u64>(&arg1.owed, v5)) {
                0x2::vec_map::insert<address, u64>(&mut arg1.owed, *v5, 0);
            };
            v2 = v2 + 1;
        };
        arg1.shares = arg2;
        let v7 = SharesSet{n: v1};
        0x2::event::emit<SharesSet>(v7);
    }

    // decompiled from Move bytecode v7
}

