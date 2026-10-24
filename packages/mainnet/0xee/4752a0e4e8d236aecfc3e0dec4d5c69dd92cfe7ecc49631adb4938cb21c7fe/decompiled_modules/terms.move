module 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms {
    struct PaymentRouted has copy, drop {
        payer: address,
        route: u8,
        count: u64,
        total: u64,
        stake: u64,
        liquidity: u64,
        treasury: u64,
        hive: u64,
        subsidy: u64,
    }

    struct Allocation has copy, drop, store {
        price: u64,
        stake: u64,
        lp: u64,
        treasury: u64,
        hive: u64,
        subsidy: u64,
    }

    public fun allocation(arg0: u8) : (u64, u64, u64, u64, u64, u64) {
        let (v0, v1, v2, v3, v4, v5) = if (arg0 == 0) {
            (2000000000, 2000000000, 500000000, 8000000000, 2000000000, 1500000000)
        } else {
            let (v6, v7, v8, v9, v10, v11) = if (arg0 == 1) {
                (5000000000, 2000000000, 0, 1000000000, 2000000000, 0)
            } else {
                assert!(arg0 == 2, 200);
                (2000000000, 2000000000, 0, 0, 0, 0)
            };
            (v9, v10, v11, v6, v7, v8)
        };
        (v3, v4, v5, v0, v1, v2)
    }

    public fun allocation_lp(arg0: &Allocation) : u64 {
        arg0.lp
    }

    public fun allocation_price(arg0: &Allocation) : u64 {
        arg0.price
    }

    public fun allocation_stake(arg0: &Allocation) : u64 {
        arg0.stake
    }

    public fun allocation_values(arg0: &Allocation) : (u64, u64, u64, u64, u64, u64) {
        (arg0.price, arg0.stake, arg0.lp, arg0.treasury, arg0.hive, arg0.subsidy)
    }

    public(friend) fun checked_allocation(arg0: vector<u64>, arg1: u8) : Allocation {
        assert!(0x1::vector::length<u64>(&arg0) == 6 && arg1 <= 2, 200);
        let v0 = *0x1::vector::borrow<u64>(&arg0, 0);
        let v1 = *0x1::vector::borrow<u64>(&arg0, 1);
        let v2 = *0x1::vector::borrow<u64>(&arg0, 2);
        let v3 = *0x1::vector::borrow<u64>(&arg0, 3);
        let v4 = *0x1::vector::borrow<u64>(&arg0, 4);
        let v5 = *0x1::vector::borrow<u64>(&arg0, 5);
        assert!((v0 as u128) == (v1 as u128) + (v2 as u128) + (v3 as u128) + (v4 as u128) + (v5 as u128), 203);
        assert!(v1 >= 1000000000 && v0 <= 18446744073709551615 / max_per_tx(), 203);
        if (arg1 == 0) {
            assert!(v2 > 0, 200);
        } else {
            assert!(v2 == 0 && v5 == 0, 200);
        };
        Allocation{
            price    : v0,
            stake    : v1,
            lp       : v2,
            treasury : v3,
            hive     : v4,
            subsidy  : v5,
        }
    }

    public(friend) fun default_allocation(arg0: u8) : Allocation {
        let (v0, v1, v2, v3, v4, v5) = allocation(arg0);
        Allocation{
            price    : v0,
            stake    : v1,
            lp       : v2,
            treasury : v3,
            hive     : v4,
            subsidy  : v5,
        }
    }

    public(friend) fun distribute(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let (v0, v1) = royalty_shares(0x2::coin::value<0x2::sui::SUI>(&arg0));
        send(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v0, arg1), @0x9896f6463fe14ae0c4cd90fc8de97e89bc59554d4c70e7a8fc257b45c857c9ff);
        send(arg0, @0x1f605a466af3299e73aa0cdead0c8d3daeef02f60e81237897db7166f9730eb6);
        (v0, v1)
    }

    public(friend) fun distribute_configured(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u16, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert!(arg1 <= 10000, 203);
        let v0 = (((0x2::coin::value<0x2::sui::SUI>(&arg0) as u128) * (arg1 as u128) / 10000) as u64);
        send(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v0, arg4), arg2);
        send(arg0, arg3);
        (v0, 0x2::coin::value<0x2::sui::SUI>(&arg0) - v0)
    }

    public fun early_access_ms() : u64 {
        10800000
    }

    public fun hive() : address {
        @0x1334fdd2f00e340680da65ad90d891c8f1d6371e416033c2f1bf7154a784d5a5
    }

    public fun king() : address {
        @0x1f605a466af3299e73aa0cdead0c8d3daeef02f60e81237897db7166f9730eb6
    }

    public fun max_per_tx() : u64 {
        25
    }

    public fun migration_duration_ms() : u64 {
        1209600000
    }

    public fun migration_price(arg0: bool) : u64 {
        if (arg0) {
            2000000000
        } else {
            5000000000
        }
    }

    public(friend) fun pay(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(arg2 > 0 && arg2 <= max_per_tx(), 201);
        let (v0, v1, v2, v3, v4, v5) = allocation(arg1);
        assert!(v0 <= arg3, 203);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= v0 * arg2, 202);
        let v6 = 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v0 * arg2, arg4);
        send(0x2::coin::split<0x2::sui::SUI>(&mut v6, v3 * arg2, arg4), @0x1f605a466af3299e73aa0cdead0c8d3daeef02f60e81237897db7166f9730eb6);
        send(0x2::coin::split<0x2::sui::SUI>(&mut v6, v4 * arg2, arg4), @0x1334fdd2f00e340680da65ad90d891c8f1d6371e416033c2f1bf7154a784d5a5);
        send(0x2::coin::split<0x2::sui::SUI>(&mut v6, v5 * arg2, arg4), @0x3a7092dc084bd620d4d36245fd62f74fff3e9ffb1c2179c0fa554a71493fa130);
        let v7 = PaymentRouted{
            payer     : 0x2::tx_context::sender(arg4),
            route     : arg1,
            count     : arg2,
            total     : v0 * arg2,
            stake     : v1 * arg2,
            liquidity : v2 * arg2,
            treasury  : v3 * arg2,
            hive      : v4 * arg2,
            subsidy   : v5 * arg2,
        };
        0x2::event::emit<PaymentRouted>(v7);
        (v6, arg0)
    }

    public(friend) fun pay_allocated(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: Allocation, arg2: u8, arg3: u64, arg4: u64, arg5: address, arg6: address, arg7: address, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = if (arg2 <= 2) {
            if (arg3 > 0) {
                arg3 <= max_per_tx()
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 201);
        assert!(arg1.price <= arg4, 203);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= arg1.price * arg3, 202);
        let v1 = 0x2::coin::split<0x2::sui::SUI>(&mut arg0, arg1.price * arg3, arg8);
        send(0x2::coin::split<0x2::sui::SUI>(&mut v1, arg1.treasury * arg3, arg8), arg5);
        send(0x2::coin::split<0x2::sui::SUI>(&mut v1, arg1.hive * arg3, arg8), arg6);
        send(0x2::coin::split<0x2::sui::SUI>(&mut v1, arg1.subsidy * arg3, arg8), arg7);
        let v2 = PaymentRouted{
            payer     : 0x2::tx_context::sender(arg8),
            route     : arg2,
            count     : arg3,
            total     : arg1.price * arg3,
            stake     : arg1.stake * arg3,
            liquidity : arg1.lp * arg3,
            treasury  : arg1.treasury * arg3,
            hive      : arg1.hive * arg3,
            subsidy   : arg1.subsidy * arg3,
        };
        0x2::event::emit<PaymentRouted>(v2);
        (v1, arg0)
    }

    public fun public_lp() : u64 {
        1500000000
    }

    public fun public_price() : u64 {
        8000000000
    }

    public fun royalty_shares(arg0: u64) : (u64, u64) {
        let v0 = (((arg0 as u128) * 3000 / 10000) as u64);
        (v0, arg0 - v0)
    }

    fun send(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address) {
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
        };
    }

    public fun stake() : u64 {
        2000000000
    }

    public fun subsidy() : address {
        @0x3a7092dc084bd620d4d36245fd62f74fff3e9ffb1c2179c0fa554a71493fa130
    }

    public fun validator() : address {
        @0xeac07f3ea2181bb0970136bbe3664a0e8159d060e5620b4a2fb6bf6aac638f7c
    }

    public fun willie() : address {
        @0x9896f6463fe14ae0c4cd90fc8de97e89bc59554d4c70e7a8fc257b45c857c9ff
    }

    // decompiled from Move bytecode v7
}

