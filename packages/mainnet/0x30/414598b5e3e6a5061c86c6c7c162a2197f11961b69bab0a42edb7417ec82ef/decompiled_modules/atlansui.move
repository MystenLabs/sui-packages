module 0x30414598b5e3e6a5061c86c6c7c162a2197f11961b69bab0a42edb7417ec82ef::atlansui {
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
        item_id: 0x1::option::Option<0x2::object::ID>,
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

    struct Rentables has drop {
        dummy_field: bool,
    }

    struct Rented has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct Promise {
        item: Rented,
        duration: u64,
        start_date: u64,
        borrower_kiosk: 0x2::object::ID,
    }

    struct Rentable<T0: store + key> has store {
        object: T0,
        duration: u64,
        start_date: u64,
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
        borrower_kiosk: 0x2::object::ID,
        borrower_kiosk_cap: 0x2::object::ID,
        value: u64,
        time: u64,
    }

    struct RepaymentEvent has copy, drop {
        offer_id: 0x2::object::ID,
        creator: address,
        borrower: address,
        borrower_kiosk: 0x2::object::ID,
        value: u64,
        time: u64,
    }

    struct ClaimOfferEvent has copy, drop {
        offer_id: 0x2::object::ID,
        creator: address,
        interest_value: u64,
        time: u64,
    }

    public fun borrow<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : &T0 {
        assert!(0x2::kiosk::has_access(arg0, arg1), 4);
        let v0 = Rentables{dummy_field: false};
        let v1 = Rented{id: arg2};
        &0x2::bag::borrow<Rented, Rentable<T0>>(0x2::kiosk_extension::storage<Rentables>(v0, arg0), v1).object
    }

    public entry fun remove(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk_extension::remove<Rentables>(arg0, arg1);
    }

    public fun accept_offer_with_nft<T0, T1: store + key>(arg0: &mut Platform, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: T1, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 2);
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Collection<T0, T1>>(&mut arg0.id, arg1);
        if (0x1::option::contains<address>(&v2.best_offer_user, &arg2) && v2.best_idx == arg3) {
            v2.best_offer_value = 0;
            let v3 = 0x2::vec_map::keys<address, Offers>(&v2.offers);
            while (0x1::vector::length<address>(&v3) > 0) {
                let v4 = 0x1::vector::pop_back<address>(&mut v3);
                let v5 = 0x2::vec_map::get<address, Offers>(&v2.offers, &v4);
                let v6 = 0;
                while (v6 < v5.counter) {
                    if (arg2 != v4 || arg3 != v6) {
                        if (0x2::object_table::contains<u64, Offer>(&v5.offers, v6)) {
                            let v7 = 0x2::object_table::borrow<u64, Offer>(&v5.offers, v6);
                            if (!v7.is_started && v7.value > v2.best_offer_value) {
                                v2.best_offer_value = v7.value;
                                0x1::option::swap_or_fill<address>(&mut v2.best_offer_user, v7.creator);
                                v2.best_idx = v6;
                            };
                        };
                    };
                    v6 = v6 + 1;
                };
            };
        };
        let v8 = 0x2::vec_map::get_mut<address, Offers>(&mut v2.offers, &arg2);
        assert!(v8.counter > arg3, 104);
        let v9 = 0x2::object_table::borrow_mut<u64, Offer>(&mut v8.offers, arg3);
        assert!(!v9.is_started, 103);
        let (v10, v11) = 0x2::kiosk::new(arg6);
        let v12 = v11;
        let v13 = v10;
        let v14 = &mut v13;
        install(v14, &v12, arg6);
        let v15 = 0x2::object::id<T1>(&arg4);
        let v16 = Rentable<T1>{
            object     : arg4,
            duration   : v2.loan_duration,
            start_date : v1,
        };
        let v17 = &mut v13;
        let v18 = Rented{id: v15};
        place_in_bag<T1, Rented>(v17, v18, v16);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v12, v0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v13);
        v9.start_time = v1;
        v9.is_started = true;
        0x1::option::fill<address>(&mut v9.borrower, v0);
        0x1::option::fill<0x2::object::ID>(&mut v9.item_id, v15);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v2.balance, v9.value, arg6), v0);
        let v19 = AcceptOfferEvent<Collection<T0, T1>>{
            offer_id           : 0x2::object::id<Offer>(v9),
            nft_id             : v15,
            creator            : v9.creator,
            borrower           : v0,
            borrower_kiosk     : 0x2::object::id<0x2::kiosk::Kiosk>(&v13),
            borrower_kiosk_cap : 0x2::object::id<0x2::kiosk::KioskOwnerCap>(&v12),
            value              : v9.value,
            time               : v1,
        };
        0x2::event::emit<AcceptOfferEvent<Collection<T0, T1>>>(v19);
    }

    public fun borrow_val<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (T0, Promise) {
        assert!(0x2::kiosk::has_access(arg0, arg1), 4);
        let v0 = 0x2::object::id<0x2::kiosk::Kiosk>(arg0);
        let v1 = Rented{id: arg2};
        let v2 = take_from_bag<T0, Rented>(arg0, v1);
        assert!(v2.start_date + v2.duration > 0x2::clock::timestamp_ms(arg3), 108);
        let v3 = Rented{id: arg2};
        let v4 = Promise{
            item           : v3,
            duration       : v2.duration,
            start_date     : v2.start_date,
            borrower_kiosk : v0,
        };
        let Rentable {
            object     : v5,
            duration   : _,
            start_date : _,
        } = v2;
        (v5, v4)
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
            item_id      : _,
            creator      : v8,
            start_time   : _,
            value        : v10,
            is_started   : _,
            is_repayment : _,
            is_claimed   : _,
        } = v3;
        0x2::object::delete(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v1.balance, v10, arg4), v0);
        if (0x1::option::contains<address>(&v1.best_offer_user, &v0) && v1.best_idx == arg2) {
            v1.best_offer_value = 0;
            let v14 = 0x2::vec_map::keys<address, Offers>(&v1.offers);
            while (0x1::vector::length<address>(&v14) > 0) {
                let v15 = 0x1::vector::pop_back<address>(&mut v14);
                let v16 = 0x2::vec_map::get<address, Offers>(&v1.offers, &v15);
                let v17 = 0;
                while (v17 < v16.counter) {
                    if (0x2::object_table::contains<u64, Offer>(&v16.offers, v17)) {
                        let v18 = 0x2::object_table::borrow<u64, Offer>(&v16.offers, v17);
                        if (!v18.is_started && v18.value > v1.best_offer_value) {
                            v1.best_offer_value = v18.value;
                            0x1::option::swap_or_fill<address>(&mut v1.best_offer_user, v18.creator);
                            v1.best_idx = v17;
                        };
                    };
                    v17 = v17 + 1;
                };
            };
        };
        let v19 = CancelOfferEvent{
            id         : 0x2::object::id<Offer>(&v3),
            collection : v5,
            creator    : v8,
            time       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CancelOfferEvent>(v19);
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

    public fun claim_offer<T0, T1: store + key>(arg0: &mut Platform, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
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
        assert!(v3.start_time + v1.loan_duration < 0x2::clock::timestamp_ms(arg4), 106);
        let v4 = Rented{id: 0x1::option::extract<0x2::object::ID>(&mut v3.item_id)};
        let Rentable {
            object     : v5,
            duration   : _,
            start_date : _,
        } = take_from_bag<T1, Rented>(arg3, v4);
        0x2::transfer::public_transfer<T1>(v5, v0);
        v3.is_claimed = true;
        let v8 = ClaimOfferEvent{
            offer_id       : 0x2::object::id<Offer>(v3),
            creator        : v3.creator,
            interest_value : mul_div(mul_div(v1.loan_duration, mul_div(v1.interest, 10000000, 365) / 86400, 1000), v3.value, 1000000000),
            time           : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ClaimOfferEvent>(v8);
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
            item_id      : 0x1::option::none<0x2::object::ID>(),
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
            0x1::option::swap_or_fill<address>(&mut v2.best_offer_user, v1);
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

    public fun install(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Rentables{dummy_field: false};
        0x2::kiosk_extension::add<Rentables>(v0, arg0, arg1, 11, arg2);
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 500);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(!(v0 > (18446744073709551615 as u128)), 501);
        (v0 as u64)
    }

    fun place_in_bag<T0: store + key, T1: copy + drop + store>(arg0: &mut 0x2::kiosk::Kiosk, arg1: T1, arg2: Rentable<T0>) {
        let v0 = Rentables{dummy_field: false};
        0x2::bag::add<T1, Rentable<T0>>(0x2::kiosk_extension::storage_mut<Rentables>(v0, arg0), arg1, arg2);
    }

    public fun repayment_offer<T0, T1: store + key>(arg0: &mut Platform, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg4, arg5), 4);
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 2);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Collection<T0, T1>>(&mut arg0.id, arg1);
        let v2 = 0x2::vec_map::get_mut<address, Offers>(&mut v1.offers, &arg2);
        assert!(v2.counter > arg3, 104);
        let v3 = 0x2::object_table::borrow_mut<u64, Offer>(&mut v2.offers, arg3);
        assert!(0x1::option::contains<address>(&v3.borrower, &v0), 401);
        let v4 = 0x2::clock::timestamp_ms(arg7);
        assert!(v3.is_started, 105);
        assert!(v3.start_time + v1.loan_duration > v4, 108);
        let v5 = mul_div(mul_div(v4 - v3.start_time, mul_div(v1.interest, 10000000, 365) / 86400, 1000), v3.value, 1000000000);
        let v6 = mul_div(v5, arg0.fee_bps, 10000);
        let v7 = v3.value + v5;
        assert!(0x2::coin::value<T0>(&arg6) >= v7, 202);
        0x2::pay::split_and_transfer<T0>(&mut arg6, v6, arg0.fee_recipient, arg8);
        0x2::pay::split_and_transfer<T0>(&mut arg6, v7 - v6, v3.creator, arg8);
        v3.is_repayment = true;
        if (0x2::coin::value<T0>(&arg6) > 0) {
            0x2::pay::keep<T0>(arg6, arg8);
        } else {
            0x2::coin::destroy_zero<T0>(arg6);
        };
        let v8 = 0x2::object::id<0x2::kiosk::Kiosk>(arg4);
        let v9 = Rented{id: 0x1::option::extract<0x2::object::ID>(&mut v3.item_id)};
        let Rentable {
            object     : v10,
            duration   : _,
            start_date : _,
        } = take_from_bag<T1, Rented>(arg4, v9);
        0x2::transfer::public_transfer<T1>(v10, v0);
        let v13 = RepaymentEvent{
            offer_id       : 0x2::object::id<Offer>(v3),
            creator        : v3.creator,
            borrower       : v0,
            borrower_kiosk : v8,
            value          : v5,
            time           : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<RepaymentEvent>(v13);
    }

    public fun return_val<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: T0, arg2: Promise, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk_extension::is_installed<Rentables>(arg0), 0);
        let Promise {
            item           : v0,
            duration       : v1,
            start_date     : v2,
            borrower_kiosk : v3,
        } = arg2;
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg0) == v3, 5);
        let v4 = Rentable<T0>{
            object     : arg1,
            duration   : v1,
            start_date : v2,
        };
        place_in_bag<T0, Rented>(arg0, v0, v4);
    }

    fun take_from_bag<T0: store + key, T1: copy + drop + store>(arg0: &mut 0x2::kiosk::Kiosk, arg1: T1) : Rentable<T0> {
        let v0 = Rentables{dummy_field: false};
        let v1 = 0x2::kiosk_extension::storage_mut<Rentables>(v0, arg0);
        assert!(0x2::bag::contains<T1>(v1, arg1), 501);
        0x2::bag::remove<T1, Rentable<T0>>(v1, arg1)
    }

    // decompiled from Move bytecode v6
}

