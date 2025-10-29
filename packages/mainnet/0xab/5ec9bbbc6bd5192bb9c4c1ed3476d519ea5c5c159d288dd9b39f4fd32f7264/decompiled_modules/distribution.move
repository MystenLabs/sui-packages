module 0xab5ec9bbbc6bd5192bb9c4c1ed3476d519ea5c5c159d288dd9b39f4fd32f7264::distribution {
    struct DISTRIBUTION has drop {
        dummy_field: bool,
    }

    struct DistributionPool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>,
        hashes: 0x2::vec_set::VecSet<address>,
        recipients: 0x2::linked_table::LinkedTable<address, vector<u64>>,
        total_pool_amount: u64,
    }

    public fun new(arg0: &0xab5ec9bbbc6bd5192bb9c4c1ed3476d519ea5c5c159d288dd9b39f4fd32f7264::config::AirdropConfigCap, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = DistributionPool{
            id                : 0x2::object::new(arg2),
            balance           : 0x2::balance::zero<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(),
            hashes            : 0x2::vec_set::from_keys<address>(arg1),
            recipients        : 0x2::linked_table::new<address, vector<u64>>(arg2),
            total_pool_amount : 0,
        };
        0x2::transfer::share_object<DistributionPool>(v0);
    }

    public(friend) fun create_hash(arg0: vector<address>, arg1: vector<u64>, arg2: vector<u64>) : address {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<address>>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u64>>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u64>>(&arg2));
        0x2::address::from_bytes(0x2::hash::blake2b256(&v0))
    }

    public fun distribute(arg0: &mut DistributionPool, arg1: &0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_admin::StakingAdminCap, arg2: &0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_config::StakingConfig, arg3: &mut 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::stats::Stats, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_set::length<address>(&arg0.hashes) == 0, 4);
        assert!(0x2::balance::value<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(&arg0.balance) > 0, 5);
        assert!(0x2::linked_table::length<address, vector<u64>>(&arg0.recipients) > 0, 7);
        let v0 = 0;
        while (v0 < 0x1::u64::min(0x2::linked_table::length<address, vector<u64>>(&arg0.recipients), arg5)) {
            let (v1, v2) = 0x2::linked_table::pop_back<address, vector<u64>>(&mut arg0.recipients);
            let v3 = v2;
            0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_batch::admin_new(arg1, arg2, arg3, 0x2::coin::from_balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(0x2::balance::split<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(&mut arg0.balance, *0x1::vector::borrow<u64>(&v3, 0)), arg6), 0, *0x1::vector::borrow<u64>(&v3, 1), v1, arg4, arg6);
            v0 = v0 + 1;
        };
    }

    public fun fund_pool(arg0: &mut DistributionPool, arg1: 0x2::coin::Coin<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>) {
        assert!(0x2::linked_table::length<address, vector<u64>>(&arg0.recipients) > 0, 4);
        assert!(0x2::vec_set::length<address>(&arg0.hashes) == 0, 4);
        assert!(0x2::balance::value<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(&arg0.balance) == 0, 6);
        assert!(0x2::coin::value<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(&arg1) == arg0.total_pool_amount, 3);
        0x2::balance::join<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(&mut arg0.balance, 0x2::coin::into_balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(arg1));
    }

    fun init(arg0: DISTRIBUTION, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<DISTRIBUTION>(arg0, arg1);
    }

    public fun prepare_recipients(arg0: &mut DistributionPool, arg1: vector<address>, arg2: vector<u64>, arg3: vector<u64>) {
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 2);
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg3), 2);
        let v0 = create_hash(arg1, arg2, arg3);
        assert!(0x2::vec_set::contains<address>(&arg0.hashes, &v0), 1);
        0x2::vec_set::remove<address>(&mut arg0.hashes, &v0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg1)) {
            let v2 = 0x1::vector::pop_back<u64>(&mut arg2);
            arg0.total_pool_amount = arg0.total_pool_amount + v2;
            let v3 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v3, v2);
            0x1::vector::push_back<u64>(&mut v3, 0x1::vector::pop_back<u64>(&mut arg3));
            0x2::linked_table::push_back<address, vector<u64>>(&mut arg0.recipients, 0x1::vector::pop_back<address>(&mut arg1), v3);
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

