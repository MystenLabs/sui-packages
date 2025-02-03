module 0xce466e4a54bec4a2dc34dc6f19b6a371947f4aa930ca5318e71ddcdb46789da4::royalty {
    struct RoyaltyDomain has store {
        strategies: 0x2::vec_set::VecSet<0x2::object::ID>,
        aggregations: 0x2::object::UID,
        royalty_shares_bps: 0x2::vec_map::VecMap<address, u16>,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    public fun borrow_domain_mut(arg0: &mut 0x2::object::UID) : &mut RoyaltyDomain {
        assert_royalty(arg0);
        0x2::dynamic_field::borrow_mut<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<RoyaltyDomain>, RoyaltyDomain>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<RoyaltyDomain>())
    }

    public entry fun add_collection_share<T0>(arg0: &mut 0xce466e4a54bec4a2dc34dc6f19b6a371947f4aa930ca5318e71ddcdb46789da4::collection::Collection<T0>, arg1: address, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let v1 = 0xce466e4a54bec4a2dc34dc6f19b6a371947f4aa930ca5318e71ddcdb46789da4::collection::borrow_domain_mut<T0, RoyaltyDomain>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<RoyaltyDomain, Witness>(v0), arg0);
        add_share(v1, arg1, arg2, arg3);
    }

    public fun add_domain(arg0: &mut 0x2::object::UID, arg1: RoyaltyDomain) {
        assert_no_royalty(arg0);
        0x2::dynamic_field::add<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<RoyaltyDomain>, RoyaltyDomain>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<RoyaltyDomain>(), arg1);
    }

    public fun add_share(arg0: &mut RoyaltyDomain, arg1: address, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = borrow_share_mut(arg0, &v0);
        assert!(*v1 >= arg2, 5);
        *v1 = *v1 - arg2;
        if (*v1 == 0) {
            let (_, _) = 0x2::vec_map::remove<address, u16>(&mut arg0.royalty_shares_bps, &arg1);
        };
        if (contains_share(arg0, &arg1)) {
            let v4 = borrow_share_mut(arg0, &arg1);
            *v4 = *v4 + arg2;
        } else {
            0x2::vec_map::insert<address, u16>(&mut arg0.royalty_shares_bps, arg1, arg2);
        };
    }

    public fun add_share_to_empty(arg0: &mut RoyaltyDomain, arg1: address) {
        assert_empty(arg0);
        let v0 = 0x2::vec_map::empty<address, u16>();
        0x2::vec_map::insert<address, u16>(&mut v0, arg1, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::bps());
        arg0.royalty_shares_bps = v0;
    }

    public fun add_shares_to_empty(arg0: &mut RoyaltyDomain, arg1: 0x2::vec_map::VecMap<address, u16>) {
        assert_empty(arg0);
        assert_total_shares(&arg1);
        arg0.royalty_shares_bps = arg1;
    }

    public fun add_strategy(arg0: &mut RoyaltyDomain, arg1: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.strategies, arg1);
    }

    fun assert_empty(arg0: &RoyaltyDomain) {
        assert!(!contains_shares(arg0), 4);
    }

    public fun assert_no_royalty(arg0: &0x2::object::UID) {
        assert!(!has_domain(arg0), 1);
    }

    public fun assert_royalty(arg0: &0x2::object::UID) {
        assert!(has_domain(arg0), 2);
    }

    fun assert_total_shares(arg0: &0x2::vec_map::VecMap<address, u16>) {
        let v0 = 0;
        if (0x2::vec_map::is_empty<address, u16>(arg0)) {
            return
        };
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<address, u16>(arg0)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<address, u16>(arg0, v1);
            v0 = v0 + *v3;
            v1 = v1 + 1;
        };
        assert!(v0 == 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::bps(), 6);
    }

    public fun borrow_domain(arg0: &0x2::object::UID) : &RoyaltyDomain {
        assert_royalty(arg0);
        0x2::dynamic_field::borrow<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<RoyaltyDomain>, RoyaltyDomain>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<RoyaltyDomain>())
    }

    public fun borrow_share(arg0: &RoyaltyDomain, arg1: &address) : &u16 {
        assert!(0x2::vec_map::contains<address, u16>(&arg0.royalty_shares_bps, arg1), 3);
        0x2::vec_map::get<address, u16>(&arg0.royalty_shares_bps, arg1)
    }

    fun borrow_share_mut(arg0: &mut RoyaltyDomain, arg1: &address) : &mut u16 {
        assert!(0x2::vec_map::contains<address, u16>(&arg0.royalty_shares_bps, arg1), 3);
        0x2::vec_map::get_mut<address, u16>(&mut arg0.royalty_shares_bps, arg1)
    }

    public fun borrow_shares(arg0: &RoyaltyDomain) : &0x2::vec_map::VecMap<address, u16> {
        &arg0.royalty_shares_bps
    }

    public fun collect_royalty<T0, T1>(arg0: &mut 0xce466e4a54bec4a2dc34dc6f19b6a371947f4aa930ca5318e71ddcdb46789da4::collection::Collection<T0>, arg1: &mut 0x2::balance::Balance<T1>, arg2: u64) {
        let v0 = Witness{dummy_field: false};
        let v1 = &mut 0xce466e4a54bec4a2dc34dc6f19b6a371947f4aa930ca5318e71ddcdb46789da4::collection::borrow_domain_mut<T0, RoyaltyDomain>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<RoyaltyDomain, Witness>(v0), arg0).aggregations;
        if (!0x2::dynamic_field::exists_with_type<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<0x2::balance::Balance<T1>>, 0x2::balance::Balance<T1>>(v1, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<0x2::balance::Balance<T1>>())) {
            0x2::dynamic_field::add<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<0x2::balance::Balance<T1>>, 0x2::balance::Balance<T1>>(v1, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<0x2::balance::Balance<T1>>(), 0x2::balance::zero<T1>());
        };
        0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<0x2::balance::Balance<T1>>, 0x2::balance::Balance<T1>>(v1, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<0x2::balance::Balance<T1>>()), 0x2::balance::split<T1>(arg1, arg2));
    }

    public fun contains_share(arg0: &RoyaltyDomain, arg1: &address) : bool {
        0x2::vec_map::contains<address, u16>(&arg0.royalty_shares_bps, arg1)
    }

    public fun contains_shares(arg0: &RoyaltyDomain) : bool {
        !0x2::vec_map::is_empty<address, u16>(&arg0.royalty_shares_bps)
    }

    public fun distribute_balance<T0>(arg0: &0x2::vec_map::VecMap<address, u16>, arg1: &mut 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x2::vec_map::size<address, u16>(arg0)) {
            let (v1, v2) = 0x2::vec_map::get_entry_by_idx<address, u16>(arg0, v0);
            let (_, v4) = 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::math::div_round((*v2 as u64), (0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::bps() as u64));
            let (_, v6) = 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::math::mul_round(v4, 0x2::balance::value<T0>(arg1));
            if (v6 != 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg1, v6), arg2), *v1);
            };
            v0 = v0 + 1;
        };
    }

    public entry fun distribute_royalties<T0, T1>(arg0: &mut 0xce466e4a54bec4a2dc34dc6f19b6a371947f4aa930ca5318e71ddcdb46789da4::collection::Collection<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let v1 = 0xce466e4a54bec4a2dc34dc6f19b6a371947f4aa930ca5318e71ddcdb46789da4::collection::borrow_domain_mut<T0, RoyaltyDomain>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<RoyaltyDomain, Witness>(v0), arg0);
        let v2 = 0x2::dynamic_field::borrow_mut<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<0x2::balance::Balance<T1>>, 0x2::balance::Balance<T1>>(&mut v1.aggregations, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<0x2::balance::Balance<T1>>());
        distribute_balance<T1>(&v1.royalty_shares_bps, v2, arg1);
    }

    public fun from_address(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : RoyaltyDomain {
        let v0 = 0x2::vec_map::empty<address, u16>();
        0x2::vec_map::insert<address, u16>(&mut v0, arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::bps());
        from_shares(v0, arg1)
    }

    public fun from_shares(arg0: 0x2::vec_map::VecMap<address, u16>, arg1: &mut 0x2::tx_context::TxContext) : RoyaltyDomain {
        assert_total_shares(&arg0);
        RoyaltyDomain{
            strategies         : 0x2::vec_set::empty<0x2::object::ID>(),
            aggregations       : 0x2::object::new(arg1),
            royalty_shares_bps : arg0,
        }
    }

    public fun has_domain(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_field::exists_with_type<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<RoyaltyDomain>, RoyaltyDomain>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<RoyaltyDomain>())
    }

    public fun new_empty(arg0: &mut 0x2::tx_context::TxContext) : RoyaltyDomain {
        from_shares(0x2::vec_map::empty<address, u16>(), arg0)
    }

    public entry fun remove_collection_share<T0>(arg0: &mut 0xce466e4a54bec4a2dc34dc6f19b6a371947f4aa930ca5318e71ddcdb46789da4::collection::Collection<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let v1 = 0xce466e4a54bec4a2dc34dc6f19b6a371947f4aa930ca5318e71ddcdb46789da4::collection::borrow_domain_mut<T0, RoyaltyDomain>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<RoyaltyDomain, Witness>(v0), arg0);
        remove_creator_by_transfer(v1, arg1, arg2);
    }

    public fun remove_creator_by_transfer(arg0: &mut RoyaltyDomain, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let (_, v2) = 0x2::vec_map::remove<address, u16>(&mut arg0.royalty_shares_bps, &v0);
        if (contains_share(arg0, &arg1)) {
            let v3 = borrow_share_mut(arg0, &arg1);
            *v3 = *v3 + v2;
        } else {
            0x2::vec_map::insert<address, u16>(&mut arg0.royalty_shares_bps, arg1, v2);
        };
    }

    public fun remove_domain(arg0: &mut 0x2::object::UID) : RoyaltyDomain {
        assert_royalty(arg0);
        0x2::dynamic_field::remove<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<RoyaltyDomain>, RoyaltyDomain>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<RoyaltyDomain>())
    }

    public fun remove_strategy(arg0: &mut RoyaltyDomain, arg1: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.strategies, &arg1);
    }

    public fun strategies(arg0: &RoyaltyDomain) : &0x2::vec_set::VecSet<0x2::object::ID> {
        &arg0.strategies
    }

    // decompiled from Move bytecode v6
}

