module 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::supply_manager {
    struct SupplyData has copy, drop, store {
        shares: u64,
        last_supply_ms: u64,
    }

    struct SupplyManager has store {
        supplies: 0x2::table::Table<address, SupplyData>,
        total_shares: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : SupplyManager {
        SupplyManager{
            supplies     : 0x2::table::new<address, SupplyData>(arg0),
            total_shares : 0,
        }
    }

    fun add_supply_entry(arg0: &mut SupplyManager, arg1: address) {
        if (!0x2::table::contains<address, SupplyData>(&arg0.supplies, arg1)) {
            let v0 = SupplyData{
                shares         : 0,
                last_supply_ms : 0,
            };
            0x2::table::add<address, SupplyData>(&mut arg0.supplies, arg1, v0);
        };
    }

    public(friend) fun supply(arg0: &mut SupplyManager, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : u64 {
        assert!(arg1 > 0, 1);
        let v0 = if (arg0.total_shares == 0) {
            arg1
        } else {
            0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::math::div(arg1, 0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::math::div(arg2 + arg4 - arg3, arg0.total_shares))
        };
        let v1 = 0x2::tx_context::sender(arg6);
        add_supply_entry(arg0, v1);
        let v2 = 0x2::table::borrow_mut<address, SupplyData>(&mut arg0.supplies, v1);
        v2.shares = v2.shares + v0;
        v2.last_supply_ms = 0x2::clock::timestamp_ms(arg5);
        arg0.total_shares = arg0.total_shares + v0;
        v0
    }

    public fun supply_data(arg0: &SupplyManager, arg1: address) : (u64, u64) {
        if (0x2::table::contains<address, SupplyData>(&arg0.supplies, arg1)) {
            let v2 = *0x2::table::borrow<address, SupplyData>(&arg0.supplies, arg1);
            (v2.shares, v2.last_supply_ms)
        } else {
            (0, 0)
        }
    }

    public fun total_shares(arg0: &SupplyManager) : u64 {
        arg0.total_shares
    }

    public(friend) fun withdraw(arg0: &mut SupplyManager, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : u64 {
        assert!(arg1 > 0, 1);
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x2::table::contains<address, SupplyData>(&arg0.supplies, v0), 0);
        let v1 = 0x2::table::borrow_mut<address, SupplyData>(&mut arg0.supplies, v0);
        assert!(v1.shares >= arg1, 0);
        assert!(0x2::clock::timestamp_ms(arg6) - v1.last_supply_ms >= arg5, 2);
        v1.shares = v1.shares - arg1;
        arg0.total_shares = arg0.total_shares - arg1;
        0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::math::mul(arg1, 0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::math::div(arg2 + arg4 - arg3, arg0.total_shares))
    }

    // decompiled from Move bytecode v6
}

