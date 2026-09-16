module 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake {
    struct Stake<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        registrations: 0x2::vec_map::VecMap<0x1::type_name::TypeName, Registration>,
    }

    struct Registration has copy, drop, store {
        pool_id: 0x2::object::ID,
        debt: u256,
    }

    struct StakeCreatedEvent<phantom T0> has copy, drop {
        stake_id: address,
        transaction_sender: address,
        amount: u64,
        registration_count_after: u64,
    }

    struct StakeDestroyedEvent<phantom T0> has copy, drop {
        stake_id: address,
        amount: u64,
        registration_count_before: u64,
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
        let v1 = 0x2::object::id<Stake<T0>>(&v0);
        let v2 = StakeCreatedEvent<T0>{
            stake_id                 : 0x2::object::id_to_address(&v1),
            transaction_sender       : 0x2::tx_context::sender(arg1),
            amount                   : value<T0>(&v0),
            registration_count_after : registration_count<T0>(&v0),
        };
        0x2::event::emit<StakeCreatedEvent<T0>>(v2);
        v0
    }

    public(friend) fun add_debt(arg0: &mut Registration, arg1: u256) {
        arg0.debt = arg0.debt + arg1;
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
        let v6 = 0x2::object::uid_to_inner(&v5);
        0x2::vec_map::destroy_empty<0x1::type_name::TypeName, Registration>(v3);
        0x2::object::delete(v5);
        let v7 = StakeDestroyedEvent<T0>{
            stake_id                  : 0x2::object::id_to_address(&v6),
            amount                    : 0x2::balance::value<T0>(&v4),
            registration_count_before : 0x2::vec_map::length<0x1::type_name::TypeName, Registration>(&v3),
        };
        0x2::event::emit<StakeDestroyedEvent<T0>>(v7);
        v4
    }

    public fun get_registration<T0>(arg0: &Stake<T0>, arg1: &0x1::type_name::TypeName) : &Registration {
        0x2::vec_map::get<0x1::type_name::TypeName, Registration>(&arg0.registrations, arg1)
    }

    public fun has_registration<T0>(arg0: &Stake<T0>, arg1: &0x1::type_name::TypeName) : bool {
        0x2::vec_map::contains<0x1::type_name::TypeName, Registration>(&arg0.registrations, arg1)
    }

    public(friend) fun new_registration(arg0: 0x2::object::ID, arg1: u256) : Registration {
        Registration{
            pool_id : arg0,
            debt    : arg1,
        }
    }

    public fun registration_count<T0>(arg0: &Stake<T0>) : u64 {
        0x2::vec_map::length<0x1::type_name::TypeName, Registration>(&arg0.registrations)
    }

    public fun registration_debt(arg0: &Registration) : u256 {
        arg0.debt
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

    // decompiled from Move bytecode v7
}

