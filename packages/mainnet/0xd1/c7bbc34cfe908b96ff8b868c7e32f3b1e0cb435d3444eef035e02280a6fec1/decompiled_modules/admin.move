module 0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun add_reward<T0, T1>(arg0: &AdminCap, arg1: &0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::admin::AdminCap, arg2: &mut 0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::farm::Farm<T0>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: bool, arg6: &0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::version::Version, arg7: &0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::version::Version, arg8: &0x2::clock::Clock) {
        0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::version::assert_supported_version(arg6);
        0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::admin::add_reward<T0, T1>(arg1, 0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::farm::rewards_farm_mut<T0>(arg2), arg3, arg4, arg5, arg7, arg8);
    }

    public fun update_reward<T0, T1>(arg0: &AdminCap, arg1: &0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::admin::AdminCap, arg2: &mut 0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::farm::Farm<T0>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: bool, arg6: &0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::version::Version, arg7: &0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::version::Version, arg8: &0x2::clock::Clock) {
        0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::version::assert_supported_version(arg6);
        0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::admin::update_reward<T0, T1>(arg1, 0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::farm::rewards_farm_mut<T0>(arg2), arg3, arg4, arg5, arg7, arg8);
    }

    public fun withdraw_unharvested<T0, T1>(arg0: &AdminCap, arg1: &0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::admin::AdminCap, arg2: &mut 0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::farm::Farm<T0>, arg3: &0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::version::Version, arg4: &0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::version::Version, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::version::assert_supported_version(arg3);
        0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::admin::withdraw_unharvested<T0, T1>(arg1, 0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::farm::rewards_farm_mut<T0>(arg2), arg4, arg5)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun initialize_farm<T0>(arg0: &AdminCap, arg1: 0x2::balance::Balance<T0>, arg2: &0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::admin::AdminCap, arg3: &0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::version::Version, arg4: &0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::version::Version, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::version::assert_supported_version(arg3);
        0x2::transfer::public_share_object<0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::farm::Farm<T0>>(0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::farm::initialize<T0>(0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::admin::initialize_farm_with_return<T0>(arg2, arg1, arg4, arg5, arg6), arg5, arg6));
    }

    public fun update_points<T0>(arg0: &AdminCap, arg1: &mut 0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::farm::Farm<T0>, arg2: u64, arg3: &0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::version::Version, arg4: &0x2::clock::Clock) {
        0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::version::assert_supported_version(arg3);
        0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::farm::update_points<T0>(arg1, arg2, arg4);
    }

    // decompiled from Move bytecode v6
}

