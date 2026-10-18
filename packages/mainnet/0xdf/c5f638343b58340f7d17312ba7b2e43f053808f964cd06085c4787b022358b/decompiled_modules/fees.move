module 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::fees {
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

    public fun claim_pending_ticket<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::AccountCap) : LossTicket {
        let v0 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::auth::issue(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::uid<T0>(arg0));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::assert_version<T0>(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::assert_cap<T0>(arg1, arg2);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::assert_exchange<T0>(arg1, 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>>(arg0));
        let v1 = 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>>(arg1);
        LossTicket{
            basis      : 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::take_pending_basis<T0>(&v0, arg0, v1),
            account_id : v1,
        }
    }

    public fun discard_zero_loss(arg0: LossTicket) {
        let LossTicket {
            basis      : v0,
            account_id : _,
        } = arg0;
        assert!(v0 == 0, 13835058519138631681);
    }

    public fun open_staking_sink(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : StakingSink {
        let v0 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::auth::issue(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::uid(arg0));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config>(arg0), arg1);
        let v1 = SinkMintedKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<SinkMintedKey>(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::uid(arg0), v1), 13835339843791618051);
        let v2 = SinkMintedKey{dummy_field: false};
        0x2::dynamic_field::add<SinkMintedKey, bool>(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::uid_mut(&v0, arg0), v2, true);
        let v3 = StakingSink{id: 0x2::object::new(arg2)};
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v0, 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config>(arg0), 47);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_open_staking_sink_event(&v0, 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config>(arg0), 0x2::object::id<StakingSink>(&v3));
        v3
    }

    public fun release_staker_fee<T0>(arg0: StakerFee<T0>, arg1: &StakingSink) : 0x2::balance::Balance<T0> {
        0x2::object::id<StakingSink>(arg1);
        let StakerFee { balance: v0 } = arg0;
        v0
    }

    public fun settle_loss_ticket(arg0: LossTicket) : u64 {
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

    public fun withdraw_staker_fees<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>) : StakerFee<T0> {
        let v0 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::auth::issue(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::uid<T0>(arg0));
        StakerFee<T0>{balance: 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::take_staker_rewards<T0>(&v0, arg0)}
    }

    // decompiled from Move bytecode v7
}

