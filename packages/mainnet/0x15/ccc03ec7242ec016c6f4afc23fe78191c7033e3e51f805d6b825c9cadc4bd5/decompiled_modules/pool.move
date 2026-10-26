module 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::pool {
    struct Pool has store {
        treasury: u64,
        side_bucket: u64,
        total_queued: u64,
        total_paid: u64,
        payout_pot: u64,
        team_accrued: u64,
        reward_acc: u128,
        reward_pending: u64,
        reward_unclaimed: u64,
        paper_supply: u64,
        tail_progress: u64,
        ref_pot: u64,
    }

    struct Holder has copy, drop, store {
        paper: u64,
        acc_snapshot: u128,
    }

    struct Claim has copy, drop, store {
        start: u64,
        amount: u64,
        collected: u64,
    }

    struct LossReceipt has copy, drop {
        fee_team: u64,
        fee_holders: u64,
        to_treasury: u64,
        to_side_bucket: u64,
        paper: u64,
        rewards: u64,
    }

    struct WinReceipt has copy, drop {
        paid: u64,
        queued: 0x1::option::Option<Claim>,
        fee_team: u64,
        fee_holders: u64,
    }

    public fun claim_amount(arg0: &Claim) : u64 {
        arg0.amount
    }

    public fun claim_collected(arg0: &Claim) : u64 {
        arg0.collected
    }

    public fun claim_done(arg0: &Claim) : bool {
        arg0.collected == arg0.amount
    }

    public fun claim_start(arg0: &Claim) : u64 {
        arg0.start
    }

    public(friend) fun collect(arg0: &mut Pool, arg1: &mut Claim) : u64 {
        let v0 = collectable(arg0, arg1);
        arg0.payout_pot = arg0.payout_pot - v0;
        arg1.collected = arg1.collected + v0;
        v0
    }

    public fun collectable(arg0: &Pool, arg1: &Claim) : u64 {
        let v0 = if (arg0.total_paid > arg1.start) {
            arg0.total_paid - arg1.start
        } else {
            0
        };
        let v1 = if (v0 < arg1.amount) {
            v0
        } else {
            arg1.amount
        };
        if (v1 > arg1.collected) {
            v1 - arg1.collected
        } else {
            0
        }
    }

    fun distribute(arg0: &mut Pool, arg1: u64, arg2: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::Params) {
        if (arg1 == 0) {
            return
        };
        if (arg0.paper_supply == 0) {
            arg0.reward_pending = arg0.reward_pending + arg1;
            return
        };
        let v0 = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::ref_bonus_wad(arg2) + 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::ref_bonus2_wad(arg2);
        let v1 = arg1 + arg0.reward_pending + arg0.ref_pot;
        arg0.reward_pending = 0;
        let v2 = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::fixed::wad_mul(arg0.reward_unclaimed, v0, true);
        let v3 = if (v1 > v2) {
            v1 - v2
        } else {
            0
        };
        let v4 = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::fixed::mul_div_u64(v3, 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::fixed::wad(), 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::fixed::wad() + v0, false);
        arg0.ref_pot = v1 - v4;
        if (v4 == 0) {
            return
        };
        arg0.reward_acc = arg0.reward_acc + 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::fixed::mul_div((v4 as u128), 1000000000000000000, (arg0.paper_supply as u128), false);
        arg0.reward_unclaimed = arg0.reward_unclaimed + v4;
    }

    fun enqueue(arg0: &mut Pool, arg1: u64) : Claim {
        let v0 = Claim{
            start     : arg0.total_queued,
            amount    : arg1,
            collected : 0,
        };
        arg0.total_queued = arg0.total_queued + arg1;
        v0
    }

    public(friend) fun harvest(arg0: &mut Pool) : u64 {
        let v0 = queued_debt(arg0);
        let v1 = arg0.side_bucket + arg0.treasury;
        let v2 = if (v0 < v1) {
            v0
        } else {
            v1
        };
        let v3 = if (v2 < arg0.side_bucket) {
            v2
        } else {
            arg0.side_bucket
        };
        arg0.side_bucket = arg0.side_bucket - v3;
        arg0.treasury = arg0.treasury - v2 - v3;
        arg0.payout_pot = arg0.payout_pot + v2;
        arg0.total_paid = arg0.total_paid + v2;
        if (queued_debt(arg0) == 0) {
            arg0.treasury = arg0.treasury + arg0.side_bucket;
            arg0.side_bucket = 0;
        };
        v2
    }

    public fun held(arg0: &Pool) : u64 {
        arg0.treasury + arg0.side_bucket + arg0.payout_pot + arg0.team_accrued + arg0.reward_pending + arg0.reward_unclaimed + arg0.ref_pot
    }

    public fun holder_paper(arg0: &Holder) : u64 {
        arg0.paper
    }

    public fun loss_fee_team(arg0: &LossReceipt) : u64 {
        arg0.fee_team
    }

    public fun loss_paper(arg0: &LossReceipt) : u64 {
        arg0.paper
    }

    public fun loss_rewards(arg0: &LossReceipt) : u64 {
        arg0.rewards
    }

    public fun loss_to_side_bucket(arg0: &LossReceipt) : u64 {
        arg0.to_side_bucket
    }

    public(friend) fun new() : Pool {
        Pool{
            treasury         : 0,
            side_bucket      : 0,
            total_queued     : 0,
            total_paid       : 0,
            payout_pot       : 0,
            team_accrued     : 0,
            reward_acc       : 0,
            reward_pending   : 0,
            reward_unclaimed : 0,
            paper_supply     : 0,
            tail_progress    : 0,
            ref_pot          : 0,
        }
    }

    public(friend) fun new_holder() : Holder {
        Holder{
            paper        : 0,
            acc_snapshot : 0,
        }
    }

    public(friend) fun on_close_charge(arg0: &mut Pool, arg1: u64) {
        if (queued_debt(arg0) == 0) {
            arg0.treasury = arg0.treasury + arg1;
        } else {
            arg0.side_bucket = arg0.side_bucket + arg1;
        };
    }

    public(friend) fun on_loss(arg0: &mut Pool, arg1: u64, arg2: bool, arg3: &mut Holder, arg4: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::Params) : LossReceipt {
        let v0 = arg0.treasury + arg0.side_bucket;
        let v1 = queued_debt(arg0);
        let v2 = LossReceipt{
            fee_team       : 0,
            fee_holders    : 0,
            to_treasury    : 0,
            to_side_bucket : 0,
            paper          : 0,
            rewards        : 0,
        };
        let v3 = if (v1 == 0) {
            let v4 = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::fixed::wad_mul(arg1, 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::loss_fee_wad(arg4), false);
            v2.fee_team = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::fixed::wad_mul(v4, 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::team_loss_fee_share_wad(arg4), false);
            v2.fee_holders = v4 - v2.fee_team;
            v2.to_treasury = arg1 - v4;
            arg0.treasury = arg0.treasury + v2.to_treasury;
            arg0.team_accrued = arg0.team_accrued + v2.fee_team;
            distribute(arg0, v2.fee_holders, arg4);
            if (arg2) {
                arg1
            } else {
                arg1 - v4
            }
        } else {
            v2.to_side_bucket = arg1;
            arg0.side_bucket = arg0.side_bucket + arg1;
            arg1
        };
        let v5 = settle_holder(arg0, arg3);
        v2.rewards = v5;
        let (v6, v7) = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::paper::mint(v3, v0, v1, arg0.tail_progress, arg4);
        arg0.tail_progress = v7;
        arg0.paper_supply = arg0.paper_supply + v6;
        arg3.paper = arg3.paper + v6;
        v2.paper = v6;
        v2
    }

    public(friend) fun on_plain_loss(arg0: &mut Pool, arg1: u64, arg2: &mut Holder, arg3: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::Params) : LossReceipt {
        let v0 = arg0.treasury + arg0.side_bucket;
        let v1 = queued_debt(arg0);
        let v2 = LossReceipt{
            fee_team       : 0,
            fee_holders    : 0,
            to_treasury    : 0,
            to_side_bucket : 0,
            paper          : 0,
            rewards        : 0,
        };
        if (v1 == 0) {
            v2.to_treasury = arg1;
            arg0.treasury = arg0.treasury + arg1;
        } else {
            v2.to_side_bucket = arg1;
            arg0.side_bucket = arg0.side_bucket + arg1;
        };
        let v3 = settle_holder(arg0, arg2);
        v2.rewards = v3;
        let (v4, v5) = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::paper::mint(arg1, v0, v1, arg0.tail_progress, arg3);
        arg0.tail_progress = v5;
        arg0.paper_supply = arg0.paper_supply + v4;
        arg2.paper = arg2.paper + v4;
        v2.paper = v4;
        v2
    }

    public(friend) fun on_plain_win(arg0: &mut Pool, arg1: u64) : WinReceipt {
        let v0 = WinReceipt{
            paid        : 0,
            queued      : 0x1::option::none<Claim>(),
            fee_team    : 0,
            fee_holders : 0,
        };
        if (arg1 == 0) {
            return v0
        };
        if (queued_debt(arg0) > 0) {
            v0.queued = 0x1::option::some<Claim>(enqueue(arg0, arg1));
        } else if (arg0.treasury >= arg1) {
            arg0.treasury = arg0.treasury - arg1;
            v0.paid = arg1;
        } else {
            v0.paid = arg0.treasury;
            arg0.treasury = 0;
            v0.queued = 0x1::option::some<Claim>(enqueue(arg0, arg1 - v0.paid));
        };
        v0
    }

    public(friend) fun on_win(arg0: &mut Pool, arg1: u64, arg2: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::Params) : WinReceipt {
        let v0 = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::fixed::wad_mul(arg1, 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::win_fee_wad(arg2), true);
        let v1 = arg1 - v0;
        let v2 = WinReceipt{
            paid        : 0,
            queued      : 0x1::option::none<Claim>(),
            fee_team    : 0,
            fee_holders : 0,
        };
        if (v1 == 0) {
            return v2
        };
        if (queued_debt(arg0) > 0) {
            v2.queued = 0x1::option::some<Claim>(enqueue(arg0, v1));
        } else if (arg0.treasury >= arg1) {
            arg0.treasury = arg0.treasury - arg1;
            v2.paid = v1;
            v2.fee_team = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::fixed::wad_mul(v0, 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::team_win_fee_share_wad(arg2), false);
            v2.fee_holders = v0 - v2.fee_team;
            arg0.team_accrued = arg0.team_accrued + v2.fee_team;
            distribute(arg0, v2.fee_holders, arg2);
        } else if (arg0.treasury >= v1) {
            arg0.treasury = arg0.treasury - v1;
            v2.paid = v1;
        } else {
            v2.paid = arg0.treasury;
            arg0.treasury = 0;
            v2.queued = 0x1::option::some<Claim>(enqueue(arg0, v1 - v2.paid));
        };
        v2
    }

    public fun paper_supply(arg0: &Pool) : u64 {
        arg0.paper_supply
    }

    public(friend) fun pay_referral(arg0: &mut Pool, arg1: u64, arg2: bool, arg3: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::Params) : (u64, u64) {
        let v0 = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::fixed::wad_mul(arg1, 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::ref_bonus_wad(arg3), false);
        let v1 = v0;
        if (v0 > arg0.ref_pot) {
            v1 = arg0.ref_pot;
        };
        arg0.ref_pot = arg0.ref_pot - v1;
        let v2 = if (arg2) {
            0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::fixed::wad_mul(arg1, 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::ref_bonus2_wad(arg3), false)
        } else {
            0
        };
        let v3 = v2;
        if (v2 > arg0.ref_pot) {
            v3 = arg0.ref_pot;
        };
        arg0.ref_pot = arg0.ref_pot - v3;
        (v1, v3)
    }

    public fun payout_pot(arg0: &Pool) : u64 {
        arg0.payout_pot
    }

    public fun queued_debt(arg0: &Pool) : u64 {
        arg0.total_queued - arg0.total_paid
    }

    public fun ref_pot(arg0: &Pool) : u64 {
        arg0.ref_pot
    }

    public fun reward_acc(arg0: &Pool) : u128 {
        arg0.reward_acc
    }

    public fun reward_pending(arg0: &Pool) : u64 {
        arg0.reward_pending
    }

    public fun reward_unclaimed(arg0: &Pool) : u64 {
        arg0.reward_unclaimed
    }

    public(friend) fun settle_holder(arg0: &mut Pool, arg1: &mut Holder) : u64 {
        let v0 = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::fixed::mul_div((arg1.paper as u128), arg0.reward_acc - arg1.acc_snapshot, 1000000000000000000, false);
        arg1.acc_snapshot = arg0.reward_acc;
        let v1 = if (v0 > (arg0.reward_unclaimed as u128)) {
            arg0.reward_unclaimed
        } else {
            (v0 as u64)
        };
        arg0.reward_unclaimed = arg0.reward_unclaimed - v1;
        v1
    }

    public fun side_bucket(arg0: &Pool) : u64 {
        arg0.side_bucket
    }

    public(friend) fun sweep_overflow(arg0: &mut Pool, arg1: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::Params) : (u64, u64) {
        assert!(queued_debt(arg0) == 0, 0);
        harvest(arg0);
        let v0 = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::pool_cap(arg1);
        let v1 = if (arg0.treasury > v0) {
            arg0.treasury - v0
        } else {
            0
        };
        assert!(v1 >= 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::min_sweep(arg1), 1);
        let v2 = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::fixed::wad_mul(v1, 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::team_overflow_share_wad(arg1), false);
        arg0.treasury = arg0.treasury - v1;
        arg0.team_accrued = arg0.team_accrued + v2;
        distribute(arg0, v1 - v2, arg1);
        (v2, v1 - v2)
    }

    public fun tail_progress(arg0: &Pool) : u64 {
        arg0.tail_progress
    }

    public fun team_accrued(arg0: &Pool) : u64 {
        arg0.team_accrued
    }

    public fun total_paid(arg0: &Pool) : u64 {
        arg0.total_paid
    }

    public fun total_queued(arg0: &Pool) : u64 {
        arg0.total_queued
    }

    public fun treasury(arg0: &Pool) : u64 {
        arg0.treasury
    }

    public fun win_fee_team(arg0: &WinReceipt) : u64 {
        arg0.fee_team
    }

    public fun win_paid(arg0: &WinReceipt) : u64 {
        arg0.paid
    }

    public fun win_queued(arg0: &WinReceipt) : 0x1::option::Option<Claim> {
        arg0.queued
    }

    public(friend) fun withdraw_team(arg0: &mut Pool, arg1: u64) {
        assert!(arg1 <= arg0.team_accrued, 2);
        arg0.team_accrued = arg0.team_accrued - arg1;
    }

    // decompiled from Move bytecode v7
}

