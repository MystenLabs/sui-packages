module 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile {
    struct Profile<phantom T0> has store {
        points: 0x2::balance::Balance<T0>,
        stakes: 0x2::vec_map::VecMap<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::Stake>,
    }

    public fun new<T0>() : Profile<T0> {
        Profile<T0>{
            points : 0x2::balance::zero<T0>(),
            stakes : 0x2::vec_map::empty<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::Stake>(),
        }
    }

    public fun points<T0>(arg0: &Profile<T0>) : &0x2::balance::Balance<T0> {
        &arg0.points
    }

    public fun points_mut<T0>(arg0: &mut Profile<T0>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.points
    }

    public fun stakes<T0>(arg0: &Profile<T0>) : &0x2::vec_map::VecMap<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::Stake> {
        &arg0.stakes
    }

    public fun stakes_mut<T0>(arg0: &mut Profile<T0>) : &mut 0x2::vec_map::VecMap<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::Stake> {
        &mut arg0.stakes
    }

    // decompiled from Move bytecode v6
}

