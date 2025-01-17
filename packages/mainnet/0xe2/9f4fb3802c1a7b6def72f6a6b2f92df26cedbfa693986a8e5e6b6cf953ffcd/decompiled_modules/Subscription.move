module 0xe29f4fb3802c1a7b6def72f6a6b2f92df26cedbfa693986a8e5e6b6cf953ffcd::Subscription {
    struct SubscriptionPool has store, key {
        id: 0x2::object::UID,
        creator: address,
        token: address,
        total_tokens: u64,
        total_token_balance: 0x2::balance::Balance<0xe29f4fb3802c1a7b6def72f6a6b2f92df26cedbfa693986a8e5e6b6cf953ffcd::coin::COIN>,
        soft_cap: u64,
        hard_cap: u64,
        token_rate: u64,
        total_contributions: u64,
        total_contribution_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        start_time: u64,
        end_time: u64,
        claim_time: u64,
        end_time_refund: u64,
        is_active: bool,
    }

    struct Contribution has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        user: address,
        amount: u64,
        claimed: bool,
    }

    struct PoolCreatedEvent has copy, drop {
        id: 0x2::object::ID,
        creator: address,
        token: address,
        total_tokens: u64,
        soft_cap: u64,
        hard_cap: u64,
        token_rate: u64,
        start_time: u64,
        end_time: u64,
        claim_time: u64,
    }

    struct ContributionEvent has copy, drop {
        id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        user: address,
        amount: u64,
    }

    struct ClaimEvent has copy, drop {
        contribution_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        user: address,
        allocation: u64,
        refund: u64,
    }

    struct ClaimFundEvent has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        amount: u64,
        refund: u64,
    }

    struct SetRefundTimeEvent has copy, drop {
        pool_id: 0x2::object::ID,
        end_time_refund: u64,
    }

    public fun cancel_pool(arg0: &mut SubscriptionPool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 2);
        assert!(arg0.is_active, 3);
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.claim_time, 5);
        arg0.is_active = false;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe29f4fb3802c1a7b6def72f6a6b2f92df26cedbfa693986a8e5e6b6cf953ffcd::coin::COIN>>(0x2::coin::take<0xe29f4fb3802c1a7b6def72f6a6b2f92df26cedbfa693986a8e5e6b6cf953ffcd::coin::COIN>(&mut arg0.total_token_balance, arg0.total_tokens, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun claim_fund(arg0: &mut SubscriptionPool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 9);
        assert!(arg0.is_active && 0x2::clock::timestamp_ms(arg1) > arg0.end_time, 8);
        if (arg0.total_contributions < arg0.soft_cap) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xe29f4fb3802c1a7b6def72f6a6b2f92df26cedbfa693986a8e5e6b6cf953ffcd::coin::COIN>>(0x2::coin::take<0xe29f4fb3802c1a7b6def72f6a6b2f92df26cedbfa693986a8e5e6b6cf953ffcd::coin::COIN>(&mut arg0.total_token_balance, arg0.total_tokens, arg2), 0x2::tx_context::sender(arg2));
            let v0 = ClaimFundEvent{
                pool_id : 0x2::object::uid_to_inner(&arg0.id),
                user    : 0x2::tx_context::sender(arg2),
                amount  : 0,
                refund  : arg0.total_tokens,
            };
            0x2::event::emit<ClaimFundEvent>(v0);
        } else {
            let v1 = arg0.hard_cap;
            let v2 = 0;
            if (arg0.total_contributions < arg0.hard_cap) {
                let v3 = arg0.total_contributions;
                v1 = v3;
                let v4 = arg0.total_tokens - v3 * arg0.token_rate;
                v2 = v4;
                0x2::transfer::public_transfer<0x2::coin::Coin<0xe29f4fb3802c1a7b6def72f6a6b2f92df26cedbfa693986a8e5e6b6cf953ffcd::coin::COIN>>(0x2::coin::take<0xe29f4fb3802c1a7b6def72f6a6b2f92df26cedbfa693986a8e5e6b6cf953ffcd::coin::COIN>(&mut arg0.total_token_balance, v4, arg2), 0x2::tx_context::sender(arg2));
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.total_contribution_balance, v1, arg2), 0x2::tx_context::sender(arg2));
            let v5 = ClaimFundEvent{
                pool_id : 0x2::object::uid_to_inner(&arg0.id),
                user    : 0x2::tx_context::sender(arg2),
                amount  : v1,
                refund  : v2,
            };
            0x2::event::emit<ClaimFundEvent>(v5);
        };
    }

    public fun claim_refund(arg0: &mut SubscriptionPool, arg1: &mut Contribution, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(0x2::tx_context::sender(arg3) == arg1.user && 0x2::object::uid_to_inner(&arg0.id) == arg1.pool_id, 6);
        assert!(!arg1.claimed, 7);
        assert!(v0 > arg0.claim_time && v0 < arg0.end_time_refund, 8);
        arg1.claimed = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.total_contribution_balance, arg1.amount, arg3), 0x2::tx_context::sender(arg3));
        let v1 = ClaimEvent{
            contribution_id : 0x2::object::uid_to_inner(&arg1.id),
            pool_id         : 0x2::object::uid_to_inner(&arg0.id),
            user            : 0x2::tx_context::sender(arg3),
            allocation      : 0,
            refund          : arg1.amount,
        };
        0x2::event::emit<ClaimEvent>(v1);
    }

    public fun claim_token(arg0: &mut SubscriptionPool, arg1: &mut Contribution, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.user && 0x2::object::uid_to_inner(&arg0.id) == arg1.pool_id, 6);
        assert!(!arg1.claimed, 7);
        assert!(!arg0.is_active || 0x2::clock::timestamp_ms(arg2) > arg0.claim_time, 8);
        arg1.claimed = true;
        if (arg0.total_contributions < arg0.soft_cap || !arg0.is_active) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.total_contribution_balance, arg1.amount, arg3), 0x2::tx_context::sender(arg3));
            let v0 = ClaimEvent{
                contribution_id : 0x2::object::uid_to_inner(&arg1.id),
                pool_id         : 0x2::object::uid_to_inner(&arg0.id),
                user            : 0x2::tx_context::sender(arg3),
                allocation      : 0,
                refund          : arg1.amount,
            };
            0x2::event::emit<ClaimEvent>(v0);
        } else {
            let v1 = 0;
            if (arg0.total_contributions > arg0.hard_cap) {
                let v2 = arg1.amount * (arg0.total_contributions - arg0.hard_cap) / arg0.total_contributions;
                v1 = v2;
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.total_contribution_balance, v2, arg3), 0x2::tx_context::sender(arg3));
            };
            let v3 = (arg1.amount - v1) * arg0.token_rate;
            0x2::transfer::public_transfer<0x2::coin::Coin<0xe29f4fb3802c1a7b6def72f6a6b2f92df26cedbfa693986a8e5e6b6cf953ffcd::coin::COIN>>(0x2::coin::take<0xe29f4fb3802c1a7b6def72f6a6b2f92df26cedbfa693986a8e5e6b6cf953ffcd::coin::COIN>(&mut arg0.total_token_balance, v3, arg3), 0x2::tx_context::sender(arg3));
            let v4 = ClaimEvent{
                contribution_id : 0x2::object::uid_to_inner(&arg1.id),
                pool_id         : 0x2::object::uid_to_inner(&arg0.id),
                user            : 0x2::tx_context::sender(arg3),
                allocation      : v3,
                refund          : v1,
            };
            0x2::event::emit<ClaimEvent>(v4);
        };
    }

    public fun contribute(arg0: &mut SubscriptionPool, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg0.is_active, 3);
        assert!(v0 >= arg0.start_time, 4);
        assert!(v0 <= arg0.end_time, 5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.total_contribution_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::take<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), arg2, arg4)));
        arg0.total_contributions = arg0.total_contributions + arg2;
        let v1 = Contribution{
            id      : 0x2::object::new(arg4),
            pool_id : 0x2::object::uid_to_inner(&arg0.id),
            user    : 0x2::tx_context::sender(arg4),
            amount  : arg2,
            claimed : false,
        };
        let v2 = ContributionEvent{
            id      : 0x2::object::uid_to_inner(&v1.id),
            pool_id : 0x2::object::uid_to_inner(&arg0.id),
            user    : 0x2::tx_context::sender(arg4),
            amount  : arg2,
        };
        0x2::event::emit<ContributionEvent>(v2);
        0x2::transfer::public_transfer<Contribution>(v1, 0x2::tx_context::sender(arg4));
    }

    public fun create_pool(arg0: &mut 0x2::coin::Coin<0xe29f4fb3802c1a7b6def72f6a6b2f92df26cedbfa693986a8e5e6b6cf953ffcd::coin::COIN>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 < arg6 && arg6 < arg7, 0);
        assert!(arg2 < arg3, 1);
        let v0 = 0x2::coin::take<0xe29f4fb3802c1a7b6def72f6a6b2f92df26cedbfa693986a8e5e6b6cf953ffcd::coin::COIN>(0x2::coin::balance_mut<0xe29f4fb3802c1a7b6def72f6a6b2f92df26cedbfa693986a8e5e6b6cf953ffcd::coin::COIN>(arg0), arg1, arg8);
        let v1 = 0x2::object::id<0x2::coin::Coin<0xe29f4fb3802c1a7b6def72f6a6b2f92df26cedbfa693986a8e5e6b6cf953ffcd::coin::COIN>>(arg0);
        let v2 = SubscriptionPool{
            id                         : 0x2::object::new(arg8),
            creator                    : 0x2::tx_context::sender(arg8),
            token                      : 0x2::object::id_to_address(&v1),
            total_tokens               : 0x2::balance::value<0xe29f4fb3802c1a7b6def72f6a6b2f92df26cedbfa693986a8e5e6b6cf953ffcd::coin::COIN>(0x2::coin::balance<0xe29f4fb3802c1a7b6def72f6a6b2f92df26cedbfa693986a8e5e6b6cf953ffcd::coin::COIN>(&v0)),
            total_token_balance        : 0x2::coin::into_balance<0xe29f4fb3802c1a7b6def72f6a6b2f92df26cedbfa693986a8e5e6b6cf953ffcd::coin::COIN>(v0),
            soft_cap                   : arg2,
            hard_cap                   : arg3,
            token_rate                 : arg4,
            total_contributions        : 0,
            total_contribution_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            start_time                 : arg5,
            end_time                   : arg6,
            claim_time                 : arg7,
            end_time_refund            : 0,
            is_active                  : true,
        };
        let v3 = PoolCreatedEvent{
            id           : 0x2::object::uid_to_inner(&v2.id),
            creator      : 0x2::tx_context::sender(arg8),
            token        : v2.token,
            total_tokens : v2.total_tokens,
            soft_cap     : arg2,
            hard_cap     : arg3,
            token_rate   : arg4,
            start_time   : arg5,
            end_time     : arg6,
            claim_time   : arg7,
        };
        0x2::event::emit<PoolCreatedEvent>(v3);
        0x2::transfer::public_share_object<SubscriptionPool>(v2);
    }

    public fun deposit(arg0: &mut SubscriptionPool, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 9);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.total_contribution_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::take<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), arg2, arg3)));
    }

    public fun deposit_coin(arg0: &mut SubscriptionPool, arg1: &mut 0x2::coin::Coin<0xe29f4fb3802c1a7b6def72f6a6b2f92df26cedbfa693986a8e5e6b6cf953ffcd::coin::COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 9);
        0x2::balance::join<0xe29f4fb3802c1a7b6def72f6a6b2f92df26cedbfa693986a8e5e6b6cf953ffcd::coin::COIN>(&mut arg0.total_token_balance, 0x2::coin::into_balance<0xe29f4fb3802c1a7b6def72f6a6b2f92df26cedbfa693986a8e5e6b6cf953ffcd::coin::COIN>(0x2::coin::take<0xe29f4fb3802c1a7b6def72f6a6b2f92df26cedbfa693986a8e5e6b6cf953ffcd::coin::COIN>(0x2::coin::balance_mut<0xe29f4fb3802c1a7b6def72f6a6b2f92df26cedbfa693986a8e5e6b6cf953ffcd::coin::COIN>(arg1), arg2, arg3)));
    }

    public fun set_end_time_refund(arg0: &mut SubscriptionPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 9);
        arg0.end_time_refund = arg1;
        let v0 = SetRefundTimeEvent{
            pool_id         : 0x2::object::uid_to_inner(&arg0.id),
            end_time_refund : arg1,
        };
        0x2::event::emit<SetRefundTimeEvent>(v0);
    }

    public fun withdraw(arg0: &mut SubscriptionPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.total_contribution_balance, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun withdraw_coin(arg0: &mut SubscriptionPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe29f4fb3802c1a7b6def72f6a6b2f92df26cedbfa693986a8e5e6b6cf953ffcd::coin::COIN>>(0x2::coin::take<0xe29f4fb3802c1a7b6def72f6a6b2f92df26cedbfa693986a8e5e6b6cf953ffcd::coin::COIN>(&mut arg0.total_token_balance, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

