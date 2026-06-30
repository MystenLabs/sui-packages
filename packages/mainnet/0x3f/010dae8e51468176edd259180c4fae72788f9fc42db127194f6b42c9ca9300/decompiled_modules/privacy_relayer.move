module 0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::privacy_relayer {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RelayerCap has store, key {
        id: 0x2::object::UID,
    }

    struct RelayerState has key {
        id: 0x2::object::UID,
        fee_bps: u64,
        max_fee_bps: u64,
        fee_denominator: u64,
        total_relayed: u64,
        accumulated_fees: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct PrivateTransfer has copy, drop {
        stealth_address_hash: vector<u8>,
        ephemeral_key: vector<u8>,
        view_tag: u8,
        amount: u64,
        fee: u64,
        timestamp_ms: u64,
    }

    struct FeeRateUpdated has copy, drop {
        old_rate: u64,
        new_rate: u64,
    }

    struct FeesWithdrawn has copy, drop {
        to: address,
        amount: u64,
    }

    public fun accumulated_fees(arg0: &RelayerState) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.accumulated_fees)
    }

    public fun fee_bps(arg0: &RelayerState) : u64 {
        arg0.fee_bps
    }

    public fun fee_denominator(arg0: &RelayerState) : u64 {
        arg0.fee_denominator
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = RelayerCap{id: 0x2::object::new(arg0)};
        let v2 = RelayerState{
            id               : 0x2::object::new(arg0),
            fee_bps          : 0,
            max_fee_bps      : 100,
            fee_denominator  : 10000,
            total_relayed    : 0,
            accumulated_fees : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<RelayerState>(v2);
        let v3 = 0x2::tx_context::sender(arg0);
        0x2::transfer::transfer<AdminCap>(v0, v3);
        0x2::transfer::transfer<RelayerCap>(v1, v3);
    }

    public fun max_fee_bps(arg0: &RelayerState) : u64 {
        arg0.max_fee_bps
    }

    public(friend) entry fun relay(arg0: &RelayerCap, arg1: &mut RelayerState, arg2: address, arg3: vector<u8>, arg4: u8, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        assert!(v0 > 0, 1);
        assert!(arg2 != @0x0, 2);
        assert!(arg1.fee_bps <= arg1.max_fee_bps, 3);
        let v1 = v0 * arg1.fee_bps / arg1.fee_denominator;
        let v2 = v0 - v1;
        if (v1 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.accumulated_fees, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg5, v1, arg7)));
        };
        arg1.total_relayed = arg1.total_relayed + v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, arg2);
        let v3 = PrivateTransfer{
            stealth_address_hash : 0x1::hash::sha3_256(0x2::address::to_bytes(arg2)),
            ephemeral_key        : arg3,
            view_tag             : arg4,
            amount               : v2,
            fee                  : v1,
            timestamp_ms         : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<PrivateTransfer>(v3);
    }

    public(friend) entry fun set_fee_bps(arg0: &AdminCap, arg1: &mut RelayerState, arg2: u64) {
        assert!(arg2 <= arg1.max_fee_bps, 3);
        arg1.fee_bps = arg2;
        let v0 = FeeRateUpdated{
            old_rate : arg1.fee_bps,
            new_rate : arg2,
        };
        0x2::event::emit<FeeRateUpdated>(v0);
    }

    public fun total_relayed(arg0: &RelayerState) : u64 {
        arg0.total_relayed
    }

    public(friend) entry fun withdraw_fees(arg0: &AdminCap, arg1: &mut RelayerState, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 2);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.accumulated_fees);
        assert!(v0 > 0, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.accumulated_fees, v0), arg3), arg2);
        let v1 = FeesWithdrawn{
            to     : arg2,
            amount : v0,
        };
        0x2::event::emit<FeesWithdrawn>(v1);
    }

    // decompiled from Move bytecode v7
}

