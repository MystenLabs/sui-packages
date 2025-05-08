module 0x597d9db841c856dc5e5b5e6db3252841a83890166460233ac644ab924f31d0aa::fukai {
    struct FUKAI has drop {
        dummy_field: bool,
    }

    struct Fukai has store, key {
        id: 0x2::object::UID,
        action_badges: 0x2::vec_map::VecMap<0x2::object::ID, 0x597d9db841c856dc5e5b5e6db3252841a83890166460233ac644ab924f31d0aa::action_badge::ActionBadge>,
        fragments: vector<0x597d9db841c856dc5e5b5e6db3252841a83890166460233ac644ab924f31d0aa::fragment::Fragment>,
    }

    struct FukaiCreatedEvent has copy, drop, store {
        fukai_id: 0x2::object::ID,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : Fukai {
        let v0 = Fukai{
            id            : 0x2::object::new(arg0),
            action_badges : 0x2::vec_map::empty<0x2::object::ID, 0x597d9db841c856dc5e5b5e6db3252841a83890166460233ac644ab924f31d0aa::action_badge::ActionBadge>(),
            fragments     : 0x1::vector::empty<0x597d9db841c856dc5e5b5e6db3252841a83890166460233ac644ab924f31d0aa::fragment::Fragment>(),
        };
        let v1 = FukaiCreatedEvent{fukai_id: 0x2::object::id<Fukai>(&v0)};
        0x2::event::emit<FukaiCreatedEvent>(v1);
        v0
    }

    public fun action_badges(arg0: &Fukai) : &0x2::vec_map::VecMap<0x2::object::ID, 0x597d9db841c856dc5e5b5e6db3252841a83890166460233ac644ab924f31d0aa::action_badge::ActionBadge> {
        &arg0.action_badges
    }

    public fun add_fragment(arg0: &mut Fukai, arg1: vector<u8>, arg2: vector<u8>) {
        0x1::vector::push_back<0x597d9db841c856dc5e5b5e6db3252841a83890166460233ac644ab924f31d0aa::fragment::Fragment>(&mut arg0.fragments, 0x597d9db841c856dc5e5b5e6db3252841a83890166460233ac644ab924f31d0aa::fragment::new((0x1::vector::length<0x597d9db841c856dc5e5b5e6db3252841a83890166460233ac644ab924f31d0aa::fragment::Fragment>(&arg0.fragments) as u8), arg1, arg2));
    }

    public fun decrypt_fragment(arg0: &mut Fukai, arg1: u64, arg2: u256) {
        0x597d9db841c856dc5e5b5e6db3252841a83890166460233ac644ab924f31d0aa::fragment::decrypt(0x1::vector::borrow_mut<0x597d9db841c856dc5e5b5e6db3252841a83890166460233ac644ab924f31d0aa::fragment::Fragment>(&mut arg0.fragments, (arg1 as u64)), 0x2::object::id<Fukai>(arg0), arg2);
    }

    fun init(arg0: FUKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<FUKAI>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::display::Display<Fukai>>(0x2::display::new<Fukai>(&v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &Fukai) {
        let v0 = 0x2::bcs::new(arg0);
        assert!(0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0)) == 0x2::object::id<Fukai>(arg1), 2);
        0x597d9db841c856dc5e5b5e6db3252841a83890166460233ac644ab924f31d0aa::fragment::assert_is_unlocked(0x1::vector::borrow<0x597d9db841c856dc5e5b5e6db3252841a83890166460233ac644ab924f31d0aa::fragment::Fragment>(&arg1.fragments, (0x2::bcs::peel_u8(&mut v0) as u64)));
    }

    public fun unlock_fragment(arg0: &mut Fukai, arg1: 0x597d9db841c856dc5e5b5e6db3252841a83890166460233ac644ab924f31d0aa::fragment_key::FragmentKey, arg2: u64, arg3: &0x597d9db841c856dc5e5b5e6db3252841a83890166460233ac644ab924f31d0aa::action::Action, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x597d9db841c856dc5e5b5e6db3252841a83890166460233ac644ab924f31d0aa::fragment_key::action_id(&arg1) == 0x2::object::id<0x597d9db841c856dc5e5b5e6db3252841a83890166460233ac644ab924f31d0aa::action::Action>(arg3), 3);
        0x2::vec_map::insert<0x2::object::ID, 0x597d9db841c856dc5e5b5e6db3252841a83890166460233ac644ab924f31d0aa::action_badge::ActionBadge>(&mut arg0.action_badges, 0x597d9db841c856dc5e5b5e6db3252841a83890166460233ac644ab924f31d0aa::fragment_key::action_id(&arg1), 0x597d9db841c856dc5e5b5e6db3252841a83890166460233ac644ab924f31d0aa::action_badge::new(arg3, arg4, arg5));
        0x597d9db841c856dc5e5b5e6db3252841a83890166460233ac644ab924f31d0aa::fragment::unlock(0x1::vector::borrow_mut<0x597d9db841c856dc5e5b5e6db3252841a83890166460233ac644ab924f31d0aa::fragment::Fragment>(&mut arg0.fragments, (arg2 as u64)), arg1);
    }

    // decompiled from Move bytecode v6
}

