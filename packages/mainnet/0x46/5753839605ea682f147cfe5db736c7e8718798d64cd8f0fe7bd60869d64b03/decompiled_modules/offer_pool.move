module 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer_pool {
    struct OfferPool has key {
        id: 0x2::object::UID,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
        held: u64,
        members: 0x2::linked_table::LinkedTable<0x2::object::ID, 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::Terms>,
        label: 0x1::option::Option<0x1::string::String>,
        maker: address,
        version: u64,
    }

    public fun new(arg0: &0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::Config, arg1: 0x1::option::Option<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) : OfferPool {
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::assert_open(arg0);
        OfferPool{
            id      : 0x2::object::new(arg2),
            funds   : 0x2::balance::zero<0x2::sui::SUI>(),
            held    : 0,
            members : 0x2::linked_table::new<0x2::object::ID, 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::Terms>(arg2),
            label   : arg1,
            maker   : 0x2::tx_context::sender(arg2),
            version : 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::current(),
        }
    }

    fun remove(arg0: &mut OfferPool, arg1: 0x2::object::ID, arg2: u8) {
        assert!(0x2::linked_table::contains<0x2::object::ID, 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::Terms>(&arg0.members, arg1), 354);
        let v0 = 0x2::linked_table::remove<0x2::object::ID, 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::Terms>(&mut arg0.members, arg1);
        arg0.held = arg0.held - 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::escrow_total(&v0);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::events::offer_closed(arg1, 0x1::option::some<0x2::object::ID>(0x2::object::id<OfferPool>(arg0)), arg0.maker, 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::left(&v0), 0, arg2);
    }

    public fun add<T0: store + key>(arg0: &mut OfferPool, arg1: &0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::Config, arg2: &0x2::transfer_policy::TransferPolicy<T0>, arg3: u8, arg4: 0x1::option::Option<0x2::object::ID>, arg5: 0x1::option::Option<vector<u8>>, arg6: u64, arg7: u64, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<0x2::object::ID>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        add_inner<T0>(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::clearing::royalty_due<T0>(arg2, arg6), arg10, arg11)
    }

    fun add_inner<T0: store + key>(arg0: &mut OfferPool, arg1: &0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::Config, arg2: u8, arg3: 0x1::option::Option<0x2::object::ID>, arg4: 0x1::option::Option<vector<u8>>, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<0x2::object::ID>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::assert_open(arg1);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::assert_object(arg0.version);
        assert!(0x2::tx_context::sender(arg11) == arg0.maker, 351);
        assert!(0x2::linked_table::length<0x2::object::ID, 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::Terms>(&arg0.members) < 128, 353);
        let v0 = 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::new_terms<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        arg0.held = arg0.held + 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::escrow_total(&v0);
        assert!(arg0.held <= 0x2::balance::value<0x2::sui::SUI>(&arg0.funds), 352);
        let v1 = 0x2::object::new(arg11);
        let v2 = 0x2::object::uid_to_inner(&v1);
        0x2::object::delete(v1);
        0x2::linked_table::push_back<0x2::object::ID, 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::Terms>(&mut arg0.members, v2, v0);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::emit_placed(v2, 0x1::option::some<0x2::object::ID>(0x2::object::id<OfferPool>(arg0)), arg0.maker, &v0);
        v2
    }

    public fun add_unruled<T0: store + key>(arg0: &mut OfferPool, arg1: &0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::Config, arg2: u8, arg3: 0x1::option::Option<0x2::object::ID>, arg4: 0x1::option::Option<vector<u8>>, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<0x2::object::ID>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        add_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0, arg9, arg10)
    }

    fun after_fill(arg0: &mut OfferPool, arg1: 0x2::object::ID, arg2: u64, arg3: &0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::Terms) {
        arg0.held = arg0.held - arg2;
        if (0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::left(arg3) == 0) {
            0x2::linked_table::remove<0x2::object::ID, 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::Terms>(&mut arg0.members, arg1);
        };
        emit_funded(arg0);
    }

    public fun close(arg0: OfferPool, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg1) == arg0.maker, 351);
        let v0 = 0x2::object::id<OfferPool>(&arg0);
        let OfferPool {
            id      : v1,
            funds   : v2,
            held    : _,
            members : v4,
            label   : _,
            maker   : v6,
            version : _,
        } = arg0;
        let v8 = v4;
        let v9 = v2;
        while (!0x2::linked_table::is_empty<0x2::object::ID, 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::Terms>(&v8)) {
            let (v10, v11) = 0x2::linked_table::pop_front<0x2::object::ID, 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::Terms>(&mut v8);
            let v12 = v11;
            0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::events::offer_closed(v10, 0x1::option::some<0x2::object::ID>(v0), v6, 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::left(&v12), 0, 2);
        };
        0x2::linked_table::destroy_empty<0x2::object::ID, 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::Terms>(v8);
        0x2::object::delete(v1);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::events::pool_closed(v0, v6, 0x2::balance::value<0x2::sui::SUI>(&v9));
        0x2::coin::from_balance<0x2::sui::SUI>(v9, arg1)
    }

    public fun deposit(arg0: &mut OfferPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.maker, 351);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.funds, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        emit_funded(arg0);
    }

    public fun drop_member(arg0: &mut OfferPool, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.maker, 351);
        remove(arg0, arg1, 0);
    }

    fun emit_funded(arg0: &OfferPool) {
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::events::pool_funded(0x2::object::id<OfferPool>(arg0), arg0.maker, arg0.label, 0x2::balance::value<0x2::sui::SUI>(&arg0.funds), arg0.held);
    }

    public fun fill<T0: store + key>(arg0: &mut OfferPool, arg1: 0x2::object::ID, arg2: &0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::Config, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: &mut 0x2::kiosk::Kiosk, arg7: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg8: vector<vector<u8>>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::transfer_policy::TransferRequest<T0>) {
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::assert_object(arg0.version);
        assert!(0x2::linked_table::contains<0x2::object::ID, 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::Terms>(&arg0.members, arg1), 354);
        let v0 = arg0.maker;
        let v1 = 0x2::linked_table::borrow_mut<0x2::object::ID, 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::Terms>(&mut arg0.members, arg1);
        let v2 = 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::escrow_unit(v1);
        let (v3, v4, v5) = 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::fill_kiosk_core<T0>(v1, &mut arg0.funds, v0, arg2, arg3, arg4, arg5, arg6, arg7, &arg8, arg9, arg10);
        let v6 = v5;
        let v7 = *v1;
        after_fill(arg0, arg1, v2, &v7);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::emit_filled(arg1, 0x1::option::some<0x2::object::ID>(0x2::object::id<OfferPool>(arg0)), v0, &v7, &v6, arg10);
        (v3, v4)
    }

    public fun fill_owned<T0: store + key>(arg0: &mut OfferPool, arg1: 0x2::object::ID, arg2: &0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::Config, arg3: T0, arg4: vector<vector<u8>>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::assert_object(arg0.version);
        assert!(0x2::linked_table::contains<0x2::object::ID, 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::Terms>(&arg0.members, arg1), 354);
        let v0 = arg0.maker;
        let v1 = 0x2::linked_table::borrow_mut<0x2::object::ID, 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::Terms>(&mut arg0.members, arg1);
        let v2 = 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::escrow_unit(v1);
        let (v3, v4) = 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::fill_owned_core<T0>(v1, &mut arg0.funds, v0, arg2, arg3, &arg4, arg5, arg6);
        let v5 = v4;
        let v6 = *v1;
        after_fill(arg0, arg1, v2, &v6);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::emit_filled(arg1, 0x1::option::some<0x2::object::ID>(0x2::object::id<OfferPool>(arg0)), v0, &v6, &v5, arg6);
        v3
    }

    public fun free(arg0: &OfferPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.funds) - arg0.held
    }

    public fun funds(arg0: &OfferPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.funds)
    }

    public fun has_member(arg0: &OfferPool, arg1: 0x2::object::ID) : bool {
        0x2::linked_table::contains<0x2::object::ID, 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::Terms>(&arg0.members, arg1)
    }

    public fun held(arg0: &OfferPool) : u64 {
        arg0.held
    }

    public fun maker(arg0: &OfferPool) : address {
        arg0.maker
    }

    public fun member(arg0: &OfferPool, arg1: 0x2::object::ID) : 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::Terms {
        *0x2::linked_table::borrow<0x2::object::ID, 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::Terms>(&arg0.members, arg1)
    }

    public fun member_count(arg0: &OfferPool) : u64 {
        0x2::linked_table::length<0x2::object::ID, 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::Terms>(&arg0.members)
    }

    public fun prune(arg0: &mut OfferPool, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        assert!(0x2::linked_table::contains<0x2::object::ID, 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::Terms>(&arg0.members, arg1), 354);
        let v0 = 0x2::linked_table::borrow<0x2::object::ID, 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::Terms>(&arg0.members, arg1);
        assert!(0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::left(v0) == 0 || 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer::expired(v0, arg2), 355);
        remove(arg0, arg1, 1);
    }

    public fun relabel(arg0: &mut OfferPool, arg1: 0x1::option::Option<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.maker, 351);
        arg0.label = arg1;
        emit_funded(arg0);
    }

    public fun share(arg0: OfferPool) {
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::events::pool_opened(0x2::object::id<OfferPool>(&arg0), arg0.maker, arg0.label, 0x2::balance::value<0x2::sui::SUI>(&arg0.funds));
        0x2::transfer::share_object<OfferPool>(arg0);
    }

    public fun withdraw(arg0: &mut OfferPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg2) == arg0.maker, 351);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.funds) - arg0.held >= arg1, 352);
        emit_funded(arg0);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.funds, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

