module 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::pending {
    struct PendingLaunch<phantom T0> has key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<T0>,
        metadata_cap: 0x2::coin_registry::MetadataCap<T0>,
        creator: address,
    }

    public(friend) fun assert_can_launch<T0>(arg0: &PendingLaunch<T0>, arg1: address) {
        assert!(arg1 == arg0.creator, 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::errors::not_creator());
        assert!(0x2::coin::total_supply<T0>(&arg0.treasury) == 0, 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::errors::non_zero_supply());
    }

    public fun cancel_pending<T0>(arg0: &0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::config::AdminCap, arg1: &mut 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::config::Config, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: PendingLaunch<T0>) {
        let PendingLaunch {
            id           : v0,
            treasury     : v1,
            metadata_cap : v2,
            creator      : v3,
        } = arg3;
        0x2::object::delete(v0);
        0x2::coin_registry::delete_metadata_cap<T0>(arg2, v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T0>>(v1);
        0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::config::clear_open_slot(arg1, v3);
        0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::events::emit_pending_launch_cancelled(v3);
    }

    public fun creator<T0>(arg0: &PendingLaunch<T0>) : address {
        arg0.creator
    }

    public fun register<T0>(arg0: &0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::config::AdminCap, arg1: &mut 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::config::Config, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin_registry::MetadataCap<T0>, arg4: 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::config::LaunchRequest, arg5: &mut 0x2::tx_context::TxContext) {
        0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::config::assert_not_paused(arg1);
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::errors::non_zero_supply());
        assert!(0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::config::has_open_slot(arg1, 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::config::request_creator(&arg4)), 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::errors::open_slot_missing());
        let v0 = 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::config::consume_request(arg4);
        let v1 = PendingLaunch<T0>{
            id           : 0x2::object::new(arg5),
            treasury     : arg2,
            metadata_cap : arg3,
            creator      : v0,
        };
        0x2::transfer::share_object<PendingLaunch<T0>>(v1);
        0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::events::emit_token_registered(v0, 0x2::object::id<PendingLaunch<T0>>(&v1));
    }

    public(friend) fun take_caps<T0>(arg0: PendingLaunch<T0>) : (0x2::coin::TreasuryCap<T0>, 0x2::coin_registry::MetadataCap<T0>, address) {
        let PendingLaunch {
            id           : v0,
            treasury     : v1,
            metadata_cap : v2,
            creator      : v3,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v2, v3)
    }

    // decompiled from Move bytecode v7
}

