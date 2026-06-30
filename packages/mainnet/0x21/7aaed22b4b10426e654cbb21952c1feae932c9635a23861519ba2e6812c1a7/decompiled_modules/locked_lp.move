module 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::locked_lp {
    struct LockedPhronisPosition<phantom T0> has key {
        id: 0x2::object::UID,
        launch_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        locked_at_ms: u64,
        position: 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::phronis_amm::Position<T0, 0x2::sui::SUI>,
    }

    fun build_pool_name(arg0: &0x1::string::String) : 0x1::string::String {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, b" / SUI");
        0x1::string::utf8(v0)
    }

    public(friend) fun do_collect<T0>(arg0: &mut 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::phronis_amm::Pool<T0, 0x2::sui::SUI>, arg1: &mut LockedPhronisPosition<T0>, arg2: &mut 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::Launch<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.launch_id == 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::id<T0>(arg2), 900);
        assert!(0x2::object::id<0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::phronis_amm::Pool<T0, 0x2::sui::SUI>>(arg0) == arg1.pool_id, 901);
        let (v0, v1) = 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::phronis_amm::claim_fees<T0, 0x2::sui::SUI>(arg0, &mut arg1.position, arg3);
        let v2 = v1;
        let v3 = v0;
        if (0x2::coin::value<T0>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::creator<T0>(arg2));
        } else {
            0x2::coin::destroy_zero<T0>(v3);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&v2) > 0) {
            0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::receive_swap_fees<T0>(arg2, v2, arg3);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v2);
        };
    }

    public(friend) fun do_settle<T0>(arg0: &mut 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::phronis_amm::PhronisRegistry, arg1: &mut 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::Launch<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::take_pool_reserves<T0>(arg1, arg3);
        let v2 = 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::phronis_amm::create_pool<T0, 0x2::sui::SUI>(arg0, v1, v0, 100, build_pool_name(0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::name<T0>(arg1)), arg2, arg3);
        let v3 = 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::phronis_amm::position_pool_id<T0, 0x2::sui::SUI>(&v2);
        let v4 = 0x2::object::id<0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::phronis_amm::Position<T0, 0x2::sui::SUI>>(&v2);
        let v5 = 0x2::object::new(arg3);
        0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::record_pool_activation<T0>(arg1, v3, v4, 0x2::object::uid_to_inner(&v5), arg2);
        let v6 = LockedPhronisPosition<T0>{
            id           : v5,
            launch_id    : 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::id<T0>(arg1),
            pool_id      : v3,
            position_id  : v4,
            locked_at_ms : 0x2::clock::timestamp_ms(arg2),
            position     : v2,
        };
        0x2::transfer::share_object<LockedPhronisPosition<T0>>(v6);
    }

    public fun launch_id<T0>(arg0: &LockedPhronisPosition<T0>) : 0x2::object::ID {
        arg0.launch_id
    }

    public fun locked_at_ms<T0>(arg0: &LockedPhronisPosition<T0>) : u64 {
        arg0.locked_at_ms
    }

    public fun pool_id<T0>(arg0: &LockedPhronisPosition<T0>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun position_id<T0>(arg0: &LockedPhronisPosition<T0>) : 0x2::object::ID {
        arg0.position_id
    }

    // decompiled from Move bytecode v7
}

