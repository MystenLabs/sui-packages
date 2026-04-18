module 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::revenue {
    public(friend) fun collect_treasury_fee(arg0: 0x2::coin::Coin<0x2::sui::SUI>) : 0x2::balance::Balance<0x2::sui::SUI> {
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
            return 0x2::balance::zero<0x2::sui::SUI>()
        };
        0x2::coin::into_balance<0x2::sui::SUI>(arg0)
    }

    public(friend) fun deposit_revenue(arg0: &mut 0x2::object::UID, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<0x2::sui::SUI>) {
        if (0x2::balance::value<0x2::sui::SUI>(&arg1) == 0) {
            return (arg1, 0x2::balance::zero<0x2::sui::SUI>())
        };
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1);
        let v1 = 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::treasury_fee_for_price(v0);
        let v2 = 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::hierarchy_pool_for_price(v0);
        let v3 = 0x2::balance::zero<0x2::sui::SUI>();
        if (v1 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut v3, 0x2::balance::split<0x2::sui::SUI>(&mut arg1, v1));
        };
        if (v2 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut v3, route_hierarchy_pool(arg0, arg2, 0x2::balance::split<0x2::sui::SUI>(&mut arg1, v2), arg3, arg4));
        };
        (arg1, v3)
    }

    public(friend) fun route_hierarchy_pool(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: u64, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        if (0x2::balance::value<0x2::sui::SUI>(&arg2) == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg2);
            return 0x2::balance::zero<0x2::sui::SUI>()
        };
        if (arg3 >= 5 || !0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::tax::tax_is_initialized(arg0)) {
            return arg2
        };
        0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::tax::tax_accrue(arg0, arg1, arg2, arg3, (arg3 as u8), arg4)
    }

    public(friend) fun route_mark_payment(arg0: &mut 0x2::object::UID, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: 0x2::object::ID, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        0x2::balance::join<0x2::sui::SUI>(&mut v0, collect_treasury_fee(0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg2, arg6)));
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
            return v0
        };
        let (v1, v2) = deposit_revenue(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(arg1), arg3, arg4, arg6);
        let v3 = v1;
        0x2::balance::join<0x2::sui::SUI>(&mut v0, v2);
        if (0x2::balance::value<0x2::sui::SUI>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg6), arg5);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v3);
        };
        v0
    }

    // decompiled from Move bytecode v7
}

