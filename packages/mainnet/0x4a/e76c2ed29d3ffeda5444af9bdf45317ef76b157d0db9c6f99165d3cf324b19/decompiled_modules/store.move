module 0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::store {
    struct StoreCap has store, key {
        id: 0x2::object::UID,
    }

    struct Store has key {
        id: 0x2::object::UID,
        toys: 0x2::bag::Bag,
    }

    public(friend) fun transfer<T0: store + key>(arg0: &mut Store, arg1: &0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::registry::Registry, arg2: u64, arg3: address, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::toy::is_listed(0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::registry::borrow_toy<T0>(arg1)), 2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.toys, v0), 3);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::table_vec::TableVec<T0>>(&mut arg0.toys, v0);
        assert!(0x2::table_vec::length<T0>(v1) >= arg2, 0);
        let v2 = 0;
        while (v2 < arg2) {
            0x2::transfer::public_transfer<T0>(0x2::table_vec::pop_back<T0>(v1), arg3);
            v2 = v2 + 1;
        };
        if (arg4) {
            let v3 = 0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::points::new(arg5);
            0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::points::add_points(&mut v3, 0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::points::purchase_reward(0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::toy::tier(0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::registry::borrow_toy<T0>(arg1))) * arg2);
            0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::points::transfer(v3, arg3);
        };
    }

    public fun add_preminted<T0: store + key>(arg0: &mut Store, arg1: &StoreCap, arg2: &mut 0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::registry::Registry, arg3: vector<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.toys, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::table_vec::TableVec<T0>>(&mut arg0.toys, v0, 0x2::table_vec::empty<T0>(arg4));
        };
        0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::toy::increase_supply(0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::registry::borrow_toy_mut<T0>(arg2), 0x1::vector::length<T0>(&arg3));
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::table_vec::TableVec<T0>>(&mut arg0.toys, v0);
        0x1::vector::reverse<T0>(&mut arg3);
        let v2 = 0;
        while (v2 < 0x1::vector::length<T0>(&arg3)) {
            0x2::table_vec::push_back<T0>(v1, 0x1::vector::pop_back<T0>(&mut arg3));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<T0>(arg3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StoreCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<StoreCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Store{
            id   : 0x2::object::new(arg0),
            toys : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<Store>(v1);
    }

    public fun purchase_toy_with_points<T0: store + key>(arg0: &mut Store, arg1: &mut 0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::registry::Registry, arg2: &mut 0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::points::FutrPoint, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::toy::points_price(0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::registry::borrow_toy<T0>(arg1));
        assert!(v0 > 0, 4);
        0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::points::remove_points(arg2, v0);
        let v1 = 0x2::tx_context::sender(arg3);
        transfer<T0>(arg0, arg1, 1, v1, false, arg3);
    }

    public fun purchase_toy_with_usd<T0: store + key>(arg0: &mut Store, arg1: &mut 0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::registry::Registry, arg2: &mut 0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::treasury::Treasury, arg3: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::toy::usd_price(0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::registry::borrow_toy<T0>(arg1)) * arg4;
        let v1 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg3);
        assert!(v1 >= v0, 1);
        if (v1 > v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg3, v1 - v0, arg5), 0x2::tx_context::sender(arg5));
        };
        0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::treasury::add(arg2, arg3);
        let v2 = 0x2::tx_context::sender(arg5);
        transfer<T0>(arg0, arg1, arg4, v2, true, arg5);
    }

    public fun transfer_toys<T0: store + key>(arg0: &mut Store, arg1: &StoreCap, arg2: &mut 0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::registry::Registry, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        transfer<T0>(arg0, arg2, arg3, arg4, true, arg5);
    }

    // decompiled from Move bytecode v7
}

