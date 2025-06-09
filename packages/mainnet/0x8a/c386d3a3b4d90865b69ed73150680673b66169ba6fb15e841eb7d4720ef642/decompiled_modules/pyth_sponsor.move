module 0x8ac386d3a3b4d90865b69ed73150680673b66169ba6fb15e841eb7d4720ef642::pyth_sponsor {
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
        price_info_length: u64,
        sender: address,
    }

    struct GasStation has key {
        id: 0x2::object::UID,
        gas_coin: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>,
        last_user: 0x1::option::Option<address>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GasStation{
            id        : 0x2::object::new(arg0),
            gas_coin  : 0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>(),
            last_user : 0x1::option::none<address>(),
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

    fun request_gas_coin(arg0: &mut GasStation, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) : &mut 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&arg0.gas_coin), 3);
        0x1::option::fill<address>(&mut arg0.last_user, 0x2::tx_context::sender(arg3));
        assert!(0x2::coin::value<0x2::sui::SUI>(0x1::option::borrow<0x2::coin::Coin<0x2::sui::SUI>>(&arg0.gas_coin)) >= arg1 * arg2, 5);
        0x1::option::borrow_mut<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.gas_coin)
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

    public fun sponsor_pyth_tx(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>, arg2: &mut vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg3: &mut GasStation, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo> {
        assert!(arg4 > 0, 2);
        let v0 = 0x1::vector::length<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2);
        assert!(v0 > 0, 4);
        let v1 = request_gas_coin(arg3, v0, arg4, arg6);
        let v2 = 0;
        while (v2 < v0) {
            arg1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, arg1, 0x1::vector::borrow_mut<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2, v2), 0x2::coin::split<0x2::sui::SUI>(v1, arg4, arg6), arg5);
            v2 = v2 + 1;
        };
        let v3 = SponsoredPythRequestedEvent{
            base_fee          : arg4,
            price_info_length : v0,
            sender            : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<SponsoredPythRequestedEvent>(v3);
        arg1
    }

    // decompiled from Move bytecode v6
}

