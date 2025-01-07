module 0x70874e01aaaddd65da1940a5dc0432f6158b6c73190256f413341de589893734::royalty_share {
    struct Shares has store {
        inner: 0x2::vec_map::VecMap<address, u16>,
    }

    public fun borrow(arg0: &Shares) : &0x2::vec_map::VecMap<address, u16> {
        &arg0.inner
    }

    public fun contains(arg0: &Shares, arg1: &address) : bool {
        0x2::vec_map::contains<address, u16>(&arg0.inner, arg1)
    }

    fun assert_total_shares(arg0: &0x2::vec_map::VecMap<address, u16>) {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<address, u16>(arg0)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<address, u16>(arg0, v1);
            v0 = v0 + *v3;
            v1 = v1 + 1;
        };
        assert!(v0 == 10000, 0);
    }

    public fun borrow_share(arg0: &Shares, arg1: &address) : &u16 {
        assert!(contains(arg0, arg1), 1);
        0x2::vec_map::get<address, u16>(&arg0.inner, arg1)
    }

    fun borrow_share_mut(arg0: &mut Shares, arg1: &address) : &mut u16 {
        assert!(contains(arg0, arg1), 1);
        0x2::vec_map::get_mut<address, u16>(&mut arg0.inner, arg1)
    }

    public fun distribute(arg0: &Shares, arg1: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        distribute_inner(&arg0.inner, arg1, arg2)
    }

    fun distribute_inner(arg0: &0x2::vec_map::VecMap<address, u16>, arg1: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x2::vec_map::size<address, u16>(arg0)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<address, u16>(arg0, v0);
            let v4 = (((0x2::balance::value<0x2::sui::SUI>(arg1) as u128) * (*v3 as u128) / (10000 as u128)) as u64);
            if (v4 != 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(arg1, v4), arg2), *v2);
            };
            v1 = v1 + v4;
            v0 = v0 + 1;
        };
        v1
    }

    public fun from_address(arg0: address) : Shares {
        let v0 = 0x2::vec_map::empty<address, u16>();
        0x2::vec_map::insert<address, u16>(&mut v0, arg0, 10000);
        from_shares(v0)
    }

    public fun from_shares(arg0: 0x2::vec_map::VecMap<address, u16>) : Shares {
        assert_total_shares(&arg0);
        Shares{inner: arg0}
    }

    public fun transfer_partial_share(arg0: &mut Shares, arg1: address, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = borrow_share_mut(arg0, &v0);
        assert!(*v1 >= arg2, 2);
        *v1 = *v1 - arg2;
        if (*v1 == 0) {
            let (_, _) = 0x2::vec_map::remove<address, u16>(&mut arg0.inner, &v0);
        };
        if (contains(arg0, &arg1)) {
            let v4 = borrow_share_mut(arg0, &arg1);
            *v4 = *v4 + arg2;
        } else {
            0x2::vec_map::insert<address, u16>(&mut arg0.inner, arg1, arg2);
        };
    }

    public fun transfer_share(arg0: &mut Shares, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let (_, v2) = 0x2::vec_map::remove<address, u16>(&mut arg0.inner, &v0);
        if (contains(arg0, &arg1)) {
            let v3 = borrow_share_mut(arg0, &arg1);
            *v3 = *v3 + v2;
        } else {
            0x2::vec_map::insert<address, u16>(&mut arg0.inner, arg1, v2);
        };
    }

    // decompiled from Move bytecode v6
}

