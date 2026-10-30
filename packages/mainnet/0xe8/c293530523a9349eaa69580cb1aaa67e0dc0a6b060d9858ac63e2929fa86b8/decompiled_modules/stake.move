module 0xe8c293530523a9349eaa69580cb1aaa67e0dc0a6b060d9858ac63e2929fa86b8::stake {
    struct Stake<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        registrations: 0x2::vec_map::VecMap<0x2::object::ID, u256>,
    }

    struct StakeCreatedEvent<phantom T0> has copy, drop {
        stake_id: 0x2::object::ID,
        shares: u64,
    }

    struct StakeDestroyedEvent<phantom T0> has copy, drop {
        stake_id: 0x2::object::ID,
        shares: u64,
    }

    public fun value<T0>(arg0: &Stake<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun new<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : Stake<T0> {
        let v0 = 0x2::balance::value<T0>(&arg0);
        assert!(v0 > 0, 0);
        let v1 = Stake<T0>{
            id            : 0x2::object::new(arg1),
            balance       : arg0,
            registrations : 0x2::vec_map::empty<0x2::object::ID, u256>(),
        };
        let v2 = StakeCreatedEvent<T0>{
            stake_id : 0x2::object::uid_to_inner(&v1.id),
            shares   : v0,
        };
        0x2::event::emit<StakeCreatedEvent<T0>>(v2);
        v1
    }

    public fun destroy<T0>(arg0: Stake<T0>) : 0x2::balance::Balance<T0> {
        let Stake {
            id            : v0,
            balance       : v1,
            registrations : v2,
        } = arg0;
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        assert!(0x2::vec_map::is_empty<0x2::object::ID, u256>(&v3), 1);
        let v6 = StakeDestroyedEvent<T0>{
            stake_id : 0x2::object::uid_to_inner(&v5),
            shares   : 0x2::balance::value<T0>(&v4),
        };
        0x2::event::emit<StakeDestroyedEvent<T0>>(v6);
        0x2::object::delete(v5);
        v4
    }

    public fun has_registration<T0>(arg0: &Stake<T0>, arg1: 0x2::object::ID) : bool {
        0x2::vec_map::contains<0x2::object::ID, u256>(&arg0.registrations, &arg1)
    }

    public fun pool_ids<T0>(arg0: &Stake<T0>) : vector<0x2::object::ID> {
        0x2::vec_map::keys<0x2::object::ID, u256>(&arg0.registrations)
    }

    public(friend) fun registrations<T0>(arg0: &Stake<T0>) : &0x2::vec_map::VecMap<0x2::object::ID, u256> {
        &arg0.registrations
    }

    public(friend) fun registrations_mut<T0>(arg0: &mut Stake<T0>) : &mut 0x2::vec_map::VecMap<0x2::object::ID, u256> {
        &mut arg0.registrations
    }

    // decompiled from Move bytecode v7
}

