module 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::fees {
    struct LossTicket {
        basis: u64,
        account_id: 0x2::object::ID,
        parked: bool,
    }

    struct StakerFee<phantom T0> {
        balance: 0x2::balance::Balance<T0>,
    }

    struct StakingSink has store, key {
        id: 0x2::object::UID,
    }

    struct SinkMintedKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun account_id(arg0: &LossTicket) : 0x2::object::ID {
        arg0.account_id
    }

    public fun basis(arg0: &LossTicket) : u64 {
        arg0.basis
    }

    public fun claim_pending_ticket<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::AccountCap) : LossTicket {
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0));
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_unpaused(arg1, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::pause_fee_mint());
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_cap<T0>(arg2, arg3);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_exchange<T0>(arg2, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg0));
        let v1 = 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(arg2);
        LossTicket{
            basis      : 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::take_pending_basis<T0>(&v0, arg0, v1),
            account_id : v1,
            parked     : true,
        }
    }

    public fun discard_zero_loss(arg0: LossTicket) {
        let LossTicket {
            basis      : v0,
            account_id : _,
            parked     : _,
        } = arg0;
        assert!(v0 == 0, 13835058626512814081);
    }

    public fun open_staking_sink(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : StakingSink {
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::uid(arg0));
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config>(arg0), arg1);
        let v1 = SinkMintedKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<SinkMintedKey>(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::uid(arg0), v1), 13835339912511094787);
        let v2 = SinkMintedKey{dummy_field: false};
        0x2::dynamic_field::add<SinkMintedKey, bool>(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::uid_mut(&v0, arg0), v2, true);
        let v3 = StakingSink{id: 0x2::object::new(arg2)};
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v0, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config>(arg0), 47);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_open_staking_sink_event(&v0, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config>(arg0), 0x2::object::id<StakingSink>(&v3));
        v3
    }

    public fun release_staker_fee<T0>(arg0: StakerFee<T0>, arg1: &StakingSink) : 0x2::balance::Balance<T0> {
        0x2::object::id<StakingSink>(arg1);
        let StakerFee { balance: v0 } = arg0;
        v0
    }

    public(friend) fun settle_loss_ticket(arg0: LossTicket) : u64 {
        let (v0, _) = settle_parked(arg0);
        v0
    }

    public(friend) fun settle_parked(arg0: LossTicket) : (u64, bool) {
        let LossTicket {
            basis      : v0,
            account_id : _,
            parked     : v2,
        } = arg0;
        (v0, v2)
    }

    public fun take_referral_funding<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: &StakingSink, arg3: u64) : 0x2::balance::Balance<T0> {
        0x2::object::id<StakingSink>(arg2);
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0));
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::take_staking_referral_funding<T0>(&v0, arg0, arg1, arg3)
    }

    public(friend) fun ticket(arg0: u64, arg1: 0x2::object::ID) : LossTicket {
        LossTicket{
            basis      : arg0,
            account_id : arg1,
            parked     : false,
        }
    }

    public fun withdraw_staker_fees<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config) : StakerFee<T0> {
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0));
        StakerFee<T0>{balance: 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::take_staker_rewards<T0>(&v0, arg0, arg1)}
    }

    // decompiled from Move bytecode v7
}

