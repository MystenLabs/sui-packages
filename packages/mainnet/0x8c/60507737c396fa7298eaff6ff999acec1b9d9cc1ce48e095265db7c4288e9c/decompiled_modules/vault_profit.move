module 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit {
    struct ProfitSharesUpdated has copy, drop {
        user: address,
        is_actual: bool,
        is_direct: bool,
        shares_amount: u64,
        is_add: bool,
        shortfall: u64,
    }

    struct InterestUpdated has copy, drop {
        user: address,
        claimable_profit: u64,
        claimable_reward: u64,
        claimable_compound: u64,
        last_update_epoch: u64,
    }

    struct EpochUpdated has copy, drop {
        epoch: u64,
        start_time: u64,
        end_time: u64,
        profit_interest: u64,
        compound_interest: u64,
    }

    struct UserShares has drop, store {
        vault_actual_shares: u64,
        direct_referral_shares: u64,
        indirect_referral_shares: u64,
    }

    struct UserInterest has drop, store {
        claimable_profit: u64,
        claimable_reward: u64,
        claimable_compound: u64,
        last_update_epoch: u64,
        last_claim_time: u64,
    }

    struct ProfitEpoch has drop, store {
        start_time: u64,
        end_time: u64,
        profit_interest: u64,
        profit_price: u64,
        compound_interest: u64,
        compound_price: u64,
    }

    struct VaultProfit has store, key {
        id: 0x2::object::UID,
        user_shares: 0x2::linked_table::LinkedTable<address, UserShares>,
        user_interest: 0x2::linked_table::LinkedTable<address, UserInterest>,
        current_epoch: u64,
        epochs: 0x2::table::Table<u64, ProfitEpoch>,
        shares_supply: u64,
        interest_supply: u64,
    }

    public entry fun batch_update_users_interest(arg0: &mut VaultProfit, arg1: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::VaultUser, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::assert_vault_admin(arg1, arg4);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::linked_table::front<address, UserShares>(&arg0.user_shares);
        let v2 = arg0.current_epoch;
        while (0x1::option::is_some<address>(v1)) {
            let v3 = *0x1::option::borrow<address>(v1);
            let v4 = 0x2::linked_table::borrow<address, UserInterest>(&arg0.user_interest, v3);
            if (v4.last_update_epoch < v2) {
                v2 = v4.last_update_epoch;
            };
            if (arg0.current_epoch - v4.last_update_epoch > arg2) {
                update_user_interest(arg0, v3, v0);
            };
            v1 = 0x2::linked_table::next<address, UserShares>(&arg0.user_shares, v3);
        };
        let v5 = if (v2 > 10) {
            v2 - 10
        } else {
            0
        };
        let v6 = 0;
        while (v6 < v5) {
            if (0x2::table::contains<u64, ProfitEpoch>(&arg0.epochs, v6)) {
                0x2::table::remove<u64, ProfitEpoch>(&mut arg0.epochs, v6);
            };
            v6 = v6 + 1;
        };
        update_epoch(arg0, v0);
    }

    fun calculate_claimable_interest(arg0: &VaultProfit, arg1: &UserShares, arg2: &UserInterest) : (u64, u64, u64) {
        let v0 = arg2.claimable_profit;
        let v1 = v0;
        let v2 = arg2.claimable_reward;
        let v3 = v2;
        let v4 = arg2.claimable_compound;
        let v5 = v4;
        let v6 = v0 + v2 + v4;
        let v7 = arg2.last_update_epoch + 1;
        while (v7 <= arg0.current_epoch) {
            if (0x2::table::contains<u64, ProfitEpoch>(&arg0.epochs, v7)) {
                let v8 = 0x2::table::borrow<u64, ProfitEpoch>(&arg0.epochs, v7);
                let v9 = if (v6 > 0) {
                    (((v8.compound_price as u128) * (v6 as u128) / 1000000000) as u64)
                } else {
                    0
                };
                let v10 = v1 + (((v8.profit_price as u128) * (arg1.vault_actual_shares as u128) / 1000000000) as u64);
                v1 = v10;
                let v11 = v3 + (((v8.profit_price as u128) * ((arg1.direct_referral_shares + arg1.indirect_referral_shares) as u128) / 1000000000) as u64);
                v3 = v11;
                let v12 = v5 + v9;
                v5 = v12;
                v6 = v10 + v11 + v12;
            };
            v7 = v7 + 1;
        };
        (v1, v3, v5)
    }

    public(friend) fun claim_profit_prepare(arg0: &mut VaultProfit, arg1: address, arg2: &0x2::clock::Clock) : (u64, u64, u64) {
        if (!0x2::linked_table::contains<address, UserShares>(&arg0.user_shares, arg1)) {
            return (0, 0, 0)
        };
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (!(v0 - 0x2::linked_table::borrow<address, UserInterest>(&arg0.user_interest, arg1).last_claim_time >= 3600000 / 2)) {
            return (0, 0, 0)
        };
        update_user_interest(arg0, arg1, v0);
        let v1 = 0x2::linked_table::borrow<address, UserInterest>(&arg0.user_interest, arg1);
        (v1.claimable_profit, v1.claimable_reward, v1.claimable_compound)
    }

    public(friend) fun claim_profit_success(arg0: &mut VaultProfit, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg0.interest_supply = arg0.interest_supply - arg2;
        let v1 = 0x2::linked_table::borrow_mut<address, UserInterest>(&mut arg0.user_interest, arg1);
        v1.claimable_profit = 0;
        v1.claimable_reward = 0;
        v1.claimable_compound = 0;
        v1.last_claim_time = v0;
        update_epoch(arg0, v0);
    }

    public(friend) fun create_vault_profit(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = VaultProfit{
            id              : 0x2::object::new(arg0),
            user_shares     : 0x2::linked_table::new<address, UserShares>(arg0),
            user_interest   : 0x2::linked_table::new<address, UserInterest>(arg0),
            current_epoch   : 0,
            epochs          : 0x2::table::new<u64, ProfitEpoch>(arg0),
            shares_supply   : 0,
            interest_supply : 0,
        };
        0x2::transfer::share_object<VaultProfit>(v0);
        0x2::object::uid_to_inner(&v0.id)
    }

    public(friend) fun fix_profit_shares(arg0: &mut VaultProfit) : bool {
        let v0 = 0;
        let v1 = 0x2::linked_table::front<address, UserShares>(&arg0.user_shares);
        while (0x1::option::is_some<address>(v1)) {
            let v2 = *0x1::option::borrow<address>(v1);
            let v3 = 0x2::linked_table::borrow<address, UserShares>(&arg0.user_shares, v2);
            let v4 = v0 + v3.vault_actual_shares + v3.direct_referral_shares;
            v0 = v4 + v3.indirect_referral_shares;
            v1 = 0x2::linked_table::next<address, UserShares>(&arg0.user_shares, v2);
        };
        if (v0 != arg0.shares_supply) {
            let v5 = 0x2::linked_table::borrow_mut<address, UserShares>(&mut arg0.user_shares, @0x2012);
            let v6 = if (v0 > arg0.shares_supply) {
                v0 - arg0.shares_supply
            } else {
                arg0.shares_supply - v0
            };
            if (v0 > arg0.shares_supply) {
                if (v6 * 100 > arg0.shares_supply) {
                    return false
                };
                arg0.shares_supply = v0;
            } else {
                v5.vault_actual_shares = v5.vault_actual_shares + v6;
            };
            let v7 = ProfitSharesUpdated{
                user          : @0x2012,
                is_actual     : true,
                is_direct     : false,
                shares_amount : v6,
                is_add        : arg0.shares_supply > v0,
                shortfall     : 0,
            };
            0x2::event::emit<ProfitSharesUpdated>(v7);
        };
        true
    }

    public entry fun get_profit_epoch(arg0: &VaultProfit, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = arg0.current_epoch - arg1;
        let v1 = 0x2::table::borrow<u64, ProfitEpoch>(&arg0.epochs, v0);
        (v0, v1.start_time, v1.end_time, v1.profit_interest, v1.profit_price, v1.compound_interest, v1.compound_price, arg0.shares_supply, arg0.interest_supply)
    }

    public(friend) fun interest_supply(arg0: &VaultProfit) : u64 {
        arg0.interest_supply
    }

    public(friend) fun is_current_epoch_empty(arg0: &VaultProfit) : bool {
        let v0 = arg0.current_epoch;
        if (v0 == 0) {
            return false
        };
        let v1 = 0x2::table::borrow<u64, ProfitEpoch>(&arg0.epochs, v0);
        v1.end_time == 0 && v1.profit_interest + v1.compound_interest == 0
    }

    public(friend) fun recover_interest(arg0: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::AdminCap, arg1: &mut VaultProfit, arg2: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::VaultUser, arg3: address, arg4: address, arg5: &0x2::clock::Clock) {
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::assert_lost_user(arg2, arg3, arg5);
        if (0x2::linked_table::contains<address, UserInterest>(&arg1.user_interest, arg3)) {
            let (v0, v1, v2) = calculate_claimable_interest(arg1, 0x2::linked_table::borrow<address, UserShares>(&arg1.user_shares, arg3), 0x2::linked_table::borrow<address, UserInterest>(&arg1.user_interest, arg3));
            let v3 = 0x2::linked_table::borrow_mut<address, UserInterest>(&mut arg1.user_interest, arg4);
            v3.claimable_profit = v3.claimable_profit + v0;
            v3.claimable_reward = v3.claimable_reward + v1;
            v3.claimable_compound = v3.claimable_compound + v2;
            let v4 = 0x2::linked_table::borrow_mut<address, UserInterest>(&mut arg1.user_interest, arg3);
            v4.claimable_profit = 0;
            v4.claimable_reward = 0;
            v4.claimable_compound = 0;
            v4.last_update_epoch = arg1.current_epoch;
        };
    }

    public(friend) fun recover_profit_shares(arg0: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::AdminCap, arg1: &mut VaultProfit, arg2: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::VaultUser, arg3: address, arg4: address, arg5: &0x2::clock::Clock) {
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::assert_lost_user(arg2, arg3, arg5);
        if (0x2::linked_table::contains<address, UserShares>(&arg1.user_shares, arg3)) {
            let (v0, v1, v2) = user_shares(arg1, arg3);
            let v3 = 0x2::linked_table::borrow_mut<address, UserShares>(&mut arg1.user_shares, arg4);
            v3.vault_actual_shares = v3.vault_actual_shares + v0;
            v3.direct_referral_shares = v3.direct_referral_shares + v1;
            v3.indirect_referral_shares = v3.indirect_referral_shares + v2;
            let v4 = 0x2::linked_table::borrow_mut<address, UserShares>(&mut arg1.user_shares, arg3);
            v4.vault_actual_shares = 0;
            v4.direct_referral_shares = 0;
            v4.indirect_referral_shares = 0;
        };
    }

    public(friend) fun register_profit_user(arg0: &mut VaultProfit, arg1: address, arg2: u64) {
        let v0 = if (is_current_epoch_empty(arg0)) {
            arg0.current_epoch - 1
        } else {
            arg0.current_epoch
        };
        if (!0x2::linked_table::contains<address, UserShares>(&arg0.user_shares, arg1)) {
            let v1 = UserShares{
                vault_actual_shares      : 0,
                direct_referral_shares   : 0,
                indirect_referral_shares : 0,
            };
            0x2::linked_table::push_back<address, UserShares>(&mut arg0.user_shares, arg1, v1);
        };
        if (!0x2::linked_table::contains<address, UserInterest>(&arg0.user_interest, arg1)) {
            let v2 = UserInterest{
                claimable_profit   : 0,
                claimable_reward   : 0,
                claimable_compound : 0,
                last_update_epoch  : v0,
                last_claim_time    : arg2,
            };
            0x2::linked_table::push_back<address, UserInterest>(&mut arg0.user_interest, arg1, v2);
        };
    }

    public(friend) fun shares_supply(arg0: &VaultProfit) : u64 {
        arg0.shares_supply
    }

    fun update_epoch(arg0: &mut VaultProfit, arg1: u64) {
        let v0 = ProfitEpoch{
            start_time        : arg1,
            end_time          : 0,
            profit_interest   : 0,
            profit_price      : 0,
            compound_interest : 0,
            compound_price    : 0,
        };
        if (arg0.current_epoch > 0) {
            let v1 = 0x2::table::borrow_mut<u64, ProfitEpoch>(&mut arg0.epochs, arg0.current_epoch);
            if (v1.end_time == 0 && v1.profit_interest + v1.compound_interest > 0) {
                v1.end_time = arg1;
                let v2 = EpochUpdated{
                    epoch             : arg0.current_epoch,
                    start_time        : v1.start_time,
                    end_time          : arg1,
                    profit_interest   : v1.profit_interest,
                    compound_interest : v1.compound_interest,
                };
                0x2::event::emit<EpochUpdated>(v2);
                arg0.current_epoch = arg0.current_epoch + 1;
                0x2::table::add<u64, ProfitEpoch>(&mut arg0.epochs, arg0.current_epoch, v0);
                let v3 = EpochUpdated{
                    epoch             : arg0.current_epoch,
                    start_time        : arg1,
                    end_time          : 0,
                    profit_interest   : 0,
                    compound_interest : 0,
                };
                0x2::event::emit<EpochUpdated>(v3);
            };
        } else {
            arg0.current_epoch = 1;
            0x2::table::add<u64, ProfitEpoch>(&mut arg0.epochs, 1, v0);
            let v4 = EpochUpdated{
                epoch             : 1,
                start_time        : arg1,
                end_time          : 0,
                profit_interest   : 0,
                compound_interest : 0,
            };
            0x2::event::emit<EpochUpdated>(v4);
        };
    }

    public(friend) fun update_epoch_interest(arg0: &mut VaultProfit, arg1: u64, arg2: bool, arg3: u8, arg4: u64) {
        if (arg0.shares_supply == 0) {
            return
        };
        if (arg0.current_epoch == 0) {
            update_epoch(arg0, arg4);
        };
        let v0 = 0x2::table::borrow_mut<u64, ProfitEpoch>(&mut arg0.epochs, arg0.current_epoch);
        if (arg2) {
            v0.profit_interest = v0.profit_interest + arg1;
            v0.profit_price = (((v0.profit_interest as u128) * 1000000000 / (arg0.shares_supply as u128)) as u64);
        } else {
            v0.compound_interest = v0.compound_interest + arg1;
            v0.compound_price = (((v0.compound_interest as u128) * 1000000000 / (arg0.interest_supply as u128)) as u64);
        };
        arg0.interest_supply = arg0.interest_supply + arg1;
        let v1 = EpochUpdated{
            epoch             : arg0.current_epoch,
            start_time        : v0.start_time,
            end_time          : v0.end_time,
            profit_interest   : v0.profit_interest,
            compound_interest : v0.compound_interest,
        };
        0x2::event::emit<EpochUpdated>(v1);
        let v2 = v0.start_time;
        if (v2 < arg4 - 3600000 && arg4 - v2 > 3600000 * (arg3 as u64)) {
            update_epoch(arg0, arg4);
        };
    }

    public(friend) fun update_profit_shares(arg0: &mut VaultProfit, arg1: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::VaultUser, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: u64) {
        update_single_share(arg0, arg2, true, true, arg3, arg7, arg8);
        let v0 = arg6;
        let v1 = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::get_referrer(arg1, arg2);
        if (v1 != @0x2012) {
            update_single_share(arg0, v1, false, true, arg4, arg7, arg8);
        } else {
            v0 = arg6 + arg4;
        };
        let v2 = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::get_referrer(arg1, v1);
        if (v2 != @0x2012) {
            update_single_share(arg0, v2, false, false, arg5, arg7, arg8);
        } else {
            v0 = v0 + arg5;
        };
        update_single_share(arg0, @0x2012, true, true, v0, arg7, arg8);
        update_epoch(arg0, arg8);
    }

    public(friend) fun update_referrers_shares(arg0: &mut VaultProfit, arg1: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::VaultUser, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: u64) {
        if (arg2 == @0x2012) {
            return
        };
        if (arg3 + arg4 + arg5 + arg6 == 0) {
            return
        };
        if (arg2 != @0x2012 && arg3 + arg4 > 0) {
            let v0 = 0x2::linked_table::borrow<address, UserShares>(&arg0.user_shares, arg2);
            update_single_share(arg0, arg2, false, true, v0.direct_referral_shares * arg3 / 100, arg7, arg8);
            update_single_share(arg0, arg2, false, false, v0.indirect_referral_shares * arg4 / 100, arg7, arg8);
        };
        let v1 = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::get_referrer(arg1, arg2);
        if (v1 != @0x2012 && arg5 + arg6 > 0) {
            let v2 = 0x2::linked_table::borrow<address, UserShares>(&arg0.user_shares, v1);
            update_single_share(arg0, v1, false, true, v2.direct_referral_shares * arg5 / 100, arg7, arg8);
            update_single_share(arg0, v1, false, false, v2.indirect_referral_shares * arg6 / 100, arg7, arg8);
        };
        update_epoch(arg0, arg8);
    }

    fun update_single_share(arg0: &mut VaultProfit, arg1: address, arg2: bool, arg3: bool, arg4: u64, arg5: bool, arg6: u64) {
        register_profit_user(arg0, arg1, arg6);
        update_user_interest(arg0, arg1, arg6);
        if (arg4 == 0) {
            return
        };
        let v0 = if (arg2) {
            &mut 0x2::linked_table::borrow_mut<address, UserShares>(&mut arg0.user_shares, arg1).vault_actual_shares
        } else if (arg3) {
            &mut 0x2::linked_table::borrow_mut<address, UserShares>(&mut arg0.user_shares, arg1).direct_referral_shares
        } else {
            &mut 0x2::linked_table::borrow_mut<address, UserShares>(&mut arg0.user_shares, arg1).indirect_referral_shares
        };
        let v1 = 0;
        if (arg5) {
            *v0 = *v0 + arg4;
            arg0.shares_supply = arg0.shares_supply + arg4;
        } else if (*v0 >= arg4) {
            arg0.shares_supply = arg0.shares_supply - arg4;
            *v0 = *v0 - arg4;
        } else {
            arg0.shares_supply = arg0.shares_supply - *v0;
            v1 = arg4 - *v0;
            *v0 = 0;
        };
        let v2 = ProfitSharesUpdated{
            user          : arg1,
            is_actual     : arg2,
            is_direct     : arg3,
            shares_amount : arg4,
            is_add        : arg5,
            shortfall     : v1,
        };
        0x2::event::emit<ProfitSharesUpdated>(v2);
    }

    public(friend) fun update_user_interest(arg0: &mut VaultProfit, arg1: address, arg2: u64) {
        let v0 = arg0.current_epoch;
        let v1 = is_current_epoch_empty(arg0);
        let v2 = 0x2::linked_table::borrow<address, UserInterest>(&arg0.user_interest, arg1);
        if (v1 && v2.last_update_epoch + 1 < v0 || !v1 && v2.last_update_epoch < v0) {
            let (v3, v4, v5) = calculate_claimable_interest(arg0, 0x2::linked_table::borrow<address, UserShares>(&arg0.user_shares, arg1), 0x2::linked_table::borrow<address, UserInterest>(&arg0.user_interest, arg1));
            let v6 = 0x2::linked_table::borrow_mut<address, UserInterest>(&mut arg0.user_interest, arg1);
            v6.claimable_profit = v3;
            v6.claimable_reward = v4;
            v6.claimable_compound = v5;
            let v7 = if (v1) {
                v0 - 1
            } else {
                v0
            };
            v6.last_update_epoch = v7;
            let v8 = InterestUpdated{
                user               : arg1,
                claimable_profit   : v6.claimable_profit,
                claimable_reward   : v6.claimable_reward,
                claimable_compound : v6.claimable_compound,
                last_update_epoch  : v6.last_update_epoch,
            };
            0x2::event::emit<InterestUpdated>(v8);
        };
    }

    public entry fun user_profit_info(arg0: &VaultProfit, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = 0x2::linked_table::borrow<address, UserShares>(&arg0.user_shares, arg1);
        let v1 = 0x2::linked_table::borrow<address, UserInterest>(&arg0.user_interest, arg1);
        let (v2, v3, v4) = calculate_claimable_interest(arg0, v0, v1);
        (v0.vault_actual_shares, v0.direct_referral_shares, v0.indirect_referral_shares, v2, v3, v4, v1.last_update_epoch, v1.last_claim_time)
    }

    public(friend) fun user_shares(arg0: &VaultProfit, arg1: address) : (u64, u64, u64) {
        if (0x2::linked_table::contains<address, UserShares>(&arg0.user_shares, arg1)) {
            let v3 = 0x2::linked_table::borrow<address, UserShares>(&arg0.user_shares, arg1);
            (v3.vault_actual_shares, v3.direct_referral_shares, v3.indirect_referral_shares)
        } else {
            (0, 0, 0)
        }
    }

    // decompiled from Move bytecode v6
}

