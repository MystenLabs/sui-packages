module 0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun add_reward<T0, T1>(arg0: &AdminCap, arg1: &0x1f1c306ae99ff9574eda4106b230f94923b4f9b2f6eda244474506a3df126e8d::admin::AdminCap, arg2: &mut 0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::farm::Farm<T0>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: bool, arg6: &0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::version::Version, arg7: &0x1f1c306ae99ff9574eda4106b230f94923b4f9b2f6eda244474506a3df126e8d::version::Version, arg8: &0x2::clock::Clock) {
        0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::version::assert_supported_version(arg6);
        0x1f1c306ae99ff9574eda4106b230f94923b4f9b2f6eda244474506a3df126e8d::admin::add_reward<T0, T1>(arg1, 0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::farm::rewards_farm_mut<T0>(arg2), arg3, arg4, arg5, arg7, arg8);
    }

    public fun update_reward<T0, T1>(arg0: &AdminCap, arg1: &0x1f1c306ae99ff9574eda4106b230f94923b4f9b2f6eda244474506a3df126e8d::admin::AdminCap, arg2: &mut 0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::farm::Farm<T0>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: bool, arg6: &0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::version::Version, arg7: &0x1f1c306ae99ff9574eda4106b230f94923b4f9b2f6eda244474506a3df126e8d::version::Version, arg8: &0x2::clock::Clock) {
        0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::version::assert_supported_version(arg6);
        0x1f1c306ae99ff9574eda4106b230f94923b4f9b2f6eda244474506a3df126e8d::admin::update_reward<T0, T1>(arg1, 0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::farm::rewards_farm_mut<T0>(arg2), arg3, arg4, arg5, arg7, arg8);
    }

    public fun withdraw_unharvested<T0, T1>(arg0: &AdminCap, arg1: &0x1f1c306ae99ff9574eda4106b230f94923b4f9b2f6eda244474506a3df126e8d::admin::AdminCap, arg2: &mut 0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::farm::Farm<T0>, arg3: &0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::version::Version, arg4: &0x1f1c306ae99ff9574eda4106b230f94923b4f9b2f6eda244474506a3df126e8d::version::Version, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::version::assert_supported_version(arg3);
        0x1f1c306ae99ff9574eda4106b230f94923b4f9b2f6eda244474506a3df126e8d::admin::withdraw_unharvested<T0, T1>(arg1, 0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::farm::rewards_farm_mut<T0>(arg2), arg4, arg5)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun initialize_farm<T0>(arg0: &AdminCap, arg1: 0x2::balance::Balance<T0>, arg2: &0x1f1c306ae99ff9574eda4106b230f94923b4f9b2f6eda244474506a3df126e8d::admin::AdminCap, arg3: &0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::version::Version, arg4: &0x1f1c306ae99ff9574eda4106b230f94923b4f9b2f6eda244474506a3df126e8d::version::Version, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::version::assert_supported_version(arg3);
        0x2::transfer::public_share_object<0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::farm::Farm<T0>>(0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::farm::initialize<T0>(0x1f1c306ae99ff9574eda4106b230f94923b4f9b2f6eda244474506a3df126e8d::admin::initialize_farm_with_return<T0>(arg2, arg1, arg4, arg5, arg6), arg5, arg6));
    }

    public fun update_points<T0>(arg0: &AdminCap, arg1: &mut 0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::farm::Farm<T0>, arg2: u64, arg3: &0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::version::Version, arg4: &0x2::clock::Clock) {
        0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::version::assert_supported_version(arg3);
        0x3bfb4c507fa6f0fdf923a65a7f6aa90693f85364b520f2e394c1270ddf4fa054::farm::update_points<T0>(arg1, arg2, arg4);
    }

    // decompiled from Move bytecode v6
}

