module 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake {
    struct Stake<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        registrations: 0x2::vec_map::VecMap<0x1::type_name::TypeName, Registration>,
    }

    struct Registration has copy, drop, store {
        pool_id: 0x2::object::ID,
        last_claim_index: u256,
    }

    struct StakeCreatedEvent<phantom T0> has copy, drop {
        stake_id: 0x2::object::ID,
        amount: u64,
    }

    struct StakeDestroyedEvent<phantom T0> has copy, drop {
        stake_id: 0x2::object::ID,
        amount: u64,
    }

    public fun balance<T0>(arg0: &Stake<T0>) : &0x2::balance::Balance<T0> {
        &arg0.balance
    }

    public fun value<T0>(arg0: &Stake<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun new<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : Stake<T0> {
        assert!(0x2::balance::value<T0>(&arg0) > 0, 0);
        let v0 = Stake<T0>{
            id            : 0x2::object::new(arg1),
            balance       : arg0,
            registrations : 0x2::vec_map::empty<0x1::type_name::TypeName, Registration>(),
        };
        let v1 = StakeCreatedEvent<T0>{
            stake_id : id<T0>(&v0),
            amount   : value<T0>(&v0),
        };
        0x2::event::emit<StakeCreatedEvent<T0>>(v1);
        v0
    }

    public(friend) fun add_registration<T0>(arg0: &mut Stake<T0>, arg1: 0x1::type_name::TypeName, arg2: Registration) {
        0x2::vec_map::insert<0x1::type_name::TypeName, Registration>(&mut arg0.registrations, arg1, arg2);
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
        assert!(0x2::vec_map::is_empty<0x1::type_name::TypeName, Registration>(&v3), 1);
        0x2::vec_map::destroy_empty<0x1::type_name::TypeName, Registration>(v3);
        let v6 = StakeDestroyedEvent<T0>{
            stake_id : 0x2::object::uid_to_inner(&v5),
            amount   : 0x2::balance::value<T0>(&v4),
        };
        0x2::event::emit<StakeDestroyedEvent<T0>>(v6);
        0x2::object::delete(v5);
        v4
    }

    public fun get_registration<T0>(arg0: &Stake<T0>, arg1: &0x1::type_name::TypeName) : &Registration {
        0x2::vec_map::get<0x1::type_name::TypeName, Registration>(&arg0.registrations, arg1)
    }

    public fun has_registration<T0>(arg0: &Stake<T0>, arg1: &0x1::type_name::TypeName) : bool {
        0x2::vec_map::contains<0x1::type_name::TypeName, Registration>(&arg0.registrations, arg1)
    }

    public fun id<T0>(arg0: &Stake<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun new_registration(arg0: 0x2::object::ID, arg1: u256) : Registration {
        Registration{
            pool_id          : arg0,
            last_claim_index : arg1,
        }
    }

    public fun registration_count<T0>(arg0: &Stake<T0>) : u64 {
        0x2::vec_map::length<0x1::type_name::TypeName, Registration>(&arg0.registrations)
    }

    public fun registration_last_claim_index(arg0: &Registration) : u256 {
        arg0.last_claim_index
    }

    public(friend) fun registration_mut<T0>(arg0: &mut Stake<T0>, arg1: &0x1::type_name::TypeName) : &mut Registration {
        0x2::vec_map::get_mut<0x1::type_name::TypeName, Registration>(&mut arg0.registrations, arg1)
    }

    public fun registration_pool_id(arg0: &Registration) : 0x2::object::ID {
        arg0.pool_id
    }

    public(friend) fun remove_registration<T0>(arg0: &mut Stake<T0>, arg1: &0x1::type_name::TypeName) : Registration {
        let (_, v1) = 0x2::vec_map::remove<0x1::type_name::TypeName, Registration>(&mut arg0.registrations, arg1);
        v1
    }

    public(friend) fun set_last_claim_index(arg0: &mut Registration, arg1: u256) {
        arg0.last_claim_index = arg1;
    }

    // decompiled from Move bytecode v7
}

