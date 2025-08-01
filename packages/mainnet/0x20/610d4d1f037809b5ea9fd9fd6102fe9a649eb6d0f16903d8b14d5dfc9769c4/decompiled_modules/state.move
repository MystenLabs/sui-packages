module 0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::state {
    struct PackagePausedEvent has copy, drop {
        paused_by: address,
        paused_at: u64,
    }

    struct PackageResumedEvent has copy, drop {
        resumed_by: address,
        resumed_at: u64,
    }

    struct State has key {
        id: 0x2::object::UID,
        paused: bool,
    }

    struct STATE has drop {
        dummy_field: bool,
    }

    public(friend) fun assert_not_paused(arg0: &State) {
        assert!(!arg0.paused, 0);
    }

    public(friend) fun assert_paused(arg0: &State) {
        assert!(arg0.paused, 1);
    }

    fun init(arg0: STATE, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<STATE>(&arg0), 2);
        let v0 = State{
            id     : 0x2::object::new(arg1),
            paused : false,
        };
        0x2::transfer::share_object<State>(v0);
    }

    public(friend) fun is_paused(arg0: &State) : bool {
        arg0.paused
    }

    public(friend) entry fun pause(arg0: &0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::admins::Admins, arg1: &mut State, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::admins::assert_is_admin(arg0, 0x2::tx_context::sender(arg3));
        assert_not_paused(arg1);
        arg1.paused = true;
        let v0 = PackagePausedEvent{
            paused_by : 0x2::tx_context::sender(arg3),
            paused_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PackagePausedEvent>(v0);
    }

    public(friend) entry fun resume(arg0: &0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::admins::Admins, arg1: &mut State, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::admins::assert_is_admin(arg0, 0x2::tx_context::sender(arg3));
        assert_paused(arg1);
        arg1.paused = false;
        let v0 = PackageResumedEvent{
            resumed_by : 0x2::tx_context::sender(arg3),
            resumed_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PackageResumedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

