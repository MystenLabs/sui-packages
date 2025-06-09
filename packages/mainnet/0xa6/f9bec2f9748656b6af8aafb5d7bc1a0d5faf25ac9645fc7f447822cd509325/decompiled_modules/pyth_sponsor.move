module 0xa6f9bec2f9748656b6af8aafb5d7bc1a0d5faf25ac9645fc7f447822cd509325::pyth_sponsor {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GasAddedEvent has copy, drop {
        balance: u64,
        sender: address,
    }

    struct GasRemovedEvent has copy, drop {
        balance: u64,
        sender: address,
    }

    struct SponsoredPythRequestedEvent has copy, drop {
        base_fee: u64,
        feed_id: 0x2::object::ID,
        sender: address,
    }

    struct GasStation has key {
        id: 0x2::object::UID,
        gas_coin: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GasStation{
            id       : 0x2::object::new(arg0),
            gas_coin : 0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>(),
        };
        0x2::transfer::share_object<GasStation>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun remove_gas_object(arg0: &AdminCap, arg1: &mut GasStation, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1.gas_coin);
        let v1 = GasRemovedEvent{
            balance : 0x2::coin::value<0x2::sui::SUI>(&v0),
            sender  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<GasRemovedEvent>(v1);
        v0
    }

    fun request_gas_coin(arg0: &mut GasStation, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&arg0.gas_coin), 3);
        0x2::coin::split<0x2::sui::SUI>(0x1::option::borrow_mut<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.gas_coin), arg1, arg2)
    }

    public fun set_gas_object(arg0: &AdminCap, arg1: &mut GasStation, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 1);
        0x1::option::fill<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1.gas_coin, arg2);
        let v1 = GasAddedEvent{
            balance : v0,
            sender  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<GasAddedEvent>(v1);
    }

    public fun update_single_price_feed_with_sponsor(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>, arg2: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &mut GasStation, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo> {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg0);
        assert!(v0 > 0, 2);
        let v1 = request_gas_coin(arg3, v0, arg5);
        let v2 = SponsoredPythRequestedEvent{
            base_fee : v0,
            feed_id  : 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2),
            sender   : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<SponsoredPythRequestedEvent>(v2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, arg1, arg2, v1, arg4)
    }

    // decompiled from Move bytecode v6
}

