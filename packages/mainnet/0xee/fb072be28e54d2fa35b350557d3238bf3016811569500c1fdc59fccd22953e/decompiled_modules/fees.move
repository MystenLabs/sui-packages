module 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fees {
    struct LossTicket {
        basis: u64,
        account_id: 0x2::object::ID,
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

    public fun claim_pending_ticket<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::AccountCap) : LossTicket {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid<T0>(arg0));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_version<T0>(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_unpaused(arg1, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::pause_fee_mint());
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_cap<T0>(arg2, arg3);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_exchange<T0>(arg2, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>>(arg0));
        let v1 = 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>>(arg2);
        LossTicket{
            basis      : 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::take_pending_basis<T0>(&v0, arg0, v1),
            account_id : v1,
        }
    }

    public fun discard_zero_loss(arg0: LossTicket) {
        let LossTicket {
            basis      : v0,
            account_id : _,
        } = arg0;
        assert!(v0 == 0, 13835058527728566273);
    }

    public fun open_staking_sink(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : StakingSink {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg0), arg1);
        let v1 = SinkMintedKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<SinkMintedKey>(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0), v1), 13835339852381552643);
        let v2 = SinkMintedKey{dummy_field: false};
        0x2::dynamic_field::add<SinkMintedKey, bool>(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid_mut(&v0, arg0), v2, true);
        let v3 = StakingSink{id: 0x2::object::new(arg2)};
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg0), 47);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_open_staking_sink_event(&v0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg0), 0x2::object::id<StakingSink>(&v3));
        v3
    }

    public fun release_staker_fee<T0>(arg0: StakerFee<T0>, arg1: &StakingSink) : 0x2::balance::Balance<T0> {
        0x2::object::id<StakingSink>(arg1);
        let StakerFee { balance: v0 } = arg0;
        v0
    }

    public(friend) fun settle_loss_ticket(arg0: LossTicket) : u64 {
        let LossTicket {
            basis      : v0,
            account_id : _,
        } = arg0;
        v0
    }

    public(friend) fun ticket(arg0: u64, arg1: 0x2::object::ID) : LossTicket {
        LossTicket{
            basis      : arg0,
            account_id : arg1,
        }
    }

    public fun withdraw_staker_fees<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config) : StakerFee<T0> {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid<T0>(arg0));
        StakerFee<T0>{balance: 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::take_staker_rewards<T0>(&v0, arg0, arg1)}
    }

    // decompiled from Move bytecode v7
}

