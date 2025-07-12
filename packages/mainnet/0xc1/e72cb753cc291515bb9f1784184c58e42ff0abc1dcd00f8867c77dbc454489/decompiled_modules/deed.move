module 0xc1e72cb753cc291515bb9f1784184c58e42ff0abc1dcd00f8867c77dbc454489::deed {
    struct DEED has drop {
        dummy_field: bool,
    }

    struct Deed has key {
        id: 0x2::object::UID,
        tier: u8,
        minted_at: u64,
    }

    struct Commit has key {
        id: 0x2::object::UID,
        tier: u8,
        quantity: u64,
        commit_amount: u64,
        remaining_amount: u64,
        committed_at: u64,
        refunded_amount: u64,
        purchased_amount: u64,
        is_deed_minted: bool,
    }

    struct DeedContract has key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        pending_owner: address,
        total_minted: u64,
        total_burned: u64,
        total_cap: u64,
        current_phase: u8,
        private_sell_active: bool,
        private_sell_minted: u64,
        public_sell_active: bool,
        public_sell_minted: u64,
        balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        total_commits_per_tier: vector<u64>,
        total_private_sells: u64,
        total_public_sells: u64,
        commits_per_inviter: 0x2::table::Table<address, u64>,
        private_sells_per_inviter: 0x2::table::Table<address, u64>,
        public_sells_per_inviter: 0x2::table::Table<address, u64>,
        invite_code_to_address: 0x2::table::Table<vector<u8>, address>,
        address_to_invite_code: 0x2::table::Table<address, vector<u8>>,
        inviter_hierarchy: 0x2::table::Table<address, address>,
        commits_per_address_tier1: 0x2::table::Table<address, u64>,
        commits_per_address_tier2: 0x2::table::Table<address, u64>,
        commits_per_address_tier3: 0x2::table::Table<address, u64>,
        deed_quantity_per_address_tier1: 0x2::table::Table<address, u64>,
        deed_quantity_per_address_tier2: 0x2::table::Table<address, u64>,
        deed_quantity_per_address_tier3: 0x2::table::Table<address, u64>,
        real_allocation_tier1: 0x2::table::Table<address, u64>,
        real_allocation_tier2: 0x2::table::Table<address, u64>,
        real_allocation_tier3: 0x2::table::Table<address, u64>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct PhaseStarted has copy, drop {
        phase: u8,
        start_time: u64,
    }

    struct PhaseStopped has copy, drop {
        previous_phase: u8,
        timestamp: u64,
    }

    struct SellModeActivated has copy, drop {
        mode: u8,
        start_time: u64,
    }

    struct SellModeDeactivated has copy, drop {
        mode: u8,
    }

    struct CommitMade has copy, drop {
        user: address,
        tier: u8,
        amount: u64,
        commit_id: address,
        timestamp: u64,
    }

    struct PublicSellCompleted has copy, drop {
        user: address,
        amount: u64,
        deed_id: address,
        timestamp: u64,
    }

    struct PrivateRefund has copy, drop {
        user: address,
        tier: u8,
        refund_amount: u64,
        commit_id: address,
        timestamp: u64,
    }

    struct PrivatePurchase has copy, drop {
        user: address,
        tier: u8,
        purchase_amount: u64,
        deed_id: address,
        commit_id: address,
        timestamp: u64,
    }

    struct DeedBurned has copy, drop {
        deed_id: address,
        tier: u8,
        owner: address,
        timestamp: u64,
    }

    struct OwnershipTransferInitiated has copy, drop {
        current_owner: address,
        pending_owner: address,
    }

    struct OwnershipTransferred has copy, drop {
        previous_owner: address,
        new_owner: address,
    }

    struct AdminCapTransferred has copy, drop {
        sender: address,
        new_owner: address,
    }

    struct RevenueWithdrawal has copy, drop {
        admin: address,
        amount: u64,
        remaining_balance: u64,
        timestamp: u64,
    }

    struct EmergencyWithdrawal has copy, drop {
        amount: u64,
        timestamp: u64,
    }

    struct InviteCodeRegistered has copy, drop {
        user: address,
        invite_code: vector<u8>,
        timestamp: u64,
    }

    struct InviterReward has copy, drop {
        inviter: address,
        buyer: address,
        amount: u64,
        timestamp: u64,
    }

    struct BuyerDiscount has copy, drop {
        buyer: address,
        amount: u64,
        timestamp: u64,
    }

    struct CommitAllocationSet has copy, drop {
        user: address,
        admin: address,
        tier1_allocation: u64,
        tier2_allocation: u64,
        tier3_allocation: u64,
        timestamp: u64,
    }

    struct TimePeriodsUpdated has copy, drop {
        admin: address,
        commit_period: u64,
        refund_period: u64,
        timestamp: u64,
    }

    struct InviterRelationshipEstablished has copy, drop {
        user: address,
        inviter: address,
        inviter_code: vector<u8>,
        timestamp: u64,
    }

    public entry fun accept_ownership(arg0: &mut DeedContract, arg1: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.pending_owner, 2);
        arg0.owner = v0;
        arg0.pending_owner = @0x0;
        let v1 = OwnershipTransferred{
            previous_owner : arg0.owner,
            new_owner      : v0,
        };
        0x2::event::emit<OwnershipTransferred>(v1);
    }

    public entry fun activate_private_sell(arg0: &mut DeedContract, arg1: &mut AdminCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        assert!(!arg0.private_sell_active, 16);
        arg0.private_sell_active = true;
        let v0 = SellModeActivated{
            mode       : 4,
            start_time : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<SellModeActivated>(v0);
    }

    public entry fun activate_public_sell(arg0: &mut DeedContract, arg1: &mut AdminCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        assert!(!arg0.public_sell_active, 16);
        arg0.public_sell_active = true;
        let v0 = SellModeActivated{
            mode       : 5,
            start_time : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<SellModeActivated>(v0);
    }

    public fun burn_deed(arg0: &mut DeedContract, arg1: Deed, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.total_burned = arg0.total_burned + 1;
        let v0 = DeedBurned{
            deed_id   : 0x2::object::uid_to_address(&arg1.id),
            tier      : arg1.tier,
            owner     : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<DeedBurned>(v0);
        let Deed {
            id        : v1,
            tier      : _,
            minted_at : _,
        } = arg1;
        0x2::object::delete(v1);
    }

    fun calculate_buyer_discount(arg0: u64) : u64 {
        arg0 / 20
    }

    fun calculate_commit_amount(arg0: u8) : u64 {
        get_tier_price(arg0) * 10 / 100
    }

    fun calculate_inviter_reward(arg0: u64) : u64 {
        arg0 / 10
    }

    fun calculate_potential_refunds(arg0: &DeedContract) : u64 {
        *0x1::vector::borrow<u64>(&arg0.total_commits_per_tier, 0) * calculate_commit_amount(1) + *0x1::vector::borrow<u64>(&arg0.total_commits_per_tier, 1) * calculate_commit_amount(2) + *0x1::vector::borrow<u64>(&arg0.total_commits_per_tier, 2) * calculate_commit_amount(3)
    }

    fun calculate_remaining_amount(arg0: u8) : u64 {
        get_tier_price(arg0) * 90 / 100
    }

    fun check_version(arg0: &DeedContract) {
        assert!(arg0.version == 1, 22);
    }

    public entry fun commit(arg0: &mut DeedContract, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: u64, arg3: u8, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        register(arg0, arg4, arg5, arg6);
        commit_internal(arg0, arg1, arg2, arg3, arg5, arg6);
    }

    fun commit_internal(arg0: &mut DeedContract, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: u64, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(is_phase_active(arg0, arg4, arg3), 9);
        assert!(arg2 > 0, 5);
        assert!(get_address_deed_quantity_for_tier(arg0, v0, arg3) + arg2 <= 30, 21);
        assert!(get_address_commits_for_tier(arg0, v0, arg3) < 30, 21);
        let v1 = calculate_commit_amount(arg3) * arg2;
        let v2 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1);
        assert!(v2 >= v1, 5);
        if (v2 > v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1, v2 - v1, arg5), v0);
        };
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1));
        let v3 = Commit{
            id               : 0x2::object::new(arg5),
            tier             : arg3,
            quantity         : arg2,
            commit_amount    : v1,
            remaining_amount : calculate_remaining_amount(arg3) * arg2,
            committed_at     : 0x2::clock::timestamp_ms(arg4),
            refunded_amount  : 0,
            purchased_amount : 0,
            is_deed_minted   : false,
        };
        let v4 = 0x1::vector::borrow_mut<u64>(&mut arg0.total_commits_per_tier, (arg3 as u64) - 1);
        *v4 = *v4 + 1;
        if (0x2::table::contains<address, address>(&arg0.inviter_hierarchy, v0)) {
            let v5 = *0x2::table::borrow<address, address>(&arg0.inviter_hierarchy, v0);
            if (0x2::table::contains<address, u64>(&arg0.commits_per_inviter, v5)) {
                let v6 = 0x2::table::borrow_mut<address, u64>(&mut arg0.commits_per_inviter, v5);
                *v6 = *v6 + 1;
            } else {
                0x2::table::add<address, u64>(&mut arg0.commits_per_inviter, v5, 1);
            };
        };
        update_address_commits_for_tier(arg0, v0, arg3);
        update_address_deed_quantity_for_tier(arg0, v0, arg3, arg2);
        let v7 = CommitMade{
            user      : v0,
            tier      : arg3,
            amount    : v1,
            commit_id : 0x2::object::uid_to_address(&v3.id),
            timestamp : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<CommitMade>(v7);
        0x2::transfer::transfer<Commit>(v3, v0);
    }

    public entry fun deactivate_private_sell(arg0: &mut DeedContract, arg1: &mut AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.private_sell_active = false;
        let v0 = SellModeDeactivated{mode: 4};
        0x2::event::emit<SellModeDeactivated>(v0);
    }

    public entry fun deactivate_public_sell(arg0: &mut DeedContract, arg1: &mut AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.public_sell_active = false;
        let v0 = SellModeDeactivated{mode: 5};
        0x2::event::emit<SellModeDeactivated>(v0);
    }

    public entry fun emergency_withdraw(arg0: &mut DeedContract, arg1: &mut AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        let v0 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.balance);
        assert!(v0 > 0, 15);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, v0, arg2), arg0.owner);
        let v1 = EmergencyWithdrawal{
            amount    : v0,
            timestamp : 0,
        };
        0x2::event::emit<EmergencyWithdrawal>(v1);
    }

    public fun get_address_by_invite_code(arg0: &DeedContract, arg1: vector<u8>) : address {
        assert!(0x2::table::contains<vector<u8>, address>(&arg0.invite_code_to_address, arg1), 19);
        *0x2::table::borrow<vector<u8>, address>(&arg0.invite_code_to_address, arg1)
    }

    public fun get_address_commit_count(arg0: &DeedContract, arg1: address, arg2: u8) : u64 {
        get_address_commits_for_tier(arg0, arg1, arg2)
    }

    public fun get_address_commit_counts_all_tiers(arg0: &DeedContract, arg1: address) : (u64, u64, u64) {
        (get_address_commits_for_tier(arg0, arg1, 1), get_address_commits_for_tier(arg0, arg1, 2), get_address_commits_for_tier(arg0, arg1, 3))
    }

    fun get_address_commits_for_tier(arg0: &DeedContract, arg1: address, arg2: u8) : u64 {
        if (arg2 == 1) {
            if (0x2::table::contains<address, u64>(&arg0.commits_per_address_tier1, arg1)) {
                *0x2::table::borrow<address, u64>(&arg0.commits_per_address_tier1, arg1)
            } else {
                0
            }
        } else if (arg2 == 2) {
            if (0x2::table::contains<address, u64>(&arg0.commits_per_address_tier2, arg1)) {
                *0x2::table::borrow<address, u64>(&arg0.commits_per_address_tier2, arg1)
            } else {
                0
            }
        } else {
            assert!(arg2 == 3, 4);
            if (0x2::table::contains<address, u64>(&arg0.commits_per_address_tier3, arg1)) {
                *0x2::table::borrow<address, u64>(&arg0.commits_per_address_tier3, arg1)
            } else {
                0
            }
        }
    }

    public fun get_address_deed_quantities_all_tiers(arg0: &DeedContract, arg1: address) : (u64, u64, u64) {
        (get_address_deed_quantity_for_tier(arg0, arg1, 1), get_address_deed_quantity_for_tier(arg0, arg1, 2), get_address_deed_quantity_for_tier(arg0, arg1, 3))
    }

    public fun get_address_deed_quantity(arg0: &DeedContract, arg1: address, arg2: u8) : u64 {
        get_address_deed_quantity_for_tier(arg0, arg1, arg2)
    }

    fun get_address_deed_quantity_for_tier(arg0: &DeedContract, arg1: address, arg2: u8) : u64 {
        if (arg2 == 1) {
            if (0x2::table::contains<address, u64>(&arg0.deed_quantity_per_address_tier1, arg1)) {
                *0x2::table::borrow<address, u64>(&arg0.deed_quantity_per_address_tier1, arg1)
            } else {
                0
            }
        } else if (arg2 == 2) {
            if (0x2::table::contains<address, u64>(&arg0.deed_quantity_per_address_tier2, arg1)) {
                *0x2::table::borrow<address, u64>(&arg0.deed_quantity_per_address_tier2, arg1)
            } else {
                0
            }
        } else {
            assert!(arg2 == 3, 4);
            if (0x2::table::contains<address, u64>(&arg0.deed_quantity_per_address_tier3, arg1)) {
                *0x2::table::borrow<address, u64>(&arg0.deed_quantity_per_address_tier3, arg1)
            } else {
                0
            }
        }
    }

    public fun get_balance(arg0: &DeedContract) : u64 {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.balance)
    }

    public fun get_commit_available_amounts(arg0: &Commit) : (u64, u64) {
        (arg0.commit_amount - arg0.refunded_amount, arg0.commit_amount - arg0.refunded_amount - arg0.purchased_amount)
    }

    public fun get_commit_info(arg0: &Commit) : (u8, u64, u64, u64, u64, bool) {
        let v0 = calculate_commit_amount(arg0.tier);
        (arg0.tier, arg0.quantity, arg0.refunded_amount / v0, arg0.purchased_amount / v0, arg0.committed_at, arg0.is_deed_minted)
    }

    public fun get_contract_info(arg0: &DeedContract) : (u64, u64, u64, u8) {
        (arg0.version, arg0.total_minted, arg0.total_burned, arg0.current_phase)
    }

    public fun get_invite_code(arg0: &DeedContract, arg1: address) : vector<u8> {
        if (0x2::table::contains<address, vector<u8>>(&arg0.address_to_invite_code, arg1)) {
            *0x2::table::borrow<address, vector<u8>>(&arg0.address_to_invite_code, arg1)
        } else {
            0x1::vector::empty<u8>()
        }
    }

    public fun get_inviter_stats(arg0: &DeedContract, arg1: address) : (u64, u64, u64) {
        let v0 = if (0x2::table::contains<address, u64>(&arg0.commits_per_inviter, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.commits_per_inviter, arg1)
        } else {
            0
        };
        let v1 = if (0x2::table::contains<address, u64>(&arg0.private_sells_per_inviter, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.private_sells_per_inviter, arg1)
        } else {
            0
        };
        let v2 = if (0x2::table::contains<address, u64>(&arg0.public_sells_per_inviter, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.public_sells_per_inviter, arg1)
        } else {
            0
        };
        (v0, v1, v2)
    }

    public fun get_max_commits_per_address() : u64 {
        30
    }

    public fun get_private_sell_status(arg0: &DeedContract) : (bool, u64) {
        (arg0.private_sell_active, arg0.private_sell_minted)
    }

    public fun get_public_sell_status(arg0: &DeedContract) : (bool, u64, u64) {
        (arg0.public_sell_active, arg0.public_sell_minted, arg0.total_cap - arg0.total_minted)
    }

    fun get_real_allocation_or_commit_quantity(arg0: &DeedContract, arg1: address, arg2: u8, arg3: u64) : u64 {
        if (arg2 == 1) {
            if (0x2::table::contains<address, u64>(&arg0.real_allocation_tier1, arg1)) {
                *0x2::table::borrow<address, u64>(&arg0.real_allocation_tier1, arg1)
            } else {
                arg3
            }
        } else if (arg2 == 2) {
            if (0x2::table::contains<address, u64>(&arg0.real_allocation_tier2, arg1)) {
                *0x2::table::borrow<address, u64>(&arg0.real_allocation_tier2, arg1)
            } else {
                arg3
            }
        } else if (arg2 == 3) {
            if (0x2::table::contains<address, u64>(&arg0.real_allocation_tier3, arg1)) {
                *0x2::table::borrow<address, u64>(&arg0.real_allocation_tier3, arg1)
            } else {
                arg3
            }
        } else {
            arg3
        }
    }

    public fun get_superior(arg0: &DeedContract, arg1: address) : address {
        if (0x2::table::contains<address, address>(&arg0.inviter_hierarchy, arg1)) {
            *0x2::table::borrow<address, address>(&arg0.inviter_hierarchy, arg1)
        } else {
            @0x0
        }
    }

    public fun get_supply_info(arg0: &DeedContract) : (u64, u64, u64) {
        (arg0.total_minted, arg0.total_burned, arg0.total_cap)
    }

    public fun get_tier_price(arg0: u8) : u64 {
        if (arg0 == 1) {
            179000000
        } else if (arg0 == 2) {
            239000000
        } else {
            assert!(arg0 == 3, 4);
            290000000
        }
    }

    public fun get_tier_prices() : (u64, u64, u64, u64) {
        (179000000, 239000000, 290000000, 359000000)
    }

    public fun get_tier_stats(arg0: &DeedContract) : (vector<u64>, u64, u64) {
        (arg0.total_commits_per_tier, arg0.total_private_sells, arg0.total_public_sells)
    }

    public fun get_user_real_allocation(arg0: &DeedContract, arg1: address, arg2: u8) : u64 {
        if (arg2 == 1) {
            if (0x2::table::contains<address, u64>(&arg0.real_allocation_tier1, arg1)) {
                *0x2::table::borrow<address, u64>(&arg0.real_allocation_tier1, arg1)
            } else {
                0
            }
        } else if (arg2 == 2) {
            if (0x2::table::contains<address, u64>(&arg0.real_allocation_tier2, arg1)) {
                *0x2::table::borrow<address, u64>(&arg0.real_allocation_tier2, arg1)
            } else {
                0
            }
        } else if (arg2 == 3) {
            if (0x2::table::contains<address, u64>(&arg0.real_allocation_tier3, arg1)) {
                *0x2::table::borrow<address, u64>(&arg0.real_allocation_tier3, arg1)
            } else {
                0
            }
        } else {
            0
        }
    }

    public fun has_superior(arg0: &DeedContract, arg1: address) : bool {
        0x2::table::contains<address, address>(&arg0.inviter_hierarchy, arg1)
    }

    fun init(arg0: DEED, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DeedContract{
            id                              : 0x2::object::new(arg1),
            version                         : 1,
            owner                           : 0x2::tx_context::sender(arg1),
            pending_owner                   : @0x0,
            total_minted                    : 0,
            total_burned                    : 0,
            total_cap                       : 100000,
            current_phase                   : 0,
            private_sell_active             : false,
            private_sell_minted             : 0,
            public_sell_active              : false,
            public_sell_minted              : 0,
            balance                         : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            total_commits_per_tier          : vector[0, 0, 0],
            total_private_sells             : 0,
            total_public_sells              : 0,
            commits_per_inviter             : 0x2::table::new<address, u64>(arg1),
            private_sells_per_inviter       : 0x2::table::new<address, u64>(arg1),
            public_sells_per_inviter        : 0x2::table::new<address, u64>(arg1),
            invite_code_to_address          : 0x2::table::new<vector<u8>, address>(arg1),
            address_to_invite_code          : 0x2::table::new<address, vector<u8>>(arg1),
            inviter_hierarchy               : 0x2::table::new<address, address>(arg1),
            commits_per_address_tier1       : 0x2::table::new<address, u64>(arg1),
            commits_per_address_tier2       : 0x2::table::new<address, u64>(arg1),
            commits_per_address_tier3       : 0x2::table::new<address, u64>(arg1),
            deed_quantity_per_address_tier1 : 0x2::table::new<address, u64>(arg1),
            deed_quantity_per_address_tier2 : 0x2::table::new<address, u64>(arg1),
            deed_quantity_per_address_tier3 : 0x2::table::new<address, u64>(arg1),
            real_allocation_tier1           : 0x2::table::new<address, u64>(arg1),
            real_allocation_tier2           : 0x2::table::new<address, u64>(arg1),
            real_allocation_tier3           : 0x2::table::new<address, u64>(arg1),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<DeedContract>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"tier"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Deed NFT"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"A non-transferable Deed NFT representing ownership in the ecosystem. Tier: {tier}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://deed.example.com/api/image/{id}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://deed.example.com"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{tier}"));
        let v6 = 0x2::package::claim<DEED>(arg0, arg1);
        let v7 = 0x2::display::new_with_fields<Deed>(&v6, v2, v4, arg1);
        0x2::display::update_version<Deed>(&mut v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Deed>>(v7, 0x2::tx_context::sender(arg1));
    }

    public fun invite_code_exists(arg0: &DeedContract, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, address>(&arg0.invite_code_to_address, arg1)
    }

    fun is_phase_active(arg0: &DeedContract, arg1: &0x2::clock::Clock, arg2: u8) : bool {
        arg0.current_phase == arg2 && arg2 != 0
    }

    fun is_private_sell_active(arg0: &DeedContract, arg1: &0x2::clock::Clock) : bool {
        arg0.private_sell_active
    }

    fun is_public_sell_active(arg0: &DeedContract, arg1: &0x2::clock::Clock) : bool {
        arg0.public_sell_active
    }

    public fun migrate(arg0: &mut DeedContract, arg1: &mut AdminCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        arg0.version = 1;
        let v0 = TimePeriodsUpdated{
            admin         : 0x2::tx_context::sender(arg3),
            commit_period : arg0.version,
            refund_period : 1,
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TimePeriodsUpdated>(v0);
    }

    public entry fun private_purchase(arg0: &mut DeedContract, arg1: &mut Commit, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(is_private_sell_active(arg0, arg4), 16);
        assert!(!arg1.is_deed_minted, 17);
        assert!(arg0.total_minted + arg3 <= arg0.total_cap, 13);
        assert!(arg3 > 0, 5);
        assert!(arg3 <= get_real_allocation_or_commit_quantity(arg0, v0, arg1.tier, arg1.quantity) - arg1.purchased_amount / calculate_commit_amount(arg1.tier) - arg1.refunded_amount / calculate_commit_amount(arg1.tier), 5);
        let v1 = calculate_remaining_amount(arg1.tier) * arg3;
        let v2 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg2);
        assert!(v2 >= v1, 5);
        if (v2 > v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg2, v2 - v1, arg5), v0);
        };
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2));
        arg1.purchased_amount = arg1.purchased_amount + calculate_commit_amount(arg1.tier) * arg3;
        process_sell_rewards(arg0, v0, get_tier_price(arg1.tier) * arg3, arg4, arg5);
        let v3 = 0;
        while (v3 < arg3) {
            let v4 = Deed{
                id        : 0x2::object::new(arg5),
                tier      : arg1.tier,
                minted_at : 0x2::clock::timestamp_ms(arg4),
            };
            let v5 = PrivatePurchase{
                user            : v0,
                tier            : arg1.tier,
                purchase_amount : calculate_commit_amount(arg1.tier),
                deed_id         : 0x2::object::uid_to_address(&v4.id),
                commit_id       : 0x2::object::uid_to_address(&arg1.id),
                timestamp       : 0x2::clock::timestamp_ms(arg4),
            };
            0x2::event::emit<PrivatePurchase>(v5);
            0x2::transfer::transfer<Deed>(v4, v0);
            v3 = v3 + 1;
        };
        arg0.total_minted = arg0.total_minted + arg3;
        arg0.private_sell_minted = arg0.private_sell_minted + arg3;
        if (0x2::table::contains<address, address>(&arg0.inviter_hierarchy, v0)) {
            let v6 = *0x2::table::borrow<address, address>(&arg0.inviter_hierarchy, v0);
            if (0x2::table::contains<address, u64>(&arg0.private_sells_per_inviter, v6)) {
                let v7 = 0x2::table::borrow_mut<address, u64>(&mut arg0.private_sells_per_inviter, v6);
                *v7 = *v7 + arg3;
            } else {
                0x2::table::add<address, u64>(&mut arg0.private_sells_per_inviter, v6, arg3);
            };
        };
    }

    public entry fun private_refund(arg0: &mut DeedContract, arg1: &mut Commit, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg2 > 0, 17);
        assert!(arg2 <= arg1.quantity - arg1.refunded_amount / calculate_commit_amount(arg1.tier) - arg1.purchased_amount / calculate_commit_amount(arg1.tier), 17);
        let v1 = calculate_commit_amount(arg1.tier) * arg2;
        arg1.refunded_amount = arg1.refunded_amount + v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, v1, arg4), v0);
        let v2 = PrivateRefund{
            user          : v0,
            tier          : arg1.tier,
            refund_amount : v1,
            commit_id     : 0x2::object::uid_to_address(&arg1.id),
            timestamp     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PrivateRefund>(v2);
    }

    fun process_sell_rewards(arg0: &mut DeedContract, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = arg2;
        if (0x2::table::contains<address, address>(&arg0.inviter_hierarchy, arg1)) {
            let v1 = *0x2::table::borrow<address, address>(&arg0.inviter_hierarchy, arg1);
            let v2 = calculate_inviter_reward(arg2);
            if (v2 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, v2, arg4), v1);
                v0 = arg2 - v2;
                let v3 = InviterReward{
                    inviter   : v1,
                    buyer     : arg1,
                    amount    : v2,
                    timestamp : 0x2::clock::timestamp_ms(arg3),
                };
                0x2::event::emit<InviterReward>(v3);
            };
        };
        if (0x2::table::contains<address, vector<u8>>(&arg0.address_to_invite_code, arg1)) {
            let v4 = calculate_buyer_discount(arg2);
            if (v4 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, v4, arg4), arg1);
                v0 = v0 - v4;
                let v5 = BuyerDiscount{
                    buyer     : arg1,
                    amount    : v4,
                    timestamp : 0x2::clock::timestamp_ms(arg3),
                };
                0x2::event::emit<BuyerDiscount>(v5);
            };
        };
        v0
    }

    public entry fun public_sell(arg0: &mut DeedContract, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(is_public_sell_active(arg0, arg3), 16);
        assert!(arg2 > 0, 5);
        assert!(arg0.total_minted + arg2 <= arg0.total_cap, 13);
        let v1 = 359000000 * arg2;
        let v2 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1);
        assert!(v2 >= v1, 5);
        if (v2 > v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1, v2 - v1, arg4), v0);
        };
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1));
        process_sell_rewards(arg0, v0, v1, arg3, arg4);
        let v3 = 0;
        while (v3 < arg2) {
            let v4 = Deed{
                id        : 0x2::object::new(arg4),
                tier      : 5,
                minted_at : 0x2::clock::timestamp_ms(arg3),
            };
            let v5 = PublicSellCompleted{
                user      : v0,
                amount    : 359000000,
                deed_id   : 0x2::object::uid_to_address(&v4.id),
                timestamp : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<PublicSellCompleted>(v5);
            0x2::transfer::transfer<Deed>(v4, v0);
            v3 = v3 + 1;
        };
        arg0.total_minted = arg0.total_minted + arg2;
        arg0.public_sell_minted = arg0.public_sell_minted + arg2;
        arg0.total_public_sells = arg0.total_public_sells + arg2;
        if (0x2::table::contains<address, address>(&arg0.inviter_hierarchy, v0)) {
            let v6 = *0x2::table::borrow<address, address>(&arg0.inviter_hierarchy, v0);
            if (0x2::table::contains<address, u64>(&arg0.public_sells_per_inviter, v6)) {
                let v7 = 0x2::table::borrow_mut<address, u64>(&mut arg0.public_sells_per_inviter, v6);
                *v7 = *v7 + arg2;
            } else {
                0x2::table::add<address, u64>(&mut arg0.public_sells_per_inviter, v6, arg2);
            };
        };
    }

    fun register(arg0: &mut DeedContract, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<vector<u8>, address>(&arg0.invite_code_to_address, arg1), 18);
        if (0x2::table::contains<address, vector<u8>>(&arg0.address_to_invite_code, v0)) {
            return
        };
        assert!(!0x1::vector::is_empty<u8>(&arg1), 20);
        0x2::table::add<vector<u8>, address>(&mut arg0.invite_code_to_address, arg1, v0);
        0x2::table::add<address, vector<u8>>(&mut arg0.address_to_invite_code, v0, arg1);
        let v1 = InviteCodeRegistered{
            user        : v0,
            invite_code : arg1,
            timestamp   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<InviteCodeRegistered>(v1);
    }

    public entry fun register_inviter(arg0: &mut DeedContract, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = resolve_inviter_address(arg0, arg1);
        assert!(!0x2::table::contains<address, address>(&arg0.inviter_hierarchy, v0), 18);
        0x2::table::add<address, address>(&mut arg0.inviter_hierarchy, v0, v1);
        let v2 = InviterRelationshipEstablished{
            user         : v0,
            inviter      : v1,
            inviter_code : arg1,
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<InviterRelationshipEstablished>(v2);
    }

    fun resolve_inviter_address(arg0: &DeedContract, arg1: vector<u8>) : address {
        assert!(0x2::table::contains<vector<u8>, address>(&arg0.invite_code_to_address, arg1), 19);
        *0x2::table::borrow<vector<u8>, address>(&arg0.invite_code_to_address, arg1)
    }

    public entry fun set_user_allocation(arg0: &mut DeedContract, arg1: &mut AdminCap, arg2: address, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 1);
        assert!(0x1::vector::length<u64>(&arg3) == 3, 4);
        let v0 = *0x1::vector::borrow<u64>(&arg3, 0);
        let v1 = *0x1::vector::borrow<u64>(&arg3, 1);
        let v2 = *0x1::vector::borrow<u64>(&arg3, 2);
        if (v0 > 0) {
            if (0x2::table::contains<address, u64>(&arg0.real_allocation_tier1, arg2)) {
                *0x2::table::borrow_mut<address, u64>(&mut arg0.real_allocation_tier1, arg2) = v0;
            } else {
                0x2::table::add<address, u64>(&mut arg0.real_allocation_tier1, arg2, v0);
            };
        } else if (0x2::table::contains<address, u64>(&arg0.real_allocation_tier1, arg2)) {
            0x2::table::remove<address, u64>(&mut arg0.real_allocation_tier1, arg2);
        };
        if (v1 > 0) {
            if (0x2::table::contains<address, u64>(&arg0.real_allocation_tier2, arg2)) {
                *0x2::table::borrow_mut<address, u64>(&mut arg0.real_allocation_tier2, arg2) = v1;
            } else {
                0x2::table::add<address, u64>(&mut arg0.real_allocation_tier2, arg2, v1);
            };
        } else if (0x2::table::contains<address, u64>(&arg0.real_allocation_tier2, arg2)) {
            0x2::table::remove<address, u64>(&mut arg0.real_allocation_tier2, arg2);
        };
        if (v2 > 0) {
            if (0x2::table::contains<address, u64>(&arg0.real_allocation_tier3, arg2)) {
                *0x2::table::borrow_mut<address, u64>(&mut arg0.real_allocation_tier3, arg2) = v2;
            } else {
                0x2::table::add<address, u64>(&mut arg0.real_allocation_tier3, arg2, v2);
            };
        } else if (0x2::table::contains<address, u64>(&arg0.real_allocation_tier3, arg2)) {
            0x2::table::remove<address, u64>(&mut arg0.real_allocation_tier3, arg2);
        };
        let v3 = CommitAllocationSet{
            user             : arg2,
            admin            : 0x2::tx_context::sender(arg5),
            tier1_allocation : v0,
            tier2_allocation : v1,
            tier3_allocation : v2,
            timestamp        : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<CommitAllocationSet>(v3);
    }

    public entry fun start_phase(arg0: &mut DeedContract, arg1: &mut AdminCap, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        let v0 = if (arg2 == 1) {
            true
        } else if (arg2 == 2) {
            true
        } else {
            arg2 == 3
        };
        assert!(v0, 3);
        arg0.current_phase = arg2;
        let v1 = PhaseStarted{
            phase      : arg2,
            start_time : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PhaseStarted>(v1);
    }

    public entry fun stop_phase(arg0: &mut DeedContract, arg1: &mut AdminCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        arg0.current_phase = 0;
        let v0 = PhaseStopped{
            previous_phase : arg0.current_phase,
            timestamp      : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PhaseStopped>(v0);
    }

    public entry fun transfer_admin_cap(arg0: &mut DeedContract, arg1: AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        0x2::transfer::transfer<AdminCap>(arg1, arg0.owner);
        let v0 = AdminCapTransferred{
            sender    : 0x2::tx_context::sender(arg2),
            new_owner : arg0.owner,
        };
        0x2::event::emit<AdminCapTransferred>(v0);
    }

    public entry fun transfer_ownership(arg0: &mut DeedContract, arg1: &mut AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        arg0.pending_owner = arg2;
        let v0 = OwnershipTransferInitiated{
            current_owner : arg0.owner,
            pending_owner : arg2,
        };
        0x2::event::emit<OwnershipTransferInitiated>(v0);
    }

    fun update_address_commits_for_tier(arg0: &mut DeedContract, arg1: address, arg2: u8) {
        if (arg2 == 1) {
            if (0x2::table::contains<address, u64>(&arg0.commits_per_address_tier1, arg1)) {
                let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.commits_per_address_tier1, arg1);
                *v0 = *v0 + 1;
            } else {
                0x2::table::add<address, u64>(&mut arg0.commits_per_address_tier1, arg1, 1);
            };
        } else if (arg2 == 2) {
            if (0x2::table::contains<address, u64>(&arg0.commits_per_address_tier2, arg1)) {
                let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.commits_per_address_tier2, arg1);
                *v1 = *v1 + 1;
            } else {
                0x2::table::add<address, u64>(&mut arg0.commits_per_address_tier2, arg1, 1);
            };
        } else {
            assert!(arg2 == 3, 4);
            if (0x2::table::contains<address, u64>(&arg0.commits_per_address_tier3, arg1)) {
                let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.commits_per_address_tier3, arg1);
                *v2 = *v2 + 1;
            } else {
                0x2::table::add<address, u64>(&mut arg0.commits_per_address_tier3, arg1, 1);
            };
        };
    }

    fun update_address_deed_quantity_for_tier(arg0: &mut DeedContract, arg1: address, arg2: u8, arg3: u64) {
        if (arg2 == 1) {
            if (0x2::table::contains<address, u64>(&arg0.deed_quantity_per_address_tier1, arg1)) {
                let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.deed_quantity_per_address_tier1, arg1);
                *v0 = *v0 + arg3;
            } else {
                0x2::table::add<address, u64>(&mut arg0.deed_quantity_per_address_tier1, arg1, arg3);
            };
        } else if (arg2 == 2) {
            if (0x2::table::contains<address, u64>(&arg0.deed_quantity_per_address_tier2, arg1)) {
                let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.deed_quantity_per_address_tier2, arg1);
                *v1 = *v1 + arg3;
            } else {
                0x2::table::add<address, u64>(&mut arg0.deed_quantity_per_address_tier2, arg1, arg3);
            };
        } else {
            assert!(arg2 == 3, 4);
            if (0x2::table::contains<address, u64>(&arg0.deed_quantity_per_address_tier3, arg1)) {
                let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.deed_quantity_per_address_tier3, arg1);
                *v2 = *v2 + arg3;
            } else {
                0x2::table::add<address, u64>(&mut arg0.deed_quantity_per_address_tier3, arg1, arg3);
            };
        };
    }

    public entry fun update_total_cap(arg0: &mut DeedContract, arg1: &mut AdminCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        assert!(arg2 >= arg0.total_minted, 4);
        arg0.total_cap = arg2;
        let v0 = TimePeriodsUpdated{
            admin         : 0x2::tx_context::sender(arg4),
            commit_period : arg0.total_cap,
            refund_period : arg2,
            timestamp     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TimePeriodsUpdated>(v0);
    }

    public fun user_has_invite_code(arg0: &DeedContract, arg1: address) : bool {
        0x2::table::contains<address, vector<u8>>(&arg0.address_to_invite_code, arg1)
    }

    public entry fun vc_mint(arg0: &mut DeedContract, arg1: &mut AdminCap, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 1);
        assert!(arg3 > 0, 5);
        let v0 = 0;
        while (v0 < arg3) {
            let v1 = Deed{
                id        : 0x2::object::new(arg5),
                tier      : 6,
                minted_at : 0x2::clock::timestamp_ms(arg4),
            };
            0x2::transfer::transfer<Deed>(v1, arg2);
            v0 = v0 + 1;
        };
    }

    public entry fun withdraw_revenue(arg0: &mut DeedContract, arg1: &mut AdminCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        let v0 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.balance);
        assert!(v0 > 0, 15);
        assert!(arg2 <= v0, 5);
        let v1 = calculate_potential_refunds(arg0);
        let v2 = if (v0 > v1) {
            v0 - v1
        } else {
            0
        };
        assert!(arg2 <= v2, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, arg2, arg4), arg0.owner);
        let v3 = RevenueWithdrawal{
            admin             : 0x2::tx_context::sender(arg4),
            amount            : arg2,
            remaining_balance : v0 - arg2,
            timestamp         : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RevenueWithdrawal>(v3);
    }

    // decompiled from Move bytecode v6
}

