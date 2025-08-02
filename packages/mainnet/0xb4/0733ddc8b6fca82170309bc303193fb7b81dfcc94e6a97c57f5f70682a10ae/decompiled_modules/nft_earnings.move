module 0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::nft_earnings {
    struct NftEarnings<phantom T0> has key {
        id: 0x2::object::UID,
        total_percentage: u64,
        current_nft_percentage_sum: u64,
        nft_percentage_fee: 0x2::table::Table<address, u64>,
        nft_last_claim: 0x2::table::Table<address, u64>,
        total_earnings_records: 0x2::table::Table<u64, u64>,
        total_earnings: u64,
        total_unassigned_earnings: u64,
        earnings_in_escrow: 0x2::balance::Balance<T0>,
        total_user_earnings: 0x2::table::Table<address, u64>,
    }

    struct NftRegisteredEvent<phantom T0> has copy, drop {
        nft_id: address,
        percentage: u64,
        new_sum: u64,
        registered_by: address,
        registered_at: u64,
    }

    struct NftPercentageUpdatedEvent<phantom T0> has copy, drop {
        nft_id: address,
        old_percentage: u64,
        new_percentage: u64,
        new_sum: u64,
        updated_by: address,
        updated_at: u64,
    }

    struct NftRemovedEvent<phantom T0> has copy, drop {
        nft_id: address,
        new_sum: u64,
        removed_by: address,
        removed_at: u64,
    }

    struct TotalPercentageUpdatedEvent<phantom T0> has copy, drop {
        old_percentage: u64,
        new_percentage: u64,
        new_sum: u64,
        updated_by: address,
        updated_at: u64,
    }

    struct RewardsClaimedEvent<phantom T0> has copy, drop {
        nft_id: address,
        user: address,
        amount: u64,
        claimed_at: u64,
    }

    struct EarningsAddedEvent<phantom T0> has copy, drop {
        amount: u64,
        leftovers: u64,
        added_at: u64,
    }

    struct NFT_EARNINGS has drop {
        dummy_field: bool,
    }

    public(friend) fun add_earnings<T0>(arg0: &mut NftEarnings<T0>, arg1: &0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::admins::Owner, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = v0 * arg0.current_nft_percentage_sum / 10000;
        let v2 = v0 - v1;
        arg0.total_earnings = arg0.total_earnings + v1 + v2;
        let v3 = 0x2::coin::into_balance<T0>(arg2);
        if (v1 > 0) {
            0x2::balance::join<T0>(&mut arg0.earnings_in_escrow, 0x2::balance::split<T0>(&mut v3, v1));
        };
        if (v2 > 0) {
            arg0.total_unassigned_earnings = arg0.total_unassigned_earnings + v2;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg4), 0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::admins::get_owner(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(v3);
        };
        let v4 = EarningsAddedEvent<T0>{
            amount    : v1,
            leftovers : v2,
            added_at  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<EarningsAddedEvent<T0>>(v4);
    }

    public(friend) entry fun claim_earnings<T0, T1: store + key>(arg0: &0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::state::State, arg1: &mut NftEarnings<T0>, arg2: T1, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::state::assert_not_paused(arg0);
        let v0 = 0x2::object::id<T1>(&arg2);
        let v1 = 0x2::object::id_to_address(&v0);
        assert!(0x2::table::contains<address, u64>(&arg1.nft_percentage_fee, v1), 1);
        let v2 = if (!0x2::table::contains<address, u64>(&arg1.nft_last_claim, v1)) {
            0
        } else {
            *0x2::table::borrow<address, u64>(&arg1.nft_last_claim, v1)
        };
        let v3 = if (v2 == 0) {
            arg1.total_earnings
        } else {
            arg1.total_earnings - *0x2::table::borrow<u64, u64>(&arg1.total_earnings_records, v2)
        };
        let v4 = v3 * *0x2::table::borrow<address, u64>(&arg1.nft_percentage_fee, v1) / 10000;
        assert!(v4 > 0, 2);
        if (v2 > 0) {
            0x2::table::remove<address, u64>(&mut arg1.nft_last_claim, v1);
        };
        let v5 = 0x2::clock::timestamp_ms(arg3);
        0x2::table::add<address, u64>(&mut arg1.nft_last_claim, v1, v5);
        if (0x2::table::contains<u64, u64>(&arg1.total_earnings_records, v5)) {
            0x2::table::remove<u64, u64>(&mut arg1.total_earnings_records, v5);
        };
        0x2::table::add<u64, u64>(&mut arg1.total_earnings_records, v5, arg1.total_earnings);
        let v6 = 0x2::tx_context::sender(arg4);
        let v7 = if (0x2::table::contains<address, u64>(&arg1.total_user_earnings, v6)) {
            0x2::table::remove<address, u64>(&mut arg1.total_user_earnings, v6)
        } else {
            0
        };
        0x2::table::add<address, u64>(&mut arg1.total_user_earnings, v6, v7 + v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.earnings_in_escrow, v4), arg4), v6);
        0x2::transfer::public_transfer<T1>(arg2, v6);
        let v8 = RewardsClaimedEvent<T0>{
            nft_id     : v1,
            user       : v6,
            amount     : v4,
            claimed_at : v5,
        };
        0x2::event::emit<RewardsClaimedEvent<T0>>(v8);
    }

    public fun get_claimable_amount<T0>(arg0: &NftEarnings<T0>, arg1: address) : u64 {
        if (!0x2::table::contains<address, u64>(&arg0.nft_percentage_fee, arg1)) {
            return 0
        };
        let v0 = if (!0x2::table::contains<address, u64>(&arg0.nft_last_claim, arg1)) {
            0
        } else {
            *0x2::table::borrow<address, u64>(&arg0.nft_last_claim, arg1)
        };
        let v1 = if (v0 == 0) {
            arg0.total_earnings
        } else {
            arg0.total_earnings - *0x2::table::borrow<u64, u64>(&arg0.total_earnings_records, v0)
        };
        v1 * *0x2::table::borrow<address, u64>(&arg0.nft_percentage_fee, arg1) / 10000
    }

    public fun get_current_nft_percentage_sum<T0>(arg0: &NftEarnings<T0>) : u64 {
        arg0.current_nft_percentage_sum
    }

    public fun get_earnings_in_escrow<T0>(arg0: &NftEarnings<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.earnings_in_escrow)
    }

    public fun get_nft_last_claim<T0>(arg0: &NftEarnings<T0>, arg1: address) : u64 {
        assert!(0x2::table::contains<address, u64>(&arg0.nft_last_claim, arg1), 1);
        *0x2::table::borrow<address, u64>(&arg0.nft_last_claim, arg1)
    }

    public fun get_nft_percentage<T0>(arg0: &NftEarnings<T0>, arg1: address) : u64 {
        assert!(0x2::table::contains<address, u64>(&arg0.nft_percentage_fee, arg1), 1);
        *0x2::table::borrow<address, u64>(&arg0.nft_percentage_fee, arg1)
    }

    public fun get_total_earnings<T0>(arg0: &NftEarnings<T0>) : u64 {
        arg0.total_earnings
    }

    public fun get_total_percentage<T0>(arg0: &NftEarnings<T0>) : u64 {
        arg0.total_percentage
    }

    public fun get_user_total_earnings<T0>(arg0: &NftEarnings<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.total_user_earnings, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.total_user_earnings, arg1)
        } else {
            0
        }
    }

    fun init(arg0: NFT_EARNINGS, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<NFT_EARNINGS>(&arg0), 3);
        let v0 = NftEarnings<0x2::sui::SUI>{
            id                         : 0x2::object::new(arg1),
            total_percentage           : 500,
            current_nft_percentage_sum : 0,
            nft_percentage_fee         : 0x2::table::new<address, u64>(arg1),
            nft_last_claim             : 0x2::table::new<address, u64>(arg1),
            total_earnings_records     : 0x2::table::new<u64, u64>(arg1),
            total_earnings             : 0,
            total_unassigned_earnings  : 0,
            earnings_in_escrow         : 0x2::balance::zero<0x2::sui::SUI>(),
            total_user_earnings        : 0x2::table::new<address, u64>(arg1),
        };
        0x2::transfer::share_object<NftEarnings<0x2::sui::SUI>>(v0);
    }

    public(friend) fun initialize_nft_earnings<T0>(arg0: &0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::admins::Admins, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::admins::assert_is_admin(arg0, 0x2::tx_context::sender(arg2));
        assert!(arg1 <= 10000, 0);
        let v0 = NftEarnings<T0>{
            id                         : 0x2::object::new(arg2),
            total_percentage           : arg1,
            current_nft_percentage_sum : 0,
            nft_percentage_fee         : 0x2::table::new<address, u64>(arg2),
            nft_last_claim             : 0x2::table::new<address, u64>(arg2),
            total_earnings_records     : 0x2::table::new<u64, u64>(arg2),
            total_earnings             : 0,
            total_unassigned_earnings  : 0,
            earnings_in_escrow         : 0x2::balance::zero<T0>(),
            total_user_earnings        : 0x2::table::new<address, u64>(arg2),
        };
        0x2::transfer::share_object<NftEarnings<T0>>(v0);
    }

    public fun is_nft_registered<T0>(arg0: &NftEarnings<T0>, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.nft_percentage_fee, arg1)
    }

    public(friend) entry fun set_earning_nfts<T0>(arg0: &mut NftEarnings<T0>, arg1: &0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::admins::Owner, arg2: vector<address>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::admins::assert_is_owner(arg1, 0x2::tx_context::sender(arg5));
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x1::vector::length<address>(&arg2);
        if (arg3 == 0) {
            let v2 = 0;
            while (v2 < v1) {
                let v3 = *0x1::vector::borrow<address>(&arg2, v2);
                assert!(0x2::table::contains<address, u64>(&arg0.nft_percentage_fee, v3), 1);
                0x2::table::remove<address, u64>(&mut arg0.nft_last_claim, v3);
                arg0.current_nft_percentage_sum = arg0.current_nft_percentage_sum - 0x2::table::remove<address, u64>(&mut arg0.nft_percentage_fee, v3);
                let v4 = NftRemovedEvent<T0>{
                    nft_id     : v3,
                    new_sum    : arg0.current_nft_percentage_sum,
                    removed_by : 0x2::tx_context::sender(arg5),
                    removed_at : v0,
                };
                0x2::event::emit<NftRemovedEvent<T0>>(v4);
                v2 = v2 + 1;
            };
        } else {
            assert!(arg3 <= 10000, 0);
            assert!(arg3 > 0, 0);
            let v5 = 0;
            let v6 = 0;
            while (v6 < v1) {
                let v7 = *0x1::vector::borrow<address>(&arg2, v6);
                if (0x2::table::contains<address, u64>(&arg0.nft_percentage_fee, v7)) {
                    v5 = v5 + *0x2::table::borrow<address, u64>(&arg0.nft_percentage_fee, v7);
                };
                v6 = v6 + 1;
            };
            let v8 = arg0.current_nft_percentage_sum + arg3 * v1 - v5;
            assert!(v8 <= 10000, 4);
            v6 = 0;
            while (v6 < v1) {
                let v9 = *0x1::vector::borrow<address>(&arg2, v6);
                if (0x2::table::contains<address, u64>(&arg0.nft_percentage_fee, v9)) {
                    let v10 = get_claimable_amount<T0>(arg0, v9);
                    if (v10 > 0) {
                        arg0.total_unassigned_earnings = arg0.total_unassigned_earnings + v10;
                        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.earnings_in_escrow, v10), arg5), 0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::admins::get_owner(arg1));
                    };
                    0x2::table::remove<address, u64>(&mut arg0.nft_last_claim, v9);
                    let v11 = NftPercentageUpdatedEvent<T0>{
                        nft_id         : v9,
                        old_percentage : 0x2::table::remove<address, u64>(&mut arg0.nft_percentage_fee, v9),
                        new_percentage : arg3,
                        new_sum        : v8,
                        updated_by     : 0x2::tx_context::sender(arg5),
                        updated_at     : v0,
                    };
                    0x2::event::emit<NftPercentageUpdatedEvent<T0>>(v11);
                } else {
                    let v12 = NftRegisteredEvent<T0>{
                        nft_id        : v9,
                        percentage    : arg3,
                        new_sum       : v8,
                        registered_by : 0x2::tx_context::sender(arg5),
                        registered_at : v0,
                    };
                    0x2::event::emit<NftRegisteredEvent<T0>>(v12);
                };
                0x2::table::add<address, u64>(&mut arg0.nft_percentage_fee, v9, arg3);
                0x2::table::add<address, u64>(&mut arg0.nft_last_claim, v9, v0);
                v6 = v6 + 1;
            };
            if (!0x2::table::contains<u64, u64>(&arg0.total_earnings_records, v0)) {
                0x2::table::add<u64, u64>(&mut arg0.total_earnings_records, v0, arg0.total_earnings);
            };
            arg0.current_nft_percentage_sum = v8;
        };
    }

    public(friend) entry fun set_total_percentage<T0>(arg0: &mut NftEarnings<T0>, arg1: &0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::admins::Owner, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::admins::assert_is_owner(arg1, 0x2::tx_context::sender(arg4));
        assert!(arg2 <= 10000, 0);
        arg0.total_percentage = arg2;
        let v0 = TotalPercentageUpdatedEvent<T0>{
            old_percentage : arg0.total_percentage,
            new_percentage : arg2,
            new_sum        : arg0.current_nft_percentage_sum,
            updated_by     : 0x2::tx_context::sender(arg4),
            updated_at     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TotalPercentageUpdatedEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

