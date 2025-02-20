module 0xd691896f2ff416a8fa4792ee30895b28d71cf8bb8291f6f222a66d3e47b2c1c7::hub_token {
    struct HubStorage has store, key {
        id: 0x2::object::UID,
        hubs: 0x2::bag::Bag,
    }

    struct Hub<phantom T0> has store {
        policy_cap: 0x2::token::TokenPolicyCap<T0>,
        owner: address,
        members: vector<address>,
    }

    struct HubAdded has copy, drop, store {
        hub_type: 0x1::ascii::String,
    }

    struct Minted has copy, drop, store {
        to: address,
        amount: u64,
    }

    struct Transferred has copy, drop, store {
        from: address,
        to: address,
        amount: u64,
    }

    public entry fun mint<T0>(arg0: &mut HubStorage, arg1: &mut 0x2::coin::TreasuryCap<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bag::borrow_mut<0x1::ascii::String, Hub<T0>>(&mut arg0.hubs, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (!0x1::vector::contains<address>(&v0.members, &arg3)) {
            0x1::vector::push_back<address>(&mut v0.members, arg3);
        };
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T0>(arg1, 0x2::token::transfer<T0>(0x2::token::mint<T0>(arg1, arg2, arg4), arg3, arg4), arg4);
        let v5 = Minted{
            to     : arg3,
            amount : arg2,
        };
        0x2::event::emit<Minted>(v5);
    }

    public entry fun transfer<T0>(arg0: &mut HubStorage, arg1: 0x2::token::Token<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bag::borrow_mut<0x1::ascii::String, Hub<T0>>(&mut arg0.hubs, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(0x1::vector::contains<address>(&v0.members, &arg2), 0);
        let (_, _, _, _) = 0x2::token::confirm_with_policy_cap<T0>(&v0.policy_cap, 0x2::token::transfer<T0>(arg1, arg2, arg3), arg3);
        let v5 = Transferred{
            from   : 0x2::tx_context::sender(arg3),
            to     : arg2,
            amount : 0x2::token::value<T0>(&arg1),
        };
        0x2::event::emit<Transferred>(v5);
    }

    public entry fun create<T0>(arg0: &0xd691896f2ff416a8fa4792ee30895b28d71cf8bb8291f6f222a66d3e47b2c1c7::factory::CollectionCap, arg1: 0x2::token::TokenPolicyCap<T0>, arg2: &mut HubStorage, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Hub<T0>{
            policy_cap : arg1,
            owner      : 0x2::tx_context::sender(arg3),
            members    : 0x1::vector::singleton<address>(0x2::tx_context::sender(arg3)),
        };
        0x2::bag::add<0x1::ascii::String, Hub<T0>>(&mut arg2.hubs, 0x1::type_name::into_string(0x1::type_name::get<T0>()), v0);
        let v1 = HubAdded{hub_type: 0x1::type_name::into_string(0x1::type_name::get<T0>())};
        0x2::event::emit<HubAdded>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HubStorage{
            id   : 0x2::object::new(arg0),
            hubs : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<HubStorage>(v0);
    }

    public entry fun join_hub<T0>(arg0: &mut HubStorage, arg1: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<address>(&mut 0x2::bag::borrow_mut<0x1::ascii::String, Hub<T0>>(&mut arg0.hubs, 0x1::type_name::into_string(0x1::type_name::get<T0>())).members, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

