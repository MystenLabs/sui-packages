module 0x5823cad42a132d52accea7b1413e8c911d9d63167f55dcd01774eaadee4d1ade::atlansui {
    struct ATLANSUI has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Collection<phantom T0, phantom T1: store + key> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        offers: 0x2::vec_map::VecMap<address, Offers>,
        interest: u64,
        name: 0x1::ascii::String,
        url: 0x1::ascii::String,
        loan_duration: u64,
        best_offer_value: u64,
        best_offer_user: 0x1::option::Option<address>,
        best_idx: u64,
    }

    struct Offers has store, key {
        id: 0x2::object::UID,
        counter: u64,
        offers: 0x2::object_table::ObjectTable<u64, Offer>,
    }

    struct Offer has store, key {
        id: 0x2::object::UID,
        collection: 0x1::ascii::String,
        borrower: 0x1::option::Option<address>,
        creator: address,
        start_time: u64,
        value: u64,
        is_started: bool,
        is_repayment: bool,
        is_claimed: bool,
    }

    struct Platform has key {
        id: 0x2::object::UID,
        fee_bps: u64,
        fee_recipient: address,
        total_pools: u64,
    }

    struct CreateOfferEvent<phantom T0: store + key> has copy, drop {
        id: 0x2::object::ID,
        key: u64,
        collection: 0x1::ascii::String,
        creator: address,
        value: u64,
        time: u64,
    }

    struct CreateCollectionEvent has copy, drop {
        id: 0x2::object::ID,
        interest: u64,
        name: 0x1::ascii::String,
        url: 0x1::ascii::String,
        time: u64,
    }

    struct CancelOfferEvent has copy, drop {
        id: 0x2::object::ID,
        collection: 0x1::ascii::String,
        creator: address,
        time: u64,
    }

    struct AcceptOfferEvent<phantom T0: store + key> has copy, drop {
        offer_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        creator: address,
        borrower: address,
        value: u64,
        time: u64,
    }

    struct RepaymentEvent has copy, drop {
        offer_id: 0x2::object::ID,
        creator: address,
        borrower: address,
        value: u64,
        time: u64,
    }

    struct ClaimOfferEvent has copy, drop {
        offer_id: 0x2::object::ID,
        creator: address,
        interest_value: u64,
        time: u64,
    }

    public fun accept_offer_with_nft<T0, T1: store + key>(arg0: &mut Platform, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: T1, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 2);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Collection<T0, T1>>(&mut arg0.id, arg1);
        if (0x1::option::contains<address>(&v1.best_offer_user, &arg2) && v1.best_idx == arg3) {
            v1.best_offer_value = 0;
            let v2 = 0x2::vec_map::keys<address, Offers>(&v1.offers);
            while (0x1::vector::length<address>(&v2) > 0) {
                let v3 = 0x1::vector::pop_back<address>(&mut v2);
                let v4 = 0x2::vec_map::get<address, Offers>(&v1.offers, &v3);
                let v5 = 0;
                while (v5 < v4.counter) {
                    if (arg2 != v3 || arg3 != v5) {
                        if (0x2::object_table::contains<u64, Offer>(&v4.offers, v5)) {
                            let v6 = 0x2::object_table::borrow<u64, Offer>(&v4.offers, v5);
                            if (!v6.is_started && v6.value > v1.best_offer_value) {
                                v1.best_offer_value = v6.value;
                                if (0x1::option::is_none<address>(&v1.best_offer_user)) {
                                    0x1::option::fill<address>(&mut v1.best_offer_user, v6.creator);
                                } else {
                                    0x1::option::swap<address>(&mut v1.best_offer_user, v6.creator);
                                };
                                v1.best_idx = v5;
                            };
                        };
                    };
                    v5 = v5 + 1;
                };
            };
        };
        let v7 = 0x2::vec_map::get_mut<address, Offers>(&mut v1.offers, &arg2);
        assert!(v7.counter > arg3, 104);
        let v8 = 0x2::object_table::borrow_mut<u64, Offer>(&mut v7.offers, arg3);
        assert!(!v8.is_started, 103);
        0x2::dynamic_object_field::add<bool, T1>(&mut v8.id, true, arg4);
        v8.start_time = 0x2::clock::timestamp_ms(arg5);
        v8.is_started = true;
        0x1::option::fill<address>(&mut v8.borrower, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v1.balance, v8.value, arg6), v0);
        let v9 = AcceptOfferEvent<Collection<T0, T1>>{
            offer_id : 0x2::object::id<Offer>(v8),
            nft_id   : 0x2::object::id<T1>(&arg4),
            creator  : v8.creator,
            borrower : v0,
            value    : v8.value,
            time     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<AcceptOfferEvent<Collection<T0, T1>>>(v9);
    }

    public fun cancel_offer<T0, T1: store + key>(arg0: &mut Platform, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 2);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Collection<T0, T1>>(&mut arg0.id, arg1);
        let v2 = 0x2::vec_map::get_mut<address, Offers>(&mut v1.offers, &v0);
        assert!(v2.counter > arg2, 104);
        let v3 = 0x2::object_table::remove<u64, Offer>(&mut v2.offers, arg2);
        assert!(v3.creator == v0, 401);
        assert!(!v3.is_started, 103);
        let Offer {
            id           : v4,
            collection   : v5,
            borrower     : _,
            creator      : v7,
            start_time   : _,
            value        : v9,
            is_started   : _,
            is_repayment : _,
            is_claimed   : _,
        } = v3;
        0x2::object::delete(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v1.balance, v9, arg4), v0);
        if (0x1::option::contains<address>(&v1.best_offer_user, &v0) && v1.best_idx == arg2) {
            v1.best_offer_value = 0;
            let v13 = 0x2::vec_map::keys<address, Offers>(&v1.offers);
            while (0x1::vector::length<address>(&v13) > 0) {
                let v14 = 0x1::vector::pop_back<address>(&mut v13);
                let v15 = 0x2::vec_map::get<address, Offers>(&v1.offers, &v14);
                let v16 = 0;
                while (v16 < v15.counter) {
                    if (0x2::object_table::contains<u64, Offer>(&v15.offers, v16)) {
                        let v17 = 0x2::object_table::borrow<u64, Offer>(&v15.offers, v16);
                        if (!v17.is_started && v17.value > v1.best_offer_value) {
                            v1.best_offer_value = v17.value;
                            if (0x1::option::is_none<address>(&v1.best_offer_user)) {
                                0x1::option::fill<address>(&mut v1.best_offer_user, v17.creator);
                            } else {
                                0x1::option::swap<address>(&mut v1.best_offer_user, v17.creator);
                            };
                            v1.best_idx = v16;
                        };
                    };
                    v16 = v16 + 1;
                };
            };
        };
        let v18 = CancelOfferEvent{
            id         : 0x2::object::id<Offer>(&v3),
            collection : v5,
            creator    : v7,
            time       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CancelOfferEvent>(v18);
    }

    public entry fun change_fee_bps(arg0: &mut Platform, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 < 10000, 3);
        arg0.fee_bps = arg2;
    }

    public entry fun change_fee_recipient(arg0: &mut Platform, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.fee_recipient = arg2;
    }

    public entry fun change_interest<T0, T1: store + key>(arg0: &mut Platform, arg1: 0x2::object::ID, arg2: &AdminCap, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Collection<T0, T1>>(&mut arg0.id, arg1).interest = arg3;
    }

    public entry fun change_loan_duration<T0, T1: store + key>(arg0: &mut Platform, arg1: 0x2::object::ID, arg2: &AdminCap, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Collection<T0, T1>>(&mut arg0.id, arg1).loan_duration = arg3;
    }

    public fun claim_offer<T0, T1: store + key>(arg0: &mut Platform, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 2);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Collection<T0, T1>>(&mut arg0.id, arg1);
        let v2 = 0x2::vec_map::get_mut<address, Offers>(&mut v1.offers, &v0);
        assert!(v2.counter > arg2, 104);
        let v3 = 0x2::object_table::borrow_mut<u64, Offer>(&mut v2.offers, arg2);
        assert!(v3.creator == v0, 401);
        assert!(v3.collection == v1.name, 107);
        assert!(v3.is_started, 105);
        assert!(!v3.is_repayment, 600);
        assert!(!v3.is_claimed, 601);
        assert!(v3.start_time + v1.loan_duration < 0x2::clock::timestamp_ms(arg3), 106);
        if (0x2::dynamic_object_field::exists_<bool>(&v3.id, true)) {
            0x2::transfer::public_transfer<T1>(0x2::dynamic_object_field::remove<bool, T1>(&mut v3.id, true), v0);
        };
        v3.is_claimed = true;
        let v4 = ClaimOfferEvent{
            offer_id       : 0x2::object::id<Offer>(v3),
            creator        : v3.creator,
            interest_value : mul_div(mul_div(v1.loan_duration, mul_div(v1.interest, 10000000, 365) / 86400, 1000), v3.value, 1000000000),
            time           : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ClaimOfferEvent>(v4);
    }

    public fun create_collection<T0, T1: store + key>(arg0: &mut Platform, arg1: &AdminCap, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, arg2), 1);
        let v0 = Collection<T0, T1>{
            id               : 0x2::object::new(arg7),
            balance          : 0x2::balance::zero<T0>(),
            offers           : 0x2::vec_map::empty<address, Offers>(),
            interest         : arg5,
            name             : arg2,
            url              : arg3,
            loan_duration    : arg4,
            best_offer_value : 0,
            best_offer_user  : 0x1::option::none<address>(),
            best_idx         : 0,
        };
        let v1 = 0x2::object::id<Collection<T0, T1>>(&v0);
        0x2::dynamic_object_field::add<0x2::object::ID, Collection<T0, T1>>(&mut arg0.id, v1, v0);
        arg0.total_pools = arg0.total_pools + 1;
        let v2 = CreateCollectionEvent{
            id       : v1,
            interest : arg5,
            name     : arg2,
            url      : arg3,
            time     : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<CreateCollectionEvent>(v2);
    }

    public fun create_offer<T0, T1: store + key>(arg0: &mut Platform, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 2);
        assert!(arg3 <= 0x2::coin::value<T0>(&arg2), 201);
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Collection<T0, T1>>(&mut arg0.id, arg1);
        if (!0x2::vec_map::contains<address, Offers>(&v2.offers, &v1)) {
            let v3 = Offers{
                id      : 0x2::object::new(arg5),
                counter : 0,
                offers  : 0x2::object_table::new<u64, Offer>(arg5),
            };
            0x2::vec_map::insert<address, Offers>(&mut v2.offers, v1, v3);
        };
        let v4 = 0x2::vec_map::get_mut<address, Offers>(&mut v2.offers, &v1);
        let v5 = Offer{
            id           : 0x2::object::new(arg5),
            collection   : v2.name,
            borrower     : 0x1::option::none<address>(),
            creator      : v1,
            start_time   : 0,
            value        : arg3,
            is_started   : false,
            is_repayment : false,
            is_claimed   : false,
        };
        0x2::object_table::add<u64, Offer>(&mut v4.offers, v4.counter, v5);
        if (arg3 > v2.best_offer_value) {
            v2.best_offer_value = arg3;
            if (0x1::option::is_none<address>(&v2.best_offer_user)) {
                0x1::option::fill<address>(&mut v2.best_offer_user, v1);
            } else {
                0x1::option::swap<address>(&mut v2.best_offer_user, v1);
            };
            v2.best_idx = v4.counter;
        };
        v4.counter = v4.counter + 1;
        let v6 = 0x2::coin::into_balance<T0>(arg2);
        if (v0 > arg3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v6, v0 - arg3, arg5), v1);
        };
        0x2::balance::join<T0>(&mut v2.balance, v6);
        let v7 = CreateOfferEvent<Collection<T0, T1>>{
            id         : 0x2::object::id<Offer>(&v5),
            key        : v4.counter - 1,
            collection : v2.name,
            creator    : v1,
            value      : arg3,
            time       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<CreateOfferEvent<Collection<T0, T1>>>(v7);
    }

    fun init(arg0: ATLANSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::package::claim_and_keep<ATLANSUI>(arg0, arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = Platform{
            id            : 0x2::object::new(arg1),
            fee_bps       : 1000,
            fee_recipient : v0,
            total_pools   : 0,
        };
        0x2::transfer::share_object<Platform>(v2);
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 500);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(!(v0 > (18446744073709551615 as u128)), 501);
        (v0 as u64)
    }

    public fun repayment_offer<T0, T1: store + key>(arg0: &mut Platform, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 2);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Collection<T0, T1>>(&mut arg0.id, arg1);
        let v2 = 0x2::vec_map::get_mut<address, Offers>(&mut v1.offers, &arg2);
        assert!(v2.counter > arg3, 104);
        let v3 = 0x2::object_table::borrow_mut<u64, Offer>(&mut v2.offers, arg3);
        assert!(0x2::dynamic_object_field::exists_<bool>(&v3.id, true), 501);
        assert!(0x1::option::contains<address>(&v3.borrower, &v0), 401);
        let v4 = 0x2::clock::timestamp_ms(arg5);
        assert!(v3.is_started, 105);
        assert!(v3.start_time + v1.loan_duration > v4, 108);
        let v5 = mul_div(mul_div(v4 - v3.start_time, mul_div(v1.interest, 10000000, 365) / 86400, 1000), v3.value, 1000000000);
        let v6 = mul_div(v5, arg0.fee_bps, 10000);
        let v7 = v3.value + v5;
        assert!(0x2::coin::value<T0>(&arg4) >= v7, 202);
        0x2::pay::split_and_transfer<T0>(&mut arg4, v6, arg0.fee_recipient, arg6);
        0x2::pay::split_and_transfer<T0>(&mut arg4, v7 - v6, v3.creator, arg6);
        v3.is_repayment = true;
        if (0x2::coin::value<T0>(&arg4) > 0) {
            0x2::pay::keep<T0>(arg4, arg6);
        } else {
            0x2::coin::destroy_zero<T0>(arg4);
        };
        0x2::transfer::public_transfer<T1>(0x2::dynamic_object_field::remove<bool, T1>(&mut v3.id, true), v0);
        let v8 = RepaymentEvent{
            offer_id : 0x2::object::id<Offer>(v3),
            creator  : v3.creator,
            borrower : v0,
            value    : v5,
            time     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<RepaymentEvent>(v8);
    }

    // decompiled from Move bytecode v6
}

