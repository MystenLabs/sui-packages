module 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::fees {
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

    public fun claim_pending_ticket<T0>(arg0: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::Exchange<T0>, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>, arg2: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::AccountCap) : LossTicket {
        let v0 = 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::auth::issue(0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::uid<T0>(arg0));
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::assert_version<T0>(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::assert_cap<T0>(arg1, arg2);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::assert_exchange<T0>(arg1, 0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::Exchange<T0>>(arg0));
        let v1 = 0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>>(arg1);
        LossTicket{
            basis      : 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::take_pending_basis<T0>(&v0, arg0, v1),
            account_id : v1,
        }
    }

    public fun discard_zero_loss(arg0: LossTicket) {
        let LossTicket {
            basis      : v0,
            account_id : _,
        } = arg0;
        assert!(v0 == 0, 13835058523433598977);
    }

    public fun open_staking_sink(arg0: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : StakingSink {
        let v0 = 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::auth::issue(0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::uid(arg0));
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_admin(0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config>(arg0), arg1);
        let v1 = SinkMintedKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<SinkMintedKey>(0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::uid(arg0), v1), 13835339848086585347);
        let v2 = SinkMintedKey{dummy_field: false};
        0x2::dynamic_field::add<SinkMintedKey, bool>(0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::uid_mut(&v0, arg0), v2, true);
        let v3 = StakingSink{id: 0x2::object::new(arg2)};
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_action(&v0, 0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config>(arg0), 47);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_open_staking_sink_event(&v0, 0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config>(arg0), 0x2::object::id<StakingSink>(&v3));
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

    public fun withdraw_staker_fees<T0>(arg0: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::Exchange<T0>, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config) : StakerFee<T0> {
        let v0 = 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::auth::issue(0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::uid<T0>(arg0));
        StakerFee<T0>{balance: 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::take_staker_rewards<T0>(&v0, arg0, arg1)}
    }

    // decompiled from Move bytecode v7
}

