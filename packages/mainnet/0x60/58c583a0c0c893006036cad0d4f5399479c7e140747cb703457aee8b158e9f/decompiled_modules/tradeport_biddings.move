module 0x53134eb544c5a0b5085e99efaf7eab13b28ad123de35d61f941f8c8c40b72033::tradeport_biddings {
    struct TRADEPORT_BIDDINGS has drop {
        dummy_field: bool,
    }

    struct Store has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        fee_bps: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        transfer_policies: 0x2::table::Table<0x1::ascii::String, bool>,
    }

    struct MultiBid has store, key {
        id: 0x2::object::UID,
        buyer: address,
        maybe_name: 0x1::option::Option<0x1::ascii::String>,
        bids: vector<0x2::object::ID>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct SingleBid has store, key {
        id: 0x2::object::UID,
        type: u64,
        buyer: address,
        maybe_multi_bid_id: 0x1::option::Option<0x2::object::ID>,
        nft_type: 0x1::ascii::String,
        maybe_nft_id: 0x1::option::Option<0x2::object::ID>,
        maybe_nft_bcs: 0x1::option::Option<vector<u8>>,
        maybe_expire_at: 0x1::option::Option<u64>,
        price: u64,
        royalty: u64,
        fee: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct CreateMultiBidEvent has copy, drop {
        multi_bid_id: 0x2::object::ID,
        buyer: address,
        maybe_name: 0x1::option::Option<0x1::ascii::String>,
        balance: u64,
    }

    struct UpdateMultiBidEvent has copy, drop {
        multi_bid_id: 0x2::object::ID,
        buyer: address,
        maybe_name: 0x1::option::Option<0x1::ascii::String>,
        balance: u64,
    }

    struct CancelMultiBidEvent has copy, drop {
        multi_bid_id: 0x2::object::ID,
        buyer: address,
        maybe_name: 0x1::option::Option<0x1::ascii::String>,
        balance: u64,
    }

    struct CreateSingleBidEvent has copy, drop {
        bid_id: 0x2::object::ID,
        type: u64,
        buyer: address,
        maybe_multi_bid_id: 0x1::option::Option<0x2::object::ID>,
        nft_type: 0x1::ascii::String,
        maybe_nft_id: 0x1::option::Option<0x2::object::ID>,
        maybe_nft_bcs: 0x1::option::Option<vector<u8>>,
        maybe_expire_at: 0x1::option::Option<u64>,
        price: u64,
        royalty: u64,
        fee: u64,
    }

    struct CancelSingleBidEvent has copy, drop {
        bid_id: 0x2::object::ID,
        type: u64,
        buyer: address,
        maybe_multi_bid_id: 0x1::option::Option<0x2::object::ID>,
        nft_type: 0x1::ascii::String,
        maybe_nft_id: 0x1::option::Option<0x2::object::ID>,
        maybe_nft_bcs: 0x1::option::Option<vector<u8>>,
        maybe_expire_at: 0x1::option::Option<u64>,
        price: u64,
        royalty: u64,
        fee: u64,
    }

    struct MatchSingleBidEvent has copy, drop {
        bid_id: 0x2::object::ID,
        type: u64,
        buyer: address,
        maybe_multi_bid_id: 0x1::option::Option<0x2::object::ID>,
        nft_type: 0x1::ascii::String,
        maybe_nft_id: 0x1::option::Option<0x2::object::ID>,
        maybe_nft_bcs: 0x1::option::Option<vector<u8>>,
        maybe_expire_at: 0x1::option::Option<u64>,
        price: u64,
        royalty: u64,
        fee: u64,
        nft_id: 0x2::object::ID,
        maybe_buyer_kiosk_id: 0x1::option::Option<0x2::object::ID>,
    }

    fun accept_bid<T0: store + key>(arg0: &0x2::clock::Clock, arg1: &Store, arg2: SingleBid, arg3: &T0, arg4: 0x1::option::Option<0x2::object::ID>) {
        verify_version(arg1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(arg2.nft_type == *0x1::type_name::borrow_string(&v0), 8);
        if (0x1::option::is_some<0x2::object::ID>(&arg2.maybe_nft_id)) {
            assert!(0x2::object::id<T0>(arg3) == *0x1::option::borrow<0x2::object::ID>(&arg2.maybe_nft_id), 8);
        };
        if (0x1::option::is_some<vector<u8>>(&arg2.maybe_nft_bcs)) {
            assert!(0x1::bcs::to_bytes<T0>(arg3) == *0x1::option::borrow<vector<u8>>(&arg2.maybe_nft_bcs), 9);
        };
        if (0x1::option::is_some<u64>(&arg2.maybe_expire_at)) {
            assert!(0x2::clock::timestamp_ms(arg0) <= *0x1::option::borrow<u64>(&arg2.maybe_expire_at), 7);
        };
        let v1 = MatchSingleBidEvent{
            bid_id               : 0x2::object::id<SingleBid>(&arg2),
            type                 : arg2.type,
            buyer                : arg2.buyer,
            maybe_multi_bid_id   : arg2.maybe_multi_bid_id,
            nft_type             : arg2.nft_type,
            maybe_nft_id         : arg2.maybe_nft_id,
            maybe_nft_bcs        : arg2.maybe_nft_bcs,
            maybe_expire_at      : arg2.maybe_expire_at,
            price                : arg2.price,
            royalty              : arg2.royalty,
            fee                  : arg2.fee,
            nft_id               : 0x2::object::id<T0>(arg3),
            maybe_buyer_kiosk_id : arg4,
        };
        0x2::event::emit<MatchSingleBidEvent>(v1);
        let SingleBid {
            id                 : v2,
            type               : _,
            buyer              : _,
            maybe_multi_bid_id : _,
            nft_type           : _,
            maybe_nft_id       : _,
            maybe_nft_bcs      : _,
            maybe_expire_at    : _,
            price              : _,
            royalty            : _,
            fee                : _,
            balance            : v13,
        } = arg2;
        0x2::object::delete(v2);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v13);
    }

    public fun accept_bid_with_transfer_policy<T0: store + key>(arg0: &0x2::clock::Clock, arg1: &mut Store, arg2: 0x2::object::ID, arg3: 0x1::option::Option<0x2::object::ID>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::object::ID, arg7: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        verify_version(arg1);
        let v0 = get_bid(arg1, arg2, arg3, true);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v0.balance) == v0.price + v0.fee + v0.royalty, 10);
        let v1 = v0.price;
        let v2 = 0;
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg7)) {
            let v3 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg7, v0.price);
            v2 = v3;
            if (v3 != v0.royalty) {
                v2 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg7, 0);
                v1 = 0;
            };
        };
        assert!(v2 <= v0.royalty, 6);
        if (v1 == 0) {
            assert!(!0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::Rule>(arg7), 6);
        };
        let (v4, v5) = 0x2::kiosk::purchase_with_cap<T0>(arg4, 0x2::kiosk::list_with_purchase_cap<T0>(arg4, arg5, arg6, v1, arg8), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v0.balance, v1), arg8));
        let v6 = v5;
        let v7 = v4;
        let v8 = if (v1 == 0) {
            0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v0.balance, v0.price), arg8)
        } else {
            0x2::kiosk::withdraw(arg4, arg5, 0x1::option::some<u64>(v0.price), arg8)
        };
        0x2::pay::keep<0x2::sui::SUI>(v8, arg8);
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::Rule>(arg7)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::prove<T0>(arg7, &mut v6);
        };
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg7)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg7, &mut v6, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v0.balance, v2), arg8));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v0.balance));
        let (v9, v10) = 0x2::kiosk::new(arg8);
        let v11 = v10;
        let v12 = v9;
        accept_bid<T0>(arg0, arg1, v0, &v7, 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::kiosk::Kiosk>(&v12)));
        0x2::kiosk::lock<T0>(&mut v12, &v11, arg7, v7);
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg7)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v6, &v12);
        };
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::Rule>(arg7)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::create_for(&mut v12, v11, v0.buyer, arg8);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::prove<T0>(&v12, &mut v6);
        } else {
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v11, v0.buyer);
        };
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v12);
        v6
    }

    public fun accept_bid_without_transfer_policy<T0: store + key>(arg0: &0x2::clock::Clock, arg1: &mut Store, arg2: 0x2::object::ID, arg3: 0x1::option::Option<0x2::object::ID>, arg4: T0, arg5: &mut 0x2::tx_context::TxContext) {
        verify_version(arg1);
        let v0 = get_bid(arg1, arg2, arg3, true);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v0.balance) == v0.price + v0.fee + v0.royalty, 10);
        0x2::pay::keep<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v0.balance, v0.price), arg5), arg5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v0.balance));
        accept_bid<T0>(arg0, arg1, v0, &arg4, 0x1::option::none<0x2::object::ID>());
        0x2::transfer::public_transfer<T0>(arg4, v0.buyer);
    }

    public fun cancel_bid(arg0: &mut Store, arg1: 0x2::object::ID, arg2: 0x1::option::Option<0x2::object::ID>, arg3: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        let v0 = get_bid(arg0, arg1, arg2, false);
        assert!(v0.buyer == 0x2::tx_context::sender(arg3) || arg0.admin == 0x2::tx_context::sender(arg3), 2);
        let v1 = CancelSingleBidEvent{
            bid_id             : 0x2::object::id<SingleBid>(&v0),
            type               : v0.type,
            buyer              : v0.buyer,
            maybe_multi_bid_id : v0.maybe_multi_bid_id,
            nft_type           : v0.nft_type,
            maybe_nft_id       : v0.maybe_nft_id,
            maybe_nft_bcs      : v0.maybe_nft_bcs,
            maybe_expire_at    : v0.maybe_expire_at,
            price              : v0.price,
            royalty            : v0.royalty,
            fee                : v0.fee,
        };
        0x2::event::emit<CancelSingleBidEvent>(v1);
        let SingleBid {
            id                 : v2,
            type               : _,
            buyer              : v4,
            maybe_multi_bid_id : _,
            nft_type           : _,
            maybe_nft_id       : _,
            maybe_nft_bcs      : _,
            maybe_expire_at    : _,
            price              : _,
            royalty            : _,
            fee                : _,
            balance            : v13,
        } = v0;
        let v14 = v13;
        0x2::object::delete(v2);
        if (0x2::balance::value<0x2::sui::SUI>(&v14) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v14, arg3), v4);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v14);
        };
    }

    public fun cancel_multi_bid(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, MultiBid>(&arg0.id, arg1), 4);
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, MultiBid>(&mut arg0.id, arg1);
        assert!(v0.buyer == 0x2::tx_context::sender(arg2) || arg0.admin == 0x2::tx_context::sender(arg2), 2);
        let v1 = CancelMultiBidEvent{
            multi_bid_id : 0x2::object::id<MultiBid>(&v0),
            buyer        : v0.buyer,
            maybe_name   : v0.maybe_name,
            balance      : 0,
        };
        0x2::event::emit<CancelMultiBidEvent>(v1);
        while (!0x1::vector::is_empty<0x2::object::ID>(&v0.bids)) {
            let v2 = 0x1::vector::pop_back<0x2::object::ID>(&mut v0.bids);
            if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SingleBid>(&v0.id, v2)) {
                let SingleBid {
                    id                 : v3,
                    type               : _,
                    buyer              : _,
                    maybe_multi_bid_id : _,
                    nft_type           : _,
                    maybe_nft_id       : _,
                    maybe_nft_bcs      : _,
                    maybe_expire_at    : _,
                    price              : _,
                    royalty            : _,
                    fee                : _,
                    balance            : v14,
                } = 0x2::dynamic_object_field::remove<0x2::object::ID, SingleBid>(&mut v0.id, v2);
                0x2::object::delete(v3);
                0x2::balance::destroy_zero<0x2::sui::SUI>(v14);
            };
        };
        let MultiBid {
            id         : v15,
            buyer      : v16,
            maybe_name : _,
            bids       : v18,
            balance    : v19,
        } = v0;
        let v20 = v19;
        0x2::object::delete(v15);
        0x1::vector::destroy_empty<0x2::object::ID>(v18);
        if (0x2::balance::value<0x2::sui::SUI>(&v20) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v20, arg2), v16);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v20);
        };
    }

    fun create_bid<T0: store + key>(arg0: &mut Store, arg1: u64, arg2: address, arg3: 0x1::option::Option<0x2::object::ID>, arg4: 0x1::option::Option<0x2::object::ID>, arg5: 0x1::option::Option<vector<u8>>, arg6: 0x1::option::Option<u64>, arg7: u64, arg8: u64, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = *0x1::type_name::borrow_string(&v0);
        let v2 = (((arg7 as u128) * (arg0.fee_bps as u128) / 10000) as u64);
        assert!(arg1 < 2, 8);
        if (arg1 == 1) {
            assert!(0x1::option::is_some<0x2::object::ID>(&arg4), 8);
        };
        let v3 = SingleBid{
            id                 : 0x2::object::new(arg10),
            type               : arg1,
            buyer              : arg2,
            maybe_multi_bid_id : arg3,
            nft_type           : v1,
            maybe_nft_id       : arg4,
            maybe_nft_bcs      : arg5,
            maybe_expire_at    : arg6,
            price              : arg7,
            royalty            : arg8,
            fee                : v2,
            balance            : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v4 = CreateSingleBidEvent{
            bid_id             : 0x2::object::id<SingleBid>(&v3),
            type               : arg1,
            buyer              : arg2,
            maybe_multi_bid_id : arg3,
            nft_type           : v1,
            maybe_nft_id       : arg4,
            maybe_nft_bcs      : arg5,
            maybe_expire_at    : arg6,
            price              : arg7,
            royalty            : arg8,
            fee                : v2,
        };
        if (0x1::option::is_some<0x2::object::ID>(&arg3)) {
            let v5 = 0x1::option::destroy_some<0x2::object::ID>(arg3);
            assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, MultiBid>(&arg0.id, v5), 4);
            let v6 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, MultiBid>(&mut arg0.id, v5);
            assert!(v6.buyer == arg2, 2);
            if (0x2::coin::value<0x2::sui::SUI>(&arg9) > 0) {
                0x2::coin::put<0x2::sui::SUI>(&mut v6.balance, arg9);
                let v7 = UpdateMultiBidEvent{
                    multi_bid_id : 0x2::object::id<MultiBid>(v6),
                    buyer        : v6.buyer,
                    maybe_name   : v6.maybe_name,
                    balance      : 0x2::balance::value<0x2::sui::SUI>(&v6.balance),
                };
                0x2::event::emit<UpdateMultiBidEvent>(v7);
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(arg9);
            };
            assert!(0x2::balance::value<0x2::sui::SUI>(&v6.balance) >= arg7 + v2 + arg8, 10);
            0x2::event::emit<CreateSingleBidEvent>(v4);
            0x1::vector::push_back<0x2::object::ID>(&mut v6.bids, 0x2::object::id<SingleBid>(&v3));
            0x2::dynamic_object_field::add<0x2::object::ID, SingleBid>(&mut v6.id, 0x2::object::id<SingleBid>(&v3), v3);
        } else {
            assert!(0x1::option::is_none<u64>(&arg6), 8);
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg9) == arg7 + v2 + arg8, 10);
            0x2::coin::put<0x2::sui::SUI>(&mut v3.balance, arg9);
            0x2::event::emit<CreateSingleBidEvent>(v4);
            0x2::dynamic_object_field::add<0x2::object::ID, SingleBid>(&mut arg0.id, 0x2::object::id<SingleBid>(&v3), v3);
        };
    }

    public fun create_bid_with_transfer_policy<T0: store + key>(arg0: &mut Store, arg1: u64, arg2: 0x1::option::Option<0x2::object::ID>, arg3: 0x1::option::Option<0x2::object::ID>, arg4: 0x1::option::Option<vector<u8>>, arg5: 0x1::option::Option<u64>, arg6: u64, arg7: &0x2::transfer_policy::TransferPolicy<T0>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = *0x1::type_name::borrow_string(&v0);
        let v2 = 0;
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg7)) {
            v2 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg7, arg6);
        };
        if (!0x2::table::contains<0x1::ascii::String, bool>(&arg0.transfer_policies, v1)) {
            0x2::table::add<0x1::ascii::String, bool>(&mut arg0.transfer_policies, v1, true);
        };
        let v3 = 0x2::tx_context::sender(arg9);
        create_bid<T0>(arg0, arg1, v3, arg2, arg3, arg4, arg5, arg6, v2, arg8, arg9);
    }

    public fun create_bid_without_transfer_policy<T0: store + key>(arg0: &mut Store, arg1: u64, arg2: 0x1::option::Option<0x2::object::ID>, arg3: 0x1::option::Option<0x2::object::ID>, arg4: 0x1::option::Option<vector<u8>>, arg5: 0x1::option::Option<u64>, arg6: u64, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::table::contains<0x1::ascii::String, bool>(&arg0.transfer_policies, *0x1::type_name::borrow_string(&v0)), 3);
        let v1 = 0x2::tx_context::sender(arg8);
        create_bid<T0>(arg0, arg1, v1, arg2, arg3, arg4, arg5, arg6, 0, arg7, arg8);
    }

    public fun create_multi_bid(arg0: &mut Store, arg1: 0x1::option::Option<0x1::ascii::String>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        verify_version(arg0);
        let v0 = MultiBid{
            id         : 0x2::object::new(arg2),
            buyer      : 0x2::tx_context::sender(arg2),
            maybe_name : arg1,
            bids       : 0x1::vector::empty<0x2::object::ID>(),
            balance    : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v1 = 0x2::object::id<MultiBid>(&v0);
        let v2 = CreateMultiBidEvent{
            multi_bid_id : v1,
            buyer        : v0.buyer,
            maybe_name   : arg1,
            balance      : 0,
        };
        0x2::event::emit<CreateMultiBidEvent>(v2);
        0x2::dynamic_object_field::add<0x2::object::ID, MultiBid>(&mut arg0.id, v1, v0);
        v1
    }

    fun get_bid(arg0: &mut Store, arg1: 0x2::object::ID, arg2: 0x1::option::Option<0x2::object::ID>, arg3: bool) : SingleBid {
        verify_version(arg0);
        if (0x1::option::is_some<0x2::object::ID>(&arg2)) {
            let v1 = 0x1::option::destroy_some<0x2::object::ID>(arg2);
            assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, MultiBid>(&arg0.id, v1), 4);
            let v2 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, MultiBid>(&mut arg0.id, v1);
            assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SingleBid>(&v2.id, arg1), 5);
            let v3 = 0x2::dynamic_object_field::remove<0x2::object::ID, SingleBid>(&mut v2.id, arg1);
            if (arg3) {
                let v4 = v3.price + v3.fee + v3.royalty;
                assert!(0x2::balance::value<0x2::sui::SUI>(&v2.balance) >= v4, 10);
                0x2::balance::join<0x2::sui::SUI>(&mut v3.balance, 0x2::balance::split<0x2::sui::SUI>(&mut v2.balance, v4));
                let v5 = UpdateMultiBidEvent{
                    multi_bid_id : 0x2::object::id<MultiBid>(v2),
                    buyer        : v2.buyer,
                    maybe_name   : v2.maybe_name,
                    balance      : 0x2::balance::value<0x2::sui::SUI>(&v2.balance),
                };
                0x2::event::emit<UpdateMultiBidEvent>(v5);
            };
            v3
        } else {
            assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SingleBid>(&arg0.id, arg1), 5);
            0x2::dynamic_object_field::remove<0x2::object::ID, SingleBid>(&mut arg0.id, arg1)
        }
    }

    fun init(arg0: TRADEPORT_BIDDINGS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<TRADEPORT_BIDDINGS>(arg0, arg1);
        let v0 = Store{
            id                : 0x2::object::new(arg1),
            version           : 1,
            admin             : 0x2::tx_context::sender(arg1),
            fee_bps           : 300,
            balance           : 0x2::balance::zero<0x2::sui::SUI>(),
            transfer_policies : 0x2::table::new<0x1::ascii::String, bool>(arg1),
        };
        0x2::transfer::share_object<Store>(v0);
    }

    public fun migrate_bid<T0: store + key>(arg0: &mut Store, arg1: u64, arg2: address, arg3: 0x1::option::Option<0x2::object::ID>, arg4: 0x1::option::Option<0x2::object::ID>, arg5: 0x1::option::Option<vector<u8>>, arg6: 0x1::option::Option<u64>, arg7: u64, arg8: u64, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg10);
        create_bid<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    entry fun remove_transfer_policy(arg0: &mut Store, arg1: 0x1::ascii::String, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        if (0x2::table::contains<0x1::ascii::String, bool>(&arg0.transfer_policies, arg1)) {
            0x2::table::remove<0x1::ascii::String, bool>(&mut arg0.transfer_policies, arg1);
        };
    }

    entry fun set_admin(arg0: &mut Store, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.admin = arg1;
    }

    entry fun set_fee_bps(arg0: &mut Store, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.fee_bps = arg1;
    }

    entry fun set_version(arg0: &mut Store, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.version = arg1;
    }

    public fun update_multi_bid(arg0: &mut Store, arg1: 0x2::object::ID, arg2: 0x1::option::Option<0x1::ascii::String>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x1::option::Option<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, MultiBid>(&arg0.id, arg1), 4);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, MultiBid>(&mut arg0.id, arg1);
        assert!(v0.buyer == 0x2::tx_context::sender(arg5), 2);
        if (0x1::option::is_some<0x1::ascii::String>(&arg2)) {
            v0.maybe_name = arg2;
        };
        0x2::coin::put<0x2::sui::SUI>(&mut v0.balance, arg3);
        if (0x1::option::is_some<u64>(&arg4)) {
            let v1 = *0x1::option::borrow<u64>(&arg4);
            assert!(0x2::balance::value<0x2::sui::SUI>(&v0.balance) >= v1, 10);
            0x2::pay::keep<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v0.balance, v1), arg5), arg5);
        };
        let v2 = UpdateMultiBidEvent{
            multi_bid_id : 0x2::object::id<MultiBid>(v0),
            buyer        : v0.buyer,
            maybe_name   : v0.maybe_name,
            balance      : 0x2::balance::value<0x2::sui::SUI>(&v0.balance),
        };
        0x2::event::emit<UpdateMultiBidEvent>(v2);
    }

    fun verify_admin(arg0: &Store, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 2);
    }

    fun verify_version(arg0: &Store) {
        assert!(arg0.version == 1, 1);
    }

    entry fun withdraw_balance(arg0: &mut Store, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg3);
        let v0 = if (arg1 == 0) {
            0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance)
        } else {
            0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1)
        };
        if (0x2::tx_context::sender(arg3) == arg2) {
            0x2::pay::keep<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg3), arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg3), arg2);
        };
    }

    // decompiled from Move bytecode v6
}

