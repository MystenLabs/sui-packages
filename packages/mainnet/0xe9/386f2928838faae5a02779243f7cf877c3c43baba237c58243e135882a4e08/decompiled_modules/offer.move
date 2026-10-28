module 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer {
    struct Terms has copy, drop, store {
        kind: 0x1::type_name::TypeName,
        price: u64,
        fee: u64,
        reserve: u64,
        units: u64,
        ends_ms: 0x1::option::Option<u64>,
        item: 0x1::option::Option<0x2::object::ID>,
        root: 0x1::option::Option<vector<u8>>,
        dest: 0x1::option::Option<0x2::object::ID>,
    }

    struct Offer<phantom T0> has key {
        id: 0x2::object::UID,
        rev: u64,
        maker: address,
        terms: Terms,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Hit has copy, drop {
        item: 0x2::object::ID,
        royalty: u64,
        refund: u64,
        seller_kiosk: 0x1::option::Option<0x2::object::ID>,
        dest: 0x1::option::Option<0x2::object::ID>,
    }

    fun admit<T0>(arg0: &Terms, arg1: 0x2::object::ID, arg2: &vector<vector<u8>>, arg3: &0x2::clock::Clock) {
        assert!(arg0.kind == 0x1::type_name::with_defining_ids<T0>(), 45);
        assert!(arg0.units != 0, 25);
        assert!(!lapsed(arg0, arg3), 23);
        let v0 = &arg0.item;
        if (0x1::option::is_some<0x2::object::ID>(v0)) {
            assert!(*0x1::option::borrow<0x2::object::ID>(v0) == arg1, 43);
        };
        let v1 = &arg0.root;
        if (0x1::option::is_some<vector<u8>>(v1)) {
            assert!(0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::merkle::contains(0x1::option::borrow<vector<u8>>(v1), arg1, arg2), 44);
        };
    }

    public(friend) fun announce(arg0: 0x2::object::ID, arg1: 0x1::option::Option<0x2::object::ID>, arg2: address, arg3: &Terms) {
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::events::bid_posted(arg0, arg1, arg2, arg3.kind, arg3.item, arg3.root, arg3.price, arg3.fee, arg3.reserve, arg3.units, arg3.ends_ms, arg3.dest);
    }

    fun dissolve<T0>(arg0: Offer<T0>) : (0x2::object::ID, address, u64, 0x2::balance::Balance<0x2::sui::SUI>) {
        let Offer {
            id    : v0,
            rev   : _,
            maker : v2,
            terms : v3,
            funds : v4,
        } = arg0;
        let v5 = v3;
        let v6 = v0;
        0x2::object::delete(v6);
        (0x2::object::uid_to_inner(&v6), v2, v5.units, v4)
    }

    public(friend) fun draft_terms<T0>(arg0: &0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::Config, arg1: 0x1::option::Option<0x2::object::ID>, arg2: 0x1::option::Option<vector<u8>>, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<0x2::object::ID>, arg8: &0x2::clock::Clock) : Terms {
        assert!(arg3 != 0, 40);
        assert!(arg4 != 0, 41);
        let v0 = 0x1::option::is_some<0x2::object::ID>(&arg1) && 0x1::option::is_some<vector<u8>>(&arg2);
        assert!(!v0, 42);
        if (0x1::option::is_some<0x2::object::ID>(&arg1)) {
            assert!(arg4 == 1, 42);
        };
        let v1 = &arg2;
        if (0x1::option::is_some<vector<u8>>(v1)) {
            assert!(0x1::vector::length<u8>(0x1::option::borrow<vector<u8>>(v1)) == 32, 42);
        };
        let v2 = &arg6;
        if (0x1::option::is_some<u64>(v2)) {
            assert!(*0x1::option::borrow<u64>(v2) > 0x2::clock::timestamp_ms(arg8), 64);
        };
        Terms{
            kind    : 0x1::type_name::with_defining_ids<T0>(),
            price   : arg3,
            fee     : 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::fee_of(arg3, 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::offer_bps(arg0)),
            reserve : arg5,
            units   : arg4,
            ends_ms : arg6,
            item    : arg1,
            root    : arg2,
            dest    : arg7,
        }
    }

    public fun escrowed<T0>(arg0: &Offer<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.funds)
    }

    public fun fill<T0: store + key>(arg0: &mut Offer<T0>, arg1: &0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::Config, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg7: vector<vector<u8>>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::transfer_policy::TransferRequest<T0>) {
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::gate_rev(arg0.rev);
        let v0 = &mut arg0.terms;
        let v1 = &mut arg0.funds;
        let (v2, v3, v4) = fill_from_kiosk<T0>(v0, v1, arg0.maker, arg1, arg2, arg3, arg4, arg5, arg6, &arg7, arg8, arg9);
        let v5 = v4;
        record_hit(0x2::object::id<Offer<T0>>(arg0), 0x1::option::none<0x2::object::ID>(), arg0.maker, &arg0.terms, &v5, arg9);
        (v2, v3)
    }

    public(friend) fun fill_from_kiosk<T0: store + key>(arg0: &mut Terms, arg1: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg2: address, arg3: &0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::Config, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::object::ID, arg7: &mut 0x2::kiosk::Kiosk, arg8: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg9: &vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::transfer_policy::TransferRequest<T0>, Hit) {
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::gate(arg3);
        admit<T0>(arg0, arg6, arg9, arg10);
        let v0 = 0x2::object::id<0x2::kiosk::Kiosk>(arg7);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.dest), 48);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.dest, &v0), 49);
        let v1 = 0x2::balance::split<0x2::sui::SUI>(arg1, unit_cost(arg0));
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::pay_out(0x2::balance::split<0x2::sui::SUI>(&mut v1, arg0.fee), 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::treasury(arg3), arg11);
        let v2 = arg0.price;
        let (v3, v4) = 0x2::kiosk::purchase_with_cap<T0>(arg4, 0x2::kiosk::list_with_purchase_cap<T0>(arg4, arg5, arg6, v2, arg11), 0x2::coin::take<0x2::sui::SUI>(&mut v1, v2, arg11));
        let v5 = v4;
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::courier::deliver<T0>(arg7, arg2, v3, arg8);
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::pay_out(v1, arg2, arg11);
        arg0.units = arg0.units - 1;
        let v6 = Hit{
            item         : arg6,
            royalty      : 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::clearing::clear<T0>(arg8, &mut v5, arg7, &mut v1, arg11),
            refund       : 0x2::balance::value<0x2::sui::SUI>(&v1),
            seller_kiosk : 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::kiosk::Kiosk>(arg4)),
            dest         : 0x1::option::some<0x2::object::ID>(v0),
        };
        (0x2::kiosk::withdraw(arg4, arg5, 0x1::option::some<u64>(v2), arg11), v5, v6)
    }

    public(friend) fun fill_from_wallet<T0: store + key>(arg0: &mut Terms, arg1: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg2: address, arg3: &0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::Config, arg4: T0, arg5: &vector<vector<u8>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, Hit) {
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::gate(arg3);
        let v0 = 0x2::object::id<T0>(&arg4);
        admit<T0>(arg0, v0, arg5, arg6);
        let v1 = 0x2::balance::split<0x2::sui::SUI>(arg1, unit_cost(arg0));
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::pay_out(0x2::balance::split<0x2::sui::SUI>(&mut v1, arg0.fee), 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::treasury(arg3), arg7);
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::pay_out(v1, arg2, arg7);
        0x2::transfer::public_transfer<T0>(arg4, arg2);
        arg0.units = arg0.units - 1;
        let v2 = Hit{
            item         : v0,
            royalty      : 0,
            refund       : 0x2::balance::value<0x2::sui::SUI>(&v1),
            seller_kiosk : 0x1::option::none<0x2::object::ID>(),
            dest         : 0x1::option::none<0x2::object::ID>(),
        };
        (0x2::coin::take<0x2::sui::SUI>(&mut v1, arg0.price, arg7), v2)
    }

    public fun fill_owned<T0: store + key>(arg0: &mut Offer<T0>, arg1: &0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::Config, arg2: T0, arg3: vector<vector<u8>>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::gate_rev(arg0.rev);
        let v0 = &mut arg0.terms;
        let v1 = &mut arg0.funds;
        let (v2, v3) = fill_from_wallet<T0>(v0, v1, arg0.maker, arg1, arg2, &arg3, arg4, arg5);
        let v4 = v3;
        record_hit(0x2::object::id<Offer<T0>>(arg0), 0x1::option::none<0x2::object::ID>(), arg0.maker, &arg0.terms, &v4, arg5);
        v2
    }

    public(friend) fun is_over(arg0: &Terms, arg1: &0x2::clock::Clock) : bool {
        arg0.units == 0 || lapsed(arg0, arg1)
    }

    public(friend) fun lapsed(arg0: &Terms, arg1: &0x2::clock::Clock) : bool {
        let v0 = &arg0.ends_ms;
        0x1::option::is_some<u64>(v0) && 0x2::clock::timestamp_ms(arg1) >= *0x1::option::borrow<u64>(v0)
    }

    public fun maker<T0>(arg0: &Offer<T0>) : address {
        arg0.maker
    }

    public fun place<T0: store + key>(arg0: &0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::Config, arg1: 0x1::option::Option<0x2::object::ID>, arg2: 0x1::option::Option<vector<u8>>, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<0x2::object::ID>, arg8: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::gate(arg0);
        let v0 = draft_terms<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9);
        let v1 = total_cost(&v0);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg8) >= v1, 30);
        let v2 = Offer<T0>{
            id    : 0x2::object::new(arg10),
            rev   : 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::rev(),
            maker : 0x2::tx_context::sender(arg10),
            terms : v0,
            funds : 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg8), v1),
        };
        let v3 = 0x2::object::id<Offer<T0>>(&v2);
        announce(v3, 0x1::option::none<0x2::object::ID>(), v2.maker, &v2.terms);
        0x2::transfer::share_object<Offer<T0>>(v2);
        v3
    }

    public(friend) fun record_hit(arg0: 0x2::object::ID, arg1: 0x1::option::Option<0x2::object::ID>, arg2: address, arg3: &Terms, arg4: &Hit, arg5: &0x2::tx_context::TxContext) {
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::events::bid_filled(arg0, arg1, arg2, 0x2::tx_context::sender(arg5), arg4.item, arg3.kind, arg3.price, arg3.fee, arg4.royalty, arg4.refund, arg3.units, arg4.seller_kiosk, arg4.dest);
    }

    public fun retire<T0>(arg0: Offer<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_over(&arg0.terms, arg1), 24);
        let (v0, v1, v2, v3) = dissolve<T0>(arg0);
        let v4 = v3;
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::events::bid_closed(v0, 0x1::option::none<0x2::object::ID>(), v1, v2, 0x2::balance::value<0x2::sui::SUI>(&v4), 2);
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::pay_out(v4, v1, arg2);
    }

    public fun revoke<T0>(arg0: Offer<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.maker == 0x2::tx_context::sender(arg1), 10);
        let (v0, v1, v2, v3) = dissolve<T0>(arg0);
        let v4 = v3;
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::events::bid_closed(v0, 0x1::option::none<0x2::object::ID>(), v1, v2, 0x2::balance::value<0x2::sui::SUI>(&v4), 1);
        0x2::coin::from_balance<0x2::sui::SUI>(v4, arg1)
    }

    public fun target_item(arg0: &Terms) : 0x1::option::Option<0x2::object::ID> {
        arg0.item
    }

    public fun target_root(arg0: &Terms) : 0x1::option::Option<vector<u8>> {
        arg0.root
    }

    public fun terms<T0>(arg0: &Offer<T0>) : Terms {
        arg0.terms
    }

    public(friend) fun total_cost(arg0: &Terms) : u64 {
        arg0.units * unit_cost(arg0)
    }

    public(friend) fun unit_cost(arg0: &Terms) : u64 {
        arg0.price + arg0.fee + arg0.reserve
    }

    public fun unit_fee(arg0: &Terms) : u64 {
        arg0.fee
    }

    public fun unit_price(arg0: &Terms) : u64 {
        arg0.price
    }

    public fun unit_reserve(arg0: &Terms) : u64 {
        arg0.reserve
    }

    public fun units_left(arg0: &Terms) : u64 {
        arg0.units
    }

    // decompiled from Move bytecode v7
}

