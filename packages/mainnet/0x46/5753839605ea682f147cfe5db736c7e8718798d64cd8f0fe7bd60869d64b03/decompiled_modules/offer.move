module 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::offer {
    struct Terms has copy, drop, store {
        left: u64,
        each: u64,
        fee: u64,
        reserve: u64,
        until_ms: 0x1::option::Option<u64>,
        scope: u8,
        item: 0x1::option::Option<0x2::object::ID>,
        root: 0x1::option::Option<vector<u8>>,
        dest: 0x1::option::Option<0x2::object::ID>,
        kind: 0x1::type_name::TypeName,
    }

    struct Offer<phantom T0> has key {
        id: 0x2::object::UID,
        escrow: 0x2::balance::Balance<0x2::sui::SUI>,
        terms: Terms,
        maker: address,
        version: u64,
    }

    struct Filled has copy, drop {
        item: 0x2::object::ID,
        royalty: u64,
        returned: u64,
        seller_kiosk: 0x1::option::Option<0x2::object::ID>,
        dest: 0x1::option::Option<0x2::object::ID>,
    }

    fun check<T0>(arg0: &Terms, arg1: 0x2::object::ID, arg2: &vector<vector<u8>>, arg3: &0x2::clock::Clock) {
        assert!(arg0.left > 0, 307);
        assert!(!expired(arg0, arg3), 308);
        assert!(arg0.kind == 0x1::type_name::with_defining_ids<T0>(), 311);
        if (arg0.scope == 1) {
            assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.item) == arg1, 309);
        } else if (arg0.scope == 2) {
            assert!(0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::merkle::contains(0x1::option::borrow<vector<u8>>(&arg0.root), arg1, arg2), 310);
        };
    }

    public(friend) fun emit_filled(arg0: 0x2::object::ID, arg1: 0x1::option::Option<0x2::object::ID>, arg2: address, arg3: &Terms, arg4: &Filled, arg5: &0x2::tx_context::TxContext) {
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::events::offer_filled(arg0, arg1, arg2, 0x2::tx_context::sender(arg5), arg3.kind, arg4.item, arg3.each, arg3.fee, arg4.royalty, arg4.returned, arg4.seller_kiosk, arg4.dest, arg3.left);
    }

    public(friend) fun emit_placed(arg0: 0x2::object::ID, arg1: 0x1::option::Option<0x2::object::ID>, arg2: address, arg3: &Terms) {
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::events::offer_placed(arg0, arg1, arg2, arg3.kind, arg3.scope, arg3.item, arg3.root, arg3.each, arg3.fee, arg3.reserve, arg3.left, arg3.until_ms, arg3.dest);
    }

    public(friend) fun escrow_total(arg0: &Terms) : u64 {
        escrow_unit(arg0) * arg0.left
    }

    public(friend) fun escrow_unit(arg0: &Terms) : u64 {
        arg0.each + arg0.fee + arg0.reserve
    }

    public fun escrowed<T0>(arg0: &Offer<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.escrow)
    }

    public(friend) fun expired(arg0: &Terms, arg1: &0x2::clock::Clock) : bool {
        0x1::option::is_some<u64>(&arg0.until_ms) && 0x2::clock::timestamp_ms(arg1) > *0x1::option::borrow<u64>(&arg0.until_ms)
    }

    public fun fill<T0: store + key>(arg0: &mut Offer<T0>, arg1: &0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::Config, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg7: vector<vector<u8>>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::transfer_policy::TransferRequest<T0>) {
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::assert_object(arg0.version);
        let v0 = &mut arg0.terms;
        let v1 = &mut arg0.escrow;
        let (v2, v3, v4) = fill_kiosk_core<T0>(v0, v1, arg0.maker, arg1, arg2, arg3, arg4, arg5, arg6, &arg7, arg8, arg9);
        let v5 = v4;
        emit_filled(0x2::object::id<Offer<T0>>(arg0), 0x1::option::none<0x2::object::ID>(), arg0.maker, &arg0.terms, &v5, arg9);
        (v2, v3)
    }

    public(friend) fun fill_kiosk_core<T0: store + key>(arg0: &mut Terms, arg1: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg2: address, arg3: &0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::Config, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::object::ID, arg7: &mut 0x2::kiosk::Kiosk, arg8: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg9: &vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::transfer_policy::TransferRequest<T0>, Filled) {
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::assert_open(arg3);
        check<T0>(arg0, arg6, arg9, arg10);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.dest), 312);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg7) == *0x1::option::borrow<0x2::object::ID>(&arg0.dest), 313);
        let v0 = 0x2::balance::split<0x2::sui::SUI>(arg1, escrow_unit(arg0));
        let v1 = arg0.each;
        let (v2, v3) = 0x2::kiosk::purchase_with_cap<T0>(arg4, 0x2::kiosk::list_with_purchase_cap<T0>(arg4, arg5, arg6, v1, arg11), 0x2::coin::take<0x2::sui::SUI>(&mut v0, v1, arg11));
        let v4 = v3;
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::send(0x2::balance::split<0x2::sui::SUI>(&mut v0, arg0.fee), 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::treasury(arg3), arg11);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::courier::deliver<T0>(arg7, arg2, v2, arg8);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::send(v0, arg2, arg11);
        arg0.left = arg0.left - 1;
        let v5 = Filled{
            item         : arg6,
            royalty      : 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::clearing::clear<T0>(arg8, &mut v4, arg7, &mut v0, arg11),
            returned     : 0x2::balance::value<0x2::sui::SUI>(&v0),
            seller_kiosk : 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::kiosk::Kiosk>(arg4)),
            dest         : 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::kiosk::Kiosk>(arg7)),
        };
        (0x2::kiosk::withdraw(arg4, arg5, 0x1::option::some<u64>(v1), arg11), v4, v5)
    }

    public fun fill_owned<T0: store + key>(arg0: &mut Offer<T0>, arg1: &0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::Config, arg2: T0, arg3: vector<vector<u8>>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::assert_object(arg0.version);
        let v0 = &mut arg0.terms;
        let v1 = &mut arg0.escrow;
        let (v2, v3) = fill_owned_core<T0>(v0, v1, arg0.maker, arg1, arg2, &arg3, arg4, arg5);
        let v4 = v3;
        emit_filled(0x2::object::id<Offer<T0>>(arg0), 0x1::option::none<0x2::object::ID>(), arg0.maker, &arg0.terms, &v4, arg5);
        v2
    }

    public(friend) fun fill_owned_core<T0: store + key>(arg0: &mut Terms, arg1: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg2: address, arg3: &0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::Config, arg4: T0, arg5: &vector<vector<u8>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, Filled) {
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::assert_open(arg3);
        let v0 = 0x2::object::id<T0>(&arg4);
        check<T0>(arg0, v0, arg5, arg6);
        let v1 = 0x2::balance::split<0x2::sui::SUI>(arg1, escrow_unit(arg0));
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::send(0x2::balance::split<0x2::sui::SUI>(&mut v1, arg0.fee), 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::treasury(arg3), arg7);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::send(v1, arg2, arg7);
        0x2::transfer::public_transfer<T0>(arg4, arg2);
        arg0.left = arg0.left - 1;
        let v2 = Filled{
            item         : v0,
            royalty      : 0,
            returned     : 0x2::balance::value<0x2::sui::SUI>(&v1),
            seller_kiosk : 0x1::option::none<0x2::object::ID>(),
            dest         : 0x1::option::none<0x2::object::ID>(),
        };
        (0x2::coin::take<0x2::sui::SUI>(&mut v1, arg0.each, arg7), v2)
    }

    public(friend) fun left(arg0: &Terms) : u64 {
        arg0.left
    }

    public fun maker<T0>(arg0: &Offer<T0>) : address {
        arg0.maker
    }

    public(friend) fun new_terms<T0>(arg0: &0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::Config, arg1: u8, arg2: 0x1::option::Option<0x2::object::ID>, arg3: 0x1::option::Option<vector<u8>>, arg4: u64, arg5: u64, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<0x2::object::ID>, arg8: u64, arg9: &0x2::clock::Clock) : Terms {
        assert!(arg4 > 0, 302);
        assert!(arg5 > 0, 303);
        if (arg1 == 0) {
            assert!(0x1::option::is_none<0x2::object::ID>(&arg2) && 0x1::option::is_none<vector<u8>>(&arg3), 301);
        } else if (arg1 == 1) {
            let v0 = if (0x1::option::is_some<0x2::object::ID>(&arg2)) {
                if (0x1::option::is_none<vector<u8>>(&arg3)) {
                    arg5 == 1
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v0, 301);
        } else {
            assert!(arg1 == 2, 301);
            let v1 = if (0x1::option::is_none<0x2::object::ID>(&arg2)) {
                if (0x1::option::is_some<vector<u8>>(&arg3)) {
                    0x1::vector::length<u8>(0x1::option::borrow<vector<u8>>(&arg3)) == 32
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v1, 301);
        };
        if (0x1::option::is_some<u64>(&arg6)) {
            assert!(*0x1::option::borrow<u64>(&arg6) > 0x2::clock::timestamp_ms(arg9), 304);
        };
        Terms{
            left     : arg5,
            each     : arg4,
            fee      : 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::portion(arg4, 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::offer_bps(arg0)),
            reserve  : arg8,
            until_ms : arg6,
            scope    : arg1,
            item     : arg2,
            root     : arg3,
            dest     : arg7,
            kind     : 0x1::type_name::with_defining_ids<T0>(),
        }
    }

    public fun place<T0: store + key>(arg0: &0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::Config, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: u8, arg3: 0x1::option::Option<0x2::object::ID>, arg4: 0x1::option::Option<vector<u8>>, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<0x2::object::ID>, arg9: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        place_inner<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::clearing::royalty_due<T0>(arg1, arg5), arg9, arg10, arg11)
    }

    fun place_inner<T0: store + key>(arg0: &0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::Config, arg1: u8, arg2: 0x1::option::Option<0x2::object::ID>, arg3: 0x1::option::Option<vector<u8>>, arg4: u64, arg5: u64, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<0x2::object::ID>, arg8: u64, arg9: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::assert_open(arg0);
        let v0 = new_terms<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg10);
        let v1 = escrow_total(&v0);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg9) >= v1, 305);
        let v2 = Offer<T0>{
            id      : 0x2::object::new(arg11),
            escrow  : 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg9), v1),
            terms   : v0,
            maker   : 0x2::tx_context::sender(arg11),
            version : 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::current(),
        };
        let v3 = 0x2::object::id<Offer<T0>>(&v2);
        emit_placed(v3, 0x1::option::none<0x2::object::ID>(), v2.maker, &v2.terms);
        0x2::transfer::share_object<Offer<T0>>(v2);
        v3
    }

    public fun place_unruled<T0: store + key>(arg0: &0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::Config, arg1: u8, arg2: 0x1::option::Option<0x2::object::ID>, arg3: 0x1::option::Option<vector<u8>>, arg4: u64, arg5: u64, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<0x2::object::ID>, arg8: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        place_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0, arg8, arg9, arg10)
    }

    public fun retire<T0>(arg0: Offer<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.terms.left == 0 || expired(&arg0.terms, arg1), 314);
        let Offer {
            id      : v0,
            escrow  : v1,
            terms   : v2,
            maker   : v3,
            version : _,
        } = arg0;
        let v5 = v2;
        let v6 = v1;
        0x2::object::delete(v0);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::events::offer_closed(0x2::object::id<Offer<T0>>(&arg0), 0x1::option::none<0x2::object::ID>(), v3, v5.left, 0x2::balance::value<0x2::sui::SUI>(&v6), 1);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::send(v6, v3, arg2);
    }

    public fun revoke<T0>(arg0: Offer<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg1) == arg0.maker, 306);
        let Offer {
            id      : v0,
            escrow  : v1,
            terms   : v2,
            maker   : v3,
            version : _,
        } = arg0;
        let v5 = v2;
        let v6 = v1;
        0x2::object::delete(v0);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::events::offer_closed(0x2::object::id<Offer<T0>>(&arg0), 0x1::option::none<0x2::object::ID>(), v3, v5.left, 0x2::balance::value<0x2::sui::SUI>(&v6), 0);
        0x2::coin::from_balance<0x2::sui::SUI>(v6, arg1)
    }

    public fun scope_any() : u8 {
        0
    }

    public fun scope_item() : u8 {
        1
    }

    public fun scope_set() : u8 {
        2
    }

    public fun terms<T0>(arg0: &Offer<T0>) : Terms {
        arg0.terms
    }

    public fun unit_fee(arg0: &Terms) : u64 {
        arg0.fee
    }

    public fun unit_price(arg0: &Terms) : u64 {
        arg0.each
    }

    public fun unit_reserve(arg0: &Terms) : u64 {
        arg0.reserve
    }

    public fun units_left(arg0: &Terms) : u64 {
        arg0.left
    }

    // decompiled from Move bytecode v7
}

