module 0x40e0c95f73af329e7a6a8eafee9d152a1f3090736d35052842288232f7eb5968::blast_fun_otc {
    struct Offer<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        maker: address,
        taker: 0x1::option::Option<address>,
        partial_fills: bool,
        offered_amount: u64,
        wanted_amount: u64,
    }

    struct OfferCreated has copy, drop {
        offer_id: 0x2::object::ID,
        offered_type: 0x1::type_name::TypeName,
        wanted_type: 0x1::type_name::TypeName,
        taker: 0x1::option::Option<address>,
        partial_fills: bool,
        offered_amount: u64,
        wanted_amount: u64,
    }

    struct OfferTaken has copy, drop {
        offer_id: 0x2::object::ID,
        amount: u64,
        paid: u64,
    }

    struct OfferCanceled has copy, drop {
        offer_id: 0x2::object::ID,
        refund: u64,
    }

    public fun new<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: 0x1::option::Option<address>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : Offer<T0, T1> {
        let v0 = &arg2;
        assert!(0x1::option::is_none<address>(v0) || *0x1::option::borrow<address>(v0) != @0x0, 13835058300095299585);
        let v1 = 0x2::coin::value<T0>(&arg0);
        assert!(v1 > 0, 13835339783662075907);
        assert!(arg1 > 0, 13835621262933884933);
        let v2 = 0x1::type_name::with_original_ids<T0>();
        let v3 = 0x1::type_name::with_original_ids<T1>();
        assert!(v2 != v3, 13837310125679837201);
        let v4 = Offer<T0, T1>{
            id             : 0x2::object::new(arg4),
            balance        : 0x2::coin::into_balance<T0>(arg0),
            maker          : 0x2::tx_context::sender(arg4),
            taker          : arg2,
            partial_fills  : arg3,
            offered_amount : v1,
            wanted_amount  : arg1,
        };
        let v5 = OfferCreated{
            offer_id       : 0x2::object::uid_to_inner(&v4.id),
            offered_type   : v2,
            wanted_type    : v3,
            taker          : arg2,
            partial_fills  : arg3,
            offered_amount : v1,
            wanted_amount  : arg1,
        };
        0x2::event::emit<OfferCreated>(v5);
        v4
    }

    public fun cancel<T0, T1>(arg0: Offer<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.maker == 0x2::tx_context::sender(arg1), 13837028921285935119);
        let Offer {
            id             : v0,
            balance        : v1,
            maker          : _,
            taker          : _,
            partial_fills  : _,
            offered_amount : _,
            wanted_amount  : _,
        } = arg0;
        let v7 = v1;
        let v8 = v0;
        let v9 = OfferCanceled{
            offer_id : 0x2::object::uid_to_inner(&v8),
            refund   : 0x2::balance::value<T0>(&v7),
        };
        0x2::event::emit<OfferCanceled>(v9);
        0x2::object::delete(v8);
        0x2::coin::from_balance<T0>(v7, arg1)
    }

    public fun share<T0, T1>(arg0: Offer<T0, T1>) {
        0x2::transfer::share_object<Offer<T0, T1>>(arg0);
    }

    public fun take<T0, T1>(arg0: &mut Offer<T0, T1>, arg1: u64, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = &arg0.taker;
        assert!(0x1::option::is_none<address>(v0) || *0x1::option::borrow<address>(v0) == 0x2::tx_context::sender(arg3), 13835902918299353095);
        assert!(arg1 > 0, 13836184397571162121);
        assert!(arg1 <= 0x2::balance::value<T0>(&arg0.balance), 13836465876842971147);
        assert!(arg0.partial_fills || arg1 == 0x2::balance::value<T0>(&arg0.balance), 13836747356114780173);
        let v1 = 0x1::u64::mul_div_ceil(arg1, arg0.wanted_amount, arg0.offered_amount);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(arg2, v1, arg3), arg0.maker);
        let v2 = OfferTaken{
            offer_id : 0x2::object::uid_to_inner(&arg0.id),
            amount   : arg1,
            paid     : v1,
        };
        0x2::event::emit<OfferTaken>(v2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg3)
    }

    // decompiled from Move bytecode v7
}

