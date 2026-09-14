module 0xecb6f8cdb195855665654ac7946532ee4c7f38a7a88fe062fcf9a186841a253c::locker {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Locker has key {
        id: 0x2::object::UID,
        burn_proof: 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof,
        cetus_pool_id: 0x2::object::ID,
        launchpad_pool_id: 0x2::object::ID,
        dev_recipient: address,
        team_recipient: address,
        dev_bps: u64,
        team_bps: u64,
    }

    struct LockerCreated has copy, drop {
        locker_id: 0x2::object::ID,
        burn_proof_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        launchpad_pool_id: 0x2::object::ID,
        dev_recipient: address,
        team_recipient: address,
        dev_bps: u64,
        team_bps: u64,
    }

    struct TeamRecipientUpdated has copy, drop {
        locker_id: 0x2::object::ID,
        old_recipient: address,
        new_recipient: address,
    }

    struct FeesSplit has copy, drop {
        locker_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        launchpad_pool_id: 0x2::object::ID,
        dev_recipient: address,
        team_recipient: address,
        amount_a: u64,
        amount_b: u64,
        dev_amount_a: u64,
        dev_amount_b: u64,
        team_amount_a: u64,
        team_amount_b: u64,
        triggered_by: address,
    }

    public fun burn_and_share_locker(arg0: &AdminCap, arg1: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: 0x2::object::ID, arg4: address, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg4 != @0x0, 2);
        assert!(arg5 != @0x0, 2);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg2);
        let v1 = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp_v2(arg1, arg2, arg6);
        let v2 = Locker{
            id                : 0x2::object::new(arg6),
            burn_proof        : v1,
            cetus_pool_id     : v0,
            launchpad_pool_id : arg3,
            dev_recipient     : arg4,
            team_recipient    : arg5,
            dev_bps           : 5000,
            team_bps          : 5000,
        };
        let v3 = LockerCreated{
            locker_id         : 0x2::object::id<Locker>(&v2),
            burn_proof_id     : 0x2::object::id<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&v1),
            position_id       : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg2),
            cetus_pool_id     : v0,
            launchpad_pool_id : arg3,
            dev_recipient     : arg4,
            team_recipient    : arg5,
            dev_bps           : 5000,
            team_bps          : 5000,
        };
        0x2::event::emit<LockerCreated>(v3);
        0x2::transfer::share_object<Locker>(v2);
        v0
    }

    public fun burn_proof_id(arg0: &Locker) : 0x2::object::ID {
        0x2::object::id<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&arg0.burn_proof)
    }

    public fun cetus_pool_id(arg0: &Locker) : 0x2::object::ID {
        arg0.cetus_pool_id
    }

    public fun collect_and_split<T0, T1>(arg0: &mut Locker, arg1: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3) == arg0.cetus_pool_id, 1);
        let (v0, v1) = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::collect_fee<T0, T1>(arg1, arg2, arg3, &mut arg0.burn_proof, arg4);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = 0x2::coin::value<T1>(&v2);
        let v6 = dev_share(v4, arg0.dev_bps);
        let v7 = dev_share(v5, arg0.dev_bps);
        split_and_transfer<T0>(v3, arg0.dev_recipient, arg0.team_recipient, v6, arg4);
        split_and_transfer<T1>(v2, arg0.dev_recipient, arg0.team_recipient, v7, arg4);
        let v8 = FeesSplit{
            locker_id         : 0x2::object::id<Locker>(arg0),
            cetus_pool_id     : arg0.cetus_pool_id,
            launchpad_pool_id : arg0.launchpad_pool_id,
            dev_recipient     : arg0.dev_recipient,
            team_recipient    : arg0.team_recipient,
            amount_a          : v4,
            amount_b          : v5,
            dev_amount_a      : v6,
            dev_amount_b      : v7,
            team_amount_a     : v4 - v6,
            team_amount_b     : v5 - v7,
            triggered_by      : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<FeesSplit>(v8);
    }

    public fun dev_bps(arg0: &Locker) : u64 {
        arg0.dev_bps
    }

    public fun dev_recipient(arg0: &Locker) : address {
        arg0.dev_recipient
    }

    fun dev_share(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun launchpad_pool_id(arg0: &Locker) : 0x2::object::ID {
        arg0.launchpad_pool_id
    }

    fun split_and_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else if (arg3 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2);
        } else if (arg3 == v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, arg3, arg4), arg1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2);
        };
    }

    public fun team_bps(arg0: &Locker) : u64 {
        arg0.team_bps
    }

    public fun team_recipient(arg0: &Locker) : address {
        arg0.team_recipient
    }

    public fun update_team_recipient(arg0: &AdminCap, arg1: &mut Locker, arg2: address) {
        assert!(arg2 != @0x0, 2);
        arg1.team_recipient = arg2;
        let v0 = TeamRecipientUpdated{
            locker_id     : 0x2::object::id<Locker>(arg1),
            old_recipient : arg1.team_recipient,
            new_recipient : arg2,
        };
        0x2::event::emit<TeamRecipientUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

