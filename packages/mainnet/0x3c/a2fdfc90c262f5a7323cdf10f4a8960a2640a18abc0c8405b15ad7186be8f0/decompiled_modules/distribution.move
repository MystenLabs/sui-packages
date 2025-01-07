module 0x220bca2187856d09aae578e2782b2b484049a32c755d20352e01236ba5368b63::distribution {
    struct DISTRIBUTION has drop {
        dummy_field: bool,
    }

    struct SetupCap has key {
        id: 0x2::object::UID,
    }

    struct NSWrapper has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>,
    }

    struct NSAirdrop has key {
        id: 0x2::object::UID,
        amount: u64,
    }

    struct AirdropPool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>,
        hashes: 0x2::vec_set::VecSet<address>,
        recipients: 0x2::table::Table<address, u64>,
        total_pool_amount: u64,
    }

    public fun amount_claimed(arg0: &NSAirdrop) : u64 {
        arg0.amount
    }

    public fun distribute(arg0: &mut AirdropPool, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_set::size<address>(&arg0.hashes) == 0, 6);
        assert!(0x2::balance::value<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(&arg0.balance) > 0, 8);
        let v0 = 0x1::vector::length<address>(&arg1);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = 0x1::vector::pop_back<address>(&mut arg1);
            assert!(0x2::table::contains<address, u64>(&arg0.recipients, v1), 7);
            let v2 = NSWrapper{
                id      : 0x2::object::new(arg2),
                balance : 0x2::balance::split<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(&mut arg0.balance, 0x2::table::remove<address, u64>(&mut arg0.recipients, v1)),
            };
            0x2::transfer::transfer<NSWrapper>(v2, v1);
        };
    }

    public fun fund_pool(arg0: &mut AirdropPool, arg1: 0x2::coin::Coin<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>) {
        assert!(0x2::table::length<address, u64>(&arg0.recipients) > 0, 6);
        assert!(0x2::vec_set::size<address>(&arg0.hashes) == 0, 6);
        assert!(0x2::balance::value<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(&arg0.balance) == 0, 9);
        assert!(0x2::coin::value<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(&arg1) == arg0.total_pool_amount, 4);
        0x2::coin::put<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(&mut arg0.balance, arg1);
    }

    fun init(arg0: DISTRIBUTION, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<DISTRIBUTION>(arg0, arg1);
        let v0 = AirdropPool{
            id                : 0x2::object::new(arg1),
            balance           : 0x2::balance::zero<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(),
            hashes            : 0x2::vec_set::empty<address>(),
            recipients        : 0x2::table::new<address, u64>(arg1),
            total_pool_amount : 0,
        };
        0x2::transfer::share_object<AirdropPool>(v0);
        let v1 = SetupCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SetupCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun prepare_recipients(arg0: &mut AirdropPool, arg1: vector<address>, arg2: vector<u64>) {
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 3);
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<address>>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u64>>(&arg2));
        let v1 = 0x2::address::from_bytes(0x2::hash::blake2b256(&v0));
        assert!(0x2::vec_set::contains<address>(&arg0.hashes, &v1), 2);
        0x2::vec_set::remove<address>(&mut arg0.hashes, &v1);
        let v2 = 0x1::vector::length<address>(&arg1);
        while (v2 > 0) {
            v2 = v2 - 1;
            let v3 = 0x1::vector::pop_back<u64>(&mut arg2);
            arg0.total_pool_amount = arg0.total_pool_amount + v3;
            0x2::table::add<address, u64>(&mut arg0.recipients, 0x1::vector::pop_back<address>(&mut arg1), v3);
        };
    }

    public fun setup(arg0: &mut AirdropPool, arg1: SetupCap, arg2: vector<address>) {
        let SetupCap { id: v0 } = arg1;
        0x2::object::delete(v0);
        let v1 = 0x1::vector::length<address>(&arg2);
        while (v1 > 0) {
            v1 = v1 - 1;
            let v2 = 0x1::vector::pop_back<address>(&mut arg2);
            assert!(!0x2::vec_set::contains<address>(&arg0.hashes, &v2), 1);
            0x2::vec_set::insert<address>(&mut arg0.hashes, v2);
        };
    }

    public fun unwrap(arg0: NSWrapper, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS> {
        let NSWrapper {
            id      : v0,
            balance : v1,
        } = arg0;
        let v2 = v1;
        0x2::object::delete(v0);
        let v3 = NSAirdrop{
            id     : 0x2::object::new(arg1),
            amount : 0x2::balance::value<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(&v2),
        };
        0x2::transfer::transfer<NSAirdrop>(v3, 0x2::tx_context::sender(arg1));
        0x2::coin::from_balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(v2, arg1)
    }

    // decompiled from Move bytecode v6
}

