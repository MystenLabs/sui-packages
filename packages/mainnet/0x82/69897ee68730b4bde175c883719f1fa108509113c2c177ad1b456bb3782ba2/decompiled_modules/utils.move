module 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::utils {
    public(friend) fun assert_auth<T0>(arg0: &0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_manager::RewardsManager<T0>, arg1: &0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::RewardsAuth, arg2: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg3: 0x1::option::Option<0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::timelock_cap::TimelockTicket>, arg4: &0x2::tx_context::TxContext) {
        assert_bound<T0>(arg0, arg2);
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::assert_auth(arg1, arg3, arg4);
    }

    public(friend) fun assert_bound<T0>(arg0: &0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_manager::RewardsManager<T0>, arg1: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>) {
        assert!(0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_manager::state_id<T0>(arg0) == 0x2::object::id<0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>>(arg1), 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::errors::invalid_params());
    }

    public(friend) fun require_schedule<T0>(arg0: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg1: u64) : 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::RewardsSchedule {
        let v0 = 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::rewards_schedule<T0>(arg0);
        assert!(0x1::option::is_some<0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::RewardsSchedule>(&v0), arg1);
        0x1::option::destroy_some<0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::RewardsSchedule>(v0)
    }

    public(friend) fun write<T0>(arg0: &0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_manager::RewardsManager<T0>, arg1: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::registry::LendingRegistry, arg2: &mut 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg3: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg4: 0x1::option::Option<0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::RewardsSchedule>, arg5: &0x2::clock::Clock) {
        0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::admin::set_rewards_schedule<T0>(arg1, 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_manager::borrow_cap<T0>(arg0), arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v7
}

