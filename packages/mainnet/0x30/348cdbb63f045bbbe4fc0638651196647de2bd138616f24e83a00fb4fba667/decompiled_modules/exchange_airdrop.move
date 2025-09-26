module 0x6e4182b96a6f0960ff30d52f2ce0133cd182fa8ee5ba2f7cf1cd9d2c2c645edb::exchange_airdrop {
    struct ExchangeAirdrop<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        collected: 0x2::balance::Balance<T0>,
        reserves: 0x2::balance::Balance<T1>,
        distributed: u64,
        start: u64,
    }

    struct WithdrawCap has store, key {
        id: 0x2::object::UID,
        airdrop_id: 0x2::object::ID,
    }

    struct EventCreateExchangeAirdrop has copy, drop, store {
        airdrop_id: 0x2::object::ID,
        reserves: u64,
        start: u64,
    }

    struct EventAirdropClaimed has copy, drop, store {
        airdrop_id: 0x2::object::ID,
        amount: u64,
        user: address,
    }

    struct EventWithdrawCollected has copy, drop, store {
        airdrop_id: 0x2::object::ID,
        amount: u64,
    }

    struct EventWithdrawUnclaimed has copy, drop, store {
        airdrop_id: 0x2::object::ID,
        amount: u64,
    }

    struct EventDepositToDistribute has copy, drop, store {
        airdrop_id: 0x2::object::ID,
        amount: u64,
    }

    public fun new<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (ExchangeAirdrop<T0, T1>, WithdrawCap) {
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = ExchangeAirdrop<T0, T1>{
            id          : v0,
            collected   : 0x2::balance::zero<T0>(),
            reserves    : 0x2::coin::into_balance<T1>(arg0),
            distributed : 0,
            start       : arg1,
        };
        let v3 = WithdrawCap{
            id         : 0x2::object::new(arg2),
            airdrop_id : v1,
        };
        let v4 = EventCreateExchangeAirdrop{
            airdrop_id : v1,
            reserves   : 0x2::coin::value<T1>(&arg0),
            start      : arg1,
        };
        0x2::event::emit<EventCreateExchangeAirdrop>(v4);
        (v2, v3)
    }

    public fun collected<T0, T1>(arg0: &ExchangeAirdrop<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.collected)
    }

    public fun deposit_reserves<T0, T1>(arg0: &mut ExchangeAirdrop<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        let v0 = EventDepositToDistribute{
            airdrop_id : 0x2::object::id<ExchangeAirdrop<T0, T1>>(arg0),
            amount     : 0x2::coin::value<T1>(&arg1),
        };
        0x2::event::emit<EventDepositToDistribute>(v0);
        0x2::balance::join<T1>(&mut arg0.reserves, 0x2::coin::into_balance<T1>(arg1));
    }

    public fun distributed<T0, T1>(arg0: &ExchangeAirdrop<T0, T1>) : u64 {
        arg0.distributed
    }

    public fun get_airdrop<T0, T1>(arg0: &mut ExchangeAirdrop<T0, T1>, arg1: &mut 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::VotingEscrow<T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.start <= 0x2::clock::timestamp_ms(arg3), 830914020413490200);
        assert!(0x2::balance::value<T1>(&arg0.reserves) >= 0x2::coin::value<T0>(&arg2), 653209817586432800);
        let v0 = 0x2::coin::value<T0>(&arg2);
        0x2::balance::join<T0>(&mut arg0.collected, 0x2::coin::into_balance<T0>(arg2));
        arg0.distributed = arg0.distributed + v0;
        let v1 = EventAirdropClaimed{
            airdrop_id : 0x2::object::id<ExchangeAirdrop<T0, T1>>(arg0),
            amount     : v0,
            user       : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<EventAirdropClaimed>(v1);
        0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::create_lock<T1>(arg1, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserves, v0), arg4), 1456, true, arg3, arg4);
    }

    public fun get_airdrop_v2<T0, T1>(arg0: &mut ExchangeAirdrop<T0, T1>, arg1: &mut 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::VotingEscrow<T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.start <= 0x2::clock::timestamp_ms(arg3), 830914020413490200);
        assert!(0x2::balance::value<T1>(&arg0.reserves) >= 0x2::coin::value<T0>(&arg2), 653209817586432800);
        let v0 = 0x2::coin::value<T0>(&arg2);
        0x2::balance::join<T0>(&mut arg0.collected, 0x2::coin::into_balance<T0>(arg2));
        arg0.distributed = arg0.distributed + v0;
        let v1 = EventAirdropClaimed{
            airdrop_id : 0x2::object::id<ExchangeAirdrop<T0, T1>>(arg0),
            amount     : v0,
            user       : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<EventAirdropClaimed>(v1);
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::create_lock<T1>(arg1, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserves, v0), arg4), 1456, true, arg3, arg4);
    }

    public fun reserves<T0, T1>(arg0: &ExchangeAirdrop<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.reserves)
    }

    public fun withdraw_collected<T0, T1>(arg0: &mut ExchangeAirdrop<T0, T1>, arg1: &WithdrawCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.airdrop_id == 0x2::object::id<ExchangeAirdrop<T0, T1>>(arg0), 377557558106448800);
        assert!(0x2::balance::value<T0>(&arg0.collected) >= arg2, 771533567291238000);
        let v0 = EventWithdrawCollected{
            airdrop_id : 0x2::object::id<ExchangeAirdrop<T0, T1>>(arg0),
            amount     : arg2,
        };
        0x2::event::emit<EventWithdrawCollected>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.collected, arg2), arg3)
    }

    public fun withdraw_unclaimed<T0, T1>(arg0: &mut ExchangeAirdrop<T0, T1>, arg1: &WithdrawCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg1.airdrop_id == 0x2::object::id<ExchangeAirdrop<T0, T1>>(arg0), 377557558106448800);
        assert!(0x2::balance::value<T1>(&arg0.reserves) >= arg2, 653209817586432800);
        let v0 = EventWithdrawUnclaimed{
            airdrop_id : 0x2::object::id<ExchangeAirdrop<T0, T1>>(arg0),
            amount     : arg2,
        };
        0x2::event::emit<EventWithdrawUnclaimed>(v0);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserves, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

