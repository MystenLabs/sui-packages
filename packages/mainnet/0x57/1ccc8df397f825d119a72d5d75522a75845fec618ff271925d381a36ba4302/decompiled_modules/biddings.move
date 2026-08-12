module 0x571ccc8df397f825d119a72d5d75522a75845fec618ff271925d381a36ba4302::biddings {
    struct BIDDINGS has drop {
        dummy_field: bool,
    }

    struct Store has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        fee_bps: u64,
        balances: 0x2::bag::Bag,
        transfer_policies: 0x2::table::Table<0x1::ascii::String, bool>,
    }

    struct MultiBid<phantom T0> has store, key {
        id: 0x2::object::UID,
        buyer: address,
        maybe_name: 0x1::option::Option<0x1::ascii::String>,
        bids: vector<0x2::object::ID>,
        balance: 0x2::balance::Balance<T0>,
    }

    struct SingleBid<phantom T0> has store, key {
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
        balance: 0x2::balance::Balance<T0>,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct CreateMultiBidEvent has copy, drop {
        multi_bid_id: 0x2::object::ID,
        buyer: address,
        maybe_name: 0x1::option::Option<0x1::ascii::String>,
        coin_type: 0x1::ascii::String,
        balance: u64,
    }

    struct UpdateMultiBidEvent has copy, drop {
        multi_bid_id: 0x2::object::ID,
        buyer: address,
        maybe_name: 0x1::option::Option<0x1::ascii::String>,
        coin_type: 0x1::ascii::String,
        balance: u64,
    }

    struct CancelMultiBidEvent has copy, drop {
        multi_bid_id: 0x2::object::ID,
        buyer: address,
        maybe_name: 0x1::option::Option<0x1::ascii::String>,
        coin_type: 0x1::ascii::String,
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
        coin_type: 0x1::ascii::String,
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
        coin_type: 0x1::ascii::String,
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
        coin_type: 0x1::ascii::String,
        price: u64,
        royalty: u64,
        fee: u64,
        nft_id: 0x2::object::ID,
        maybe_buyer_kiosk_id: 0x1::option::Option<0x2::object::ID>,
    }

    fun deposit<T0>(arg0: &mut Store, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (!0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            0x2::bag::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
    }

    fun accept_bid<T0: store + key, T1>(arg0: &0x2::clock::Clock, arg1: &Store, arg2: SingleBid<T1>, arg3: &T0, arg4: 0x1::option::Option<0x2::object::ID>) {
        verify_bid<T0, T1>(arg0, arg1, &arg2, arg3);
        consume_bid<T1>(arg2, 0x2::object::id<T0>(arg3), arg4);
    }

    public fun accept_bid_with_transfer_policy<T0: store + key, T1>(arg0: &0x2::clock::Clock, arg1: &mut Store, arg2: 0x2::object::ID, arg3: 0x1::option::Option<0x2::object::ID>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::object::ID, arg7: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg8: &mut 0x3d6bde09785d97970f9f12c399540f470ffa26f5f34a9dc1e0474882f0bf6750::royalty_vault::RoyaltyVault<T0, T1>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        verify_version(arg1);
        assert!(0x1::type_name::with_defining_ids<T1>() != 0x1::type_name::with_defining_ids<0x2::sui::SUI>(), 11);
        let v0 = get_bid<T1>(arg1, arg2, arg3, true);
        assert!(0x2::balance::value<T1>(&v0.balance) == v0.price + v0.fee + v0.royalty, 10);
        let v1 = 0x571ccc8df397f825d119a72d5d75522a75845fec618ff271925d381a36ba4302::transfers::royalty_amount<T0>(arg7, v0.price);
        assert!(v1 <= v0.royalty, 6);
        let (v2, v3) = 0x571ccc8df397f825d119a72d5d75522a75845fec618ff271925d381a36ba4302::transfers::zero_purchase<T0>(arg4, 0x2::kiosk::list_with_purchase_cap<T0>(arg4, arg5, arg6, 0, arg9), arg7, arg9);
        let v4 = v3;
        let v5 = v2;
        verify_bid<T0, T1>(arg0, arg1, &v0, &v5);
        0x2::balance::send_funds<T1>(0x2::balance::split<T1>(&mut v0.balance, v0.price), 0x2::tx_context::sender(arg9));
        0x3d6bde09785d97970f9f12c399540f470ffa26f5f34a9dc1e0474882f0bf6750::royalty_vault::deposit<T0, T1>(arg8, arg7, 0x2::balance::split<T1>(&mut v0.balance, v1));
        deposit<T1>(arg1, 0x2::balance::withdraw_all<T1>(&mut v0.balance));
        consume_bid<T1>(v0, 0x2::object::id<T0>(&v5), 0x571ccc8df397f825d119a72d5d75522a75845fec618ff271925d381a36ba4302::transfers::transfer_to<T0>(arg7, &mut v4, v5, v0.buyer, arg9));
        v4
    }

    public fun accept_bid_without_transfer_policy<T0: store + key, T1>(arg0: &0x2::clock::Clock, arg1: &mut Store, arg2: 0x2::object::ID, arg3: 0x1::option::Option<0x2::object::ID>, arg4: T0, arg5: &mut 0x2::tx_context::TxContext) {
        verify_version(arg1);
        let v0 = get_bid<T1>(arg1, arg2, arg3, true);
        assert!(0x2::balance::value<T1>(&v0.balance) == v0.price + v0.fee + v0.royalty, 10);
        0x2::balance::send_funds<T1>(0x2::balance::split<T1>(&mut v0.balance, v0.price), 0x2::tx_context::sender(arg5));
        deposit<T1>(arg1, 0x2::balance::withdraw_all<T1>(&mut v0.balance));
        accept_bid<T0, T1>(arg0, arg1, v0, &arg4, 0x1::option::none<0x2::object::ID>());
        0x2::transfer::public_transfer<T0>(arg4, v0.buyer);
    }

    public fun cancel_bid<T0>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: 0x1::option::Option<0x2::object::ID>, arg3: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        let v0 = get_bid<T0>(arg0, arg1, arg2, false);
        assert!(v0.buyer == 0x2::tx_context::sender(arg3) || arg0.admin == 0x2::tx_context::sender(arg3), 2);
        let v1 = CancelSingleBidEvent{
            bid_id             : 0x2::object::id<SingleBid<T0>>(&v0),
            type               : v0.type,
            buyer              : v0.buyer,
            maybe_multi_bid_id : v0.maybe_multi_bid_id,
            nft_type           : v0.nft_type,
            maybe_nft_id       : v0.maybe_nft_id,
            maybe_nft_bcs      : v0.maybe_nft_bcs,
            maybe_expire_at    : v0.maybe_expire_at,
            coin_type          : type_string<T0>(),
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
        if (0x2::balance::value<T0>(&v14) > 0) {
            0x2::balance::send_funds<T0>(v14, v4);
        } else {
            0x2::balance::destroy_zero<T0>(v14);
        };
    }

    public fun cancel_multi_bid<T0>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, MultiBid<T0>>(&arg0.id, arg1), 4);
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, MultiBid<T0>>(&mut arg0.id, arg1);
        assert!(v0.buyer == 0x2::tx_context::sender(arg2) || arg0.admin == 0x2::tx_context::sender(arg2), 2);
        let v1 = CancelMultiBidEvent{
            multi_bid_id : 0x2::object::id<MultiBid<T0>>(&v0),
            buyer        : v0.buyer,
            maybe_name   : v0.maybe_name,
            coin_type    : type_string<T0>(),
            balance      : 0,
        };
        0x2::event::emit<CancelMultiBidEvent>(v1);
        let MultiBid {
            id         : v2,
            buyer      : v3,
            maybe_name : _,
            bids       : v5,
            balance    : v6,
        } = v0;
        let v7 = v6;
        0x2::object::delete(v2);
        let v8 = v5;
        let v9 = 0;
        while (v9 < 0x1::vector::length<0x2::object::ID>(&v8)) {
            0x1::vector::pop_back<0x2::object::ID>(&mut v8);
            v9 = v9 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(v8);
        if (0x2::balance::value<T0>(&v7) > 0) {
            0x2::balance::send_funds<T0>(v7, v3);
        } else {
            0x2::balance::destroy_zero<T0>(v7);
        };
    }

    fun consume_bid<T0>(arg0: SingleBid<T0>, arg1: 0x2::object::ID, arg2: 0x1::option::Option<0x2::object::ID>) {
        let v0 = MatchSingleBidEvent{
            bid_id               : 0x2::object::id<SingleBid<T0>>(&arg0),
            type                 : arg0.type,
            buyer                : arg0.buyer,
            maybe_multi_bid_id   : arg0.maybe_multi_bid_id,
            nft_type             : arg0.nft_type,
            maybe_nft_id         : arg0.maybe_nft_id,
            maybe_nft_bcs        : arg0.maybe_nft_bcs,
            maybe_expire_at      : arg0.maybe_expire_at,
            coin_type            : type_string<T0>(),
            price                : arg0.price,
            royalty              : arg0.royalty,
            fee                  : arg0.fee,
            nft_id               : arg1,
            maybe_buyer_kiosk_id : arg2,
        };
        0x2::event::emit<MatchSingleBidEvent>(v0);
        let SingleBid {
            id                 : v1,
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
            balance            : v12,
        } = arg0;
        0x2::object::delete(v1);
        0x2::balance::destroy_zero<T0>(v12);
    }

    fun create_bid<T0: store + key, T1>(arg0: &mut Store, arg1: u64, arg2: address, arg3: 0x1::option::Option<0x2::object::ID>, arg4: 0x1::option::Option<0x2::object::ID>, arg5: 0x1::option::Option<vector<u8>>, arg6: 0x1::option::Option<u64>, arg7: u64, arg8: u64, arg9: 0x2::coin::Coin<T1>, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        verify_version(arg0);
        let v0 = type_string<T0>();
        let v1 = (((arg7 as u128) * (arg0.fee_bps as u128) / 10000) as u64);
        assert!(arg1 < 2, 8);
        if (arg1 == 1) {
            assert!(0x1::option::is_some<0x2::object::ID>(&arg4), 8);
        };
        let v2 = SingleBid<T1>{
            id                 : 0x2::object::new(arg10),
            type               : arg1,
            buyer              : arg2,
            maybe_multi_bid_id : arg3,
            nft_type           : v0,
            maybe_nft_id       : arg4,
            maybe_nft_bcs      : arg5,
            maybe_expire_at    : arg6,
            price              : arg7,
            royalty            : arg8,
            fee                : v1,
            balance            : 0x2::balance::zero<T1>(),
        };
        let v3 = 0x2::object::id<SingleBid<T1>>(&v2);
        let v4 = CreateSingleBidEvent{
            bid_id             : v3,
            type               : arg1,
            buyer              : arg2,
            maybe_multi_bid_id : arg3,
            nft_type           : v0,
            maybe_nft_id       : arg4,
            maybe_nft_bcs      : arg5,
            maybe_expire_at    : arg6,
            coin_type          : type_string<T1>(),
            price              : arg7,
            royalty            : arg8,
            fee                : v1,
        };
        if (0x1::option::is_some<0x2::object::ID>(&arg3)) {
            let v5 = 0x1::option::destroy_some<0x2::object::ID>(arg3);
            assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, MultiBid<T1>>(&arg0.id, v5), 4);
            let v6 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, MultiBid<T1>>(&mut arg0.id, v5);
            assert!(v6.buyer == arg2, 2);
            if (0x2::coin::value<T1>(&arg9) > 0) {
                0x2::coin::put<T1>(&mut v6.balance, arg9);
                let v7 = UpdateMultiBidEvent{
                    multi_bid_id : 0x2::object::id<MultiBid<T1>>(v6),
                    buyer        : v6.buyer,
                    maybe_name   : v6.maybe_name,
                    coin_type    : type_string<T1>(),
                    balance      : 0x2::balance::value<T1>(&v6.balance),
                };
                0x2::event::emit<UpdateMultiBidEvent>(v7);
            } else {
                0x2::coin::destroy_zero<T1>(arg9);
            };
            assert!(0x2::balance::value<T1>(&v6.balance) >= arg7 + v1 + arg8, 10);
            0x2::event::emit<CreateSingleBidEvent>(v4);
            0x2::dynamic_object_field::add<0x2::object::ID, SingleBid<T1>>(&mut v6.id, v3, v2);
        } else {
            assert!(0x1::option::is_none<u64>(&arg6), 8);
            assert!(0x2::coin::value<T1>(&arg9) == arg7 + v1 + arg8, 10);
            0x2::coin::put<T1>(&mut v2.balance, arg9);
            0x2::event::emit<CreateSingleBidEvent>(v4);
            0x2::dynamic_object_field::add<0x2::object::ID, SingleBid<T1>>(&mut arg0.id, v3, v2);
        };
        v3
    }

    public fun create_bid_with_transfer_policy<T0: store + key, T1>(arg0: &mut Store, arg1: u64, arg2: 0x1::option::Option<0x2::object::ID>, arg3: 0x1::option::Option<0x2::object::ID>, arg4: 0x1::option::Option<vector<u8>>, arg5: 0x1::option::Option<u64>, arg6: u64, arg7: &0x2::transfer_policy::TransferPolicy<T0>, arg8: 0x2::coin::Coin<T1>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        verify_version(arg0);
        let v0 = type_string<T0>();
        if (0x1::type_name::with_defining_ids<T1>() != 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            0x571ccc8df397f825d119a72d5d75522a75845fec618ff271925d381a36ba4302::transfers::assert_settleable<T0>(arg7);
            assert!(0x3d6bde09785d97970f9f12c399540f470ffa26f5f34a9dc1e0474882f0bf6750::royalty_vault::has_vault<T0, T1>(arg7), 12);
        };
        if (!0x2::table::contains<0x1::ascii::String, bool>(&arg0.transfer_policies, v0)) {
            0x2::table::add<0x1::ascii::String, bool>(&mut arg0.transfer_policies, v0, true);
        };
        let v1 = 0x2::tx_context::sender(arg9);
        create_bid<T0, T1>(arg0, arg1, v1, arg2, arg3, arg4, arg5, arg6, 0x571ccc8df397f825d119a72d5d75522a75845fec618ff271925d381a36ba4302::transfers::royalty_amount<T0>(arg7, arg6), arg8, arg9)
    }

    public fun create_bid_without_transfer_policy<T0: store + key, T1>(arg0: &mut Store, arg1: u64, arg2: 0x1::option::Option<0x2::object::ID>, arg3: 0x1::option::Option<0x2::object::ID>, arg4: 0x1::option::Option<vector<u8>>, arg5: 0x1::option::Option<u64>, arg6: u64, arg7: 0x2::coin::Coin<T1>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        verify_version(arg0);
        assert!(!0x2::table::contains<0x1::ascii::String, bool>(&arg0.transfer_policies, type_string<T0>()), 3);
        let v0 = 0x2::tx_context::sender(arg8);
        create_bid<T0, T1>(arg0, arg1, v0, arg2, arg3, arg4, arg5, arg6, 0, arg7, arg8)
    }

    public fun create_multi_bid<T0>(arg0: &mut Store, arg1: 0x1::option::Option<0x1::ascii::String>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        verify_version(arg0);
        let v0 = MultiBid<T0>{
            id         : 0x2::object::new(arg2),
            buyer      : 0x2::tx_context::sender(arg2),
            maybe_name : arg1,
            bids       : 0x1::vector::empty<0x2::object::ID>(),
            balance    : 0x2::balance::zero<T0>(),
        };
        let v1 = 0x2::object::id<MultiBid<T0>>(&v0);
        let v2 = CreateMultiBidEvent{
            multi_bid_id : v1,
            buyer        : v0.buyer,
            maybe_name   : arg1,
            coin_type    : type_string<T0>(),
            balance      : 0,
        };
        0x2::event::emit<CreateMultiBidEvent>(v2);
        0x2::dynamic_object_field::add<0x2::object::ID, MultiBid<T0>>(&mut arg0.id, v1, v0);
        v1
    }

    public fun get_balance_amount<T0>(arg0: &Store) : u64 {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (!0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::bag::borrow<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
    }

    fun get_bid<T0>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: 0x1::option::Option<0x2::object::ID>, arg3: bool) : SingleBid<T0> {
        verify_version(arg0);
        if (0x1::option::is_some<0x2::object::ID>(&arg2)) {
            let v1 = 0x1::option::destroy_some<0x2::object::ID>(arg2);
            assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, MultiBid<T0>>(&arg0.id, v1), 4);
            let v2 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, MultiBid<T0>>(&mut arg0.id, v1);
            assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SingleBid<T0>>(&v2.id, arg1), 5);
            let v3 = 0x2::dynamic_object_field::remove<0x2::object::ID, SingleBid<T0>>(&mut v2.id, arg1);
            if (arg3) {
                let v4 = v3.price + v3.fee + v3.royalty;
                assert!(0x2::balance::value<T0>(&v2.balance) >= v4, 10);
                0x2::balance::join<T0>(&mut v3.balance, 0x2::balance::split<T0>(&mut v2.balance, v4));
                let v5 = UpdateMultiBidEvent{
                    multi_bid_id : 0x2::object::id<MultiBid<T0>>(v2),
                    buyer        : v2.buyer,
                    maybe_name   : v2.maybe_name,
                    coin_type    : type_string<T0>(),
                    balance      : 0x2::balance::value<T0>(&v2.balance),
                };
                0x2::event::emit<UpdateMultiBidEvent>(v5);
            };
            v3
        } else {
            assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SingleBid<T0>>(&arg0.id, arg1), 5);
            0x2::dynamic_object_field::remove<0x2::object::ID, SingleBid<T0>>(&mut arg0.id, arg1)
        }
    }

    public fun get_multi_bid_balance<T0>(arg0: &Store, arg1: 0x2::object::ID) : u64 {
        if (!has_multi_bid<T0>(arg0, arg1)) {
            return 0
        };
        0x2::balance::value<T0>(&0x2::dynamic_object_field::borrow<0x2::object::ID, MultiBid<T0>>(&arg0.id, arg1).balance)
    }

    public fun has_multi_bid<T0>(arg0: &Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, MultiBid<T0>>(&arg0.id, arg1)
    }

    fun init(arg0: BIDDINGS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<BIDDINGS>(arg0, arg1);
        let v0 = Store{
            id                : 0x2::object::new(arg1),
            version           : 1,
            admin             : 0x2::tx_context::sender(arg1),
            fee_bps           : 300,
            balances          : 0x2::bag::new(arg1),
            transfer_policies : 0x2::table::new<0x1::ascii::String, bool>(arg1),
        };
        0x2::transfer::share_object<Store>(v0);
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

    fun type_string<T0>() : 0x1::ascii::String {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        *0x1::type_name::as_string(&v0)
    }

    public fun update_multi_bid<T0>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: 0x1::option::Option<0x1::ascii::String>, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::option::Option<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, MultiBid<T0>>(&arg0.id, arg1), 4);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, MultiBid<T0>>(&mut arg0.id, arg1);
        assert!(v0.buyer == 0x2::tx_context::sender(arg5), 2);
        if (0x1::option::is_some<0x1::ascii::String>(&arg2)) {
            v0.maybe_name = arg2;
        };
        0x2::coin::put<T0>(&mut v0.balance, arg3);
        if (0x1::option::is_some<u64>(&arg4)) {
            let v1 = *0x1::option::borrow<u64>(&arg4);
            assert!(0x2::balance::value<T0>(&v0.balance) >= v1, 10);
            0x2::balance::send_funds<T0>(0x2::balance::split<T0>(&mut v0.balance, v1), 0x2::tx_context::sender(arg5));
        };
        let v2 = UpdateMultiBidEvent{
            multi_bid_id : 0x2::object::id<MultiBid<T0>>(v0),
            buyer        : v0.buyer,
            maybe_name   : v0.maybe_name,
            coin_type    : type_string<T0>(),
            balance      : 0x2::balance::value<T0>(&v0.balance),
        };
        0x2::event::emit<UpdateMultiBidEvent>(v2);
    }

    fun verify_admin(arg0: &Store, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 2);
    }

    fun verify_bid<T0: store + key, T1>(arg0: &0x2::clock::Clock, arg1: &Store, arg2: &SingleBid<T1>, arg3: &T0) {
        verify_version(arg1);
        assert!(arg2.nft_type == type_string<T0>(), 8);
        if (0x1::option::is_some<0x2::object::ID>(&arg2.maybe_nft_id)) {
            assert!(0x2::object::id<T0>(arg3) == *0x1::option::borrow<0x2::object::ID>(&arg2.maybe_nft_id), 8);
        };
        if (0x1::option::is_some<vector<u8>>(&arg2.maybe_nft_bcs)) {
            assert!(0x1::bcs::to_bytes<T0>(arg3) == *0x1::option::borrow<vector<u8>>(&arg2.maybe_nft_bcs), 9);
        };
        if (0x1::option::is_some<u64>(&arg2.maybe_expire_at)) {
            assert!(0x2::clock::timestamp_ms(arg0) <= *0x1::option::borrow<u64>(&arg2.maybe_expire_at), 7);
        };
    }

    fun verify_version(arg0: &Store) {
        assert!(arg0.version <= 1, 1);
    }

    entry fun withdraw_balance<T0>(arg0: &mut Store, arg1: u64, arg2: address, arg3: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg3);
        let v0 = BalanceKey<T0>{dummy_field: false};
        assert!(0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0), 10);
        let v1 = if (arg1 == 0) {
            0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0))
        } else {
            0x2::balance::split<T0>(0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1)
        };
        0x2::balance::send_funds<T0>(v1, arg2);
    }

    // decompiled from Move bytecode v7
}

