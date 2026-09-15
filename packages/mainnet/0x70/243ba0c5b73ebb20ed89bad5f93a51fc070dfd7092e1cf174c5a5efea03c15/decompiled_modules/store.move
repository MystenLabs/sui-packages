module 0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::store {
    struct StoreCap has store, key {
        id: 0x2::object::UID,
    }

    struct Store has key {
        id: 0x2::object::UID,
        toys: 0x2::bag::Bag,
    }

    public(friend) fun transfer<T0: store + key>(arg0: &mut Store, arg1: &0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::registry::Registry, arg2: u64, arg3: address, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::toy::is_listed(0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::registry::borrow_toy<T0>(arg1)), 2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.toys, v0), 3);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, vector<T0>>(&mut arg0.toys, v0);
        assert!(0x1::vector::length<T0>(v1) >= arg2, 0);
        let v2 = 0x1::vector::empty<T0>();
        let v3 = 0;
        while (v3 < arg2) {
            0x1::vector::push_back<T0>(&mut v2, 0x1::vector::remove<T0>(v1, 0));
            v3 = v3 + 1;
        };
        0x1::vector::reverse<T0>(&mut v2);
        let v4 = 0;
        while (v4 < 0x1::vector::length<T0>(&v2)) {
            0x2::transfer::public_transfer<T0>(0x1::vector::pop_back<T0>(&mut v2), arg3);
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<T0>(v2);
        if (arg4) {
            let v5 = 0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::points::new(arg5);
            0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::points::add_points(&mut v5, 0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::points::purchase_reward(0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::toy::category(0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::registry::borrow_toy<T0>(arg1))) * arg2);
            0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::points::transfer(v5, arg3);
        };
    }

    public fun add_preminted<T0: store + key>(arg0: &mut Store, arg1: &StoreCap, arg2: &mut 0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::registry::Registry, arg3: vector<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.toys, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, vector<T0>>(&mut arg0.toys, v0, 0x1::vector::empty<T0>());
        };
        0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::toy::increase_supply(0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::registry::borrow_toy_mut<T0>(arg2), 0x1::vector::length<T0>(&arg3));
        0x1::vector::append<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, vector<T0>>(&mut arg0.toys, v0), arg3);
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

    public fun purchase_toy_with_points<T0: store + key>(arg0: &mut Store, arg1: &mut 0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::registry::Registry, arg2: &mut 0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::points::FutrPoint, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::toy::points_price(0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::registry::borrow_toy<T0>(arg1));
        assert!(v0 > 0, 4);
        0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::points::remove_points(arg2, v0);
        let v1 = 0x2::tx_context::sender(arg3);
        transfer<T0>(arg0, arg1, 1, v1, false, arg3);
    }

    public fun purchase_toy_with_usd<T0: store + key>(arg0: &mut Store, arg1: &mut 0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::registry::Registry, arg2: &mut 0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::treasury::Treasury, arg3: &mut 0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::points::FutrPoint, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg4) >= 0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::toy::usd_price(0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::registry::borrow_toy<T0>(arg1)) * arg5, 1);
        0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::treasury::add(arg2, arg4);
        let v0 = 0x2::tx_context::sender(arg6);
        transfer<T0>(arg0, arg1, arg5, v0, true, arg6);
        0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::points::add_points(arg3, 0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::points::purchase_reward(0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::toy::category(0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::registry::borrow_toy<T0>(arg1))) * arg5);
    }

    public fun transfer_toys<T0: store + key>(arg0: &mut Store, arg1: &StoreCap, arg2: &mut 0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::registry::Registry, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        transfer<T0>(arg0, arg2, arg3, arg4, true, arg5);
    }

    // decompiled from Move bytecode v7
}

