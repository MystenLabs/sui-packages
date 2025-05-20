module 0x3836a23db29080cba7f68da685d18c1cff036a81db3e6e05f3e68bda265e0480::multi_kiosk_bidding_house {
    struct MultiBundleStore has store, key {
        id: 0x2::object::UID,
        auction_house: 0x2::object::ID,
        reentrancy_guard: bool,
    }

    struct NftBundle has store, key {
        id: 0x2::object::UID,
        seller: address,
        price: u64,
        status: u8,
        fee_bps: u16,
        created_at: u64,
        expires_at: u64,
        coin_type: 0x1::type_name::TypeName,
        nft_count: u64,
        buyer: 0x1::option::Option<address>,
        nft_keys: vector<0x2::object::ID>,
    }

    struct BundledNft<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        bundle_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
        claimed: bool,
    }

    struct MultiBundleStoreCreated has copy, drop {
        store_id: 0x2::object::ID,
        auction_house: 0x2::object::ID,
        creator: address,
    }

    struct NftBundleCreated has copy, drop {
        bundle_id: 0x2::object::ID,
        seller: address,
        price: u64,
        nft_count: u64,
        fee_bps: u16,
        expires_at: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct NftAddedToBundle has copy, drop {
        bundle_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        nft_type: 0x1::type_name::TypeName,
        nft_key: 0x2::object::ID,
    }

    struct BundlePurchased has copy, drop {
        bundle_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
        nft_count: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct BundleNftClaimed has copy, drop {
        bundle_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        buyer: address,
        nft_type: 0x1::type_name::TypeName,
    }

    struct BundleCancelled has copy, drop {
        bundle_id: 0x2::object::ID,
        seller: address,
        nft_count: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct BundleExpired has copy, drop {
        bundle_id: 0x2::object::ID,
        seller: address,
        nft_count: u64,
        timestamp: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    public fun add_nft_to_bundle<T0: store + key>(arg0: &mut MultiBundleStore, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftBundle>(&arg0.id, arg1), 4);
        assert!(0x2::kiosk::has_item(arg2, arg4), 13);
        assert!(0x2::kiosk::has_access(arg2, arg3), 5);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftBundle>(&arg0.id, arg1);
        assert!(0x2::tx_context::sender(arg5) == v0.seller, 3);
        assert!(v0.status == 0, 2);
        assert!(!is_safely_expired(v0.expires_at, arg5), 9);
        let v1 = BundledNft<T0>{
            id           : 0x2::object::new(arg5),
            bundle_id    : arg1,
            kiosk_id     : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            nft_id       : arg4,
            purchase_cap : 0x2::kiosk::list_with_purchase_cap<T0>(arg2, arg3, arg4, 0, arg5),
            claimed      : false,
        };
        let v2 = 0x2::object::id<BundledNft<T0>>(&v1);
        0x2::dynamic_object_field::add<0x2::object::ID, BundledNft<T0>>(&mut arg0.id, v2, v1);
        let v3 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, NftBundle>(&mut arg0.id, arg1);
        v3.nft_count = v3.nft_count + 1;
        0x1::vector::push_back<0x2::object::ID>(&mut v3.nft_keys, v2);
        let v4 = NftAddedToBundle{
            bundle_id : arg1,
            nft_id    : arg4,
            kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            nft_type  : 0x1::type_name::get<T0>(),
            nft_key   : v2,
        };
        0x2::event::emit<NftAddedToBundle>(v4);
    }

    public entry fun add_nft_to_bundle_entry<T0: store + key>(arg0: &mut MultiBundleStore, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        add_nft_to_bundle<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun batch_clean_expired_bundles(arg0: &mut MultiBundleStore, arg1: vector<0x2::object::ID>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0x1::vector::length<0x2::object::ID>(&arg1);
        assert!(v1 <= 50, 22);
        while (v0 < v1) {
            let v2 = *0x1::vector::borrow<0x2::object::ID>(&arg1, v0);
            if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftBundle>(&arg0.id, v2)) {
                let v3 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftBundle>(&arg0.id, v2);
                if (v3.status == 0 && is_safely_expired(v3.expires_at, arg2)) {
                    let v4 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, NftBundle>(&mut arg0.id, v2);
                    v4.status = 2;
                    let v5 = BundleExpired{
                        bundle_id : v2,
                        seller    : v4.seller,
                        nft_count : v4.nft_count,
                        timestamp : 0x2::tx_context::epoch(arg2),
                        coin_type : v4.coin_type,
                    };
                    0x2::event::emit<BundleExpired>(v5);
                };
            };
            v0 = v0 + 1;
        };
    }

    public fun bundle_exists(arg0: &MultiBundleStore, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftBundle>(&arg0.id, arg1)
    }

    public fun buy_bundle<T0>(arg0: &mut MultiBundleStore, arg1: &mut 0x3836a23db29080cba7f68da685d18c1cff036a81db3e6e05f3e68bda265e0480::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftBundle>(&arg0.id, arg2), 4);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftBundle>(&arg0.id, arg2);
        assert!(v0.status == 0, 2);
        assert!(!is_safely_expired(v0.expires_at, arg4), 9);
        let v1 = v0.coin_type;
        assert!(v1 == 0x1::type_name::get<T0>(), 11);
        let v2 = v0.price;
        assert!(0x2::coin::value<T0>(&arg3) == v2, 19);
        let v3 = v0.seller;
        let v4 = v0.nft_count;
        assert!(v4 > 0, 15);
        let v5 = 0x2::coin::split<T0>(&mut arg3, 0x2::coin::value<T0>(&arg3) * (v0.fee_bps as u64) / 10000, arg4);
        let v6 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, NftBundle>(&mut arg0.id, arg2);
        v6.status = 1;
        v6.buyer = 0x1::option::some<address>(0x2::tx_context::sender(arg4));
        let v7 = BundlePurchased{
            bundle_id : arg2,
            seller    : v3,
            buyer     : 0x2::tx_context::sender(arg4),
            price     : v2,
            nft_count : v4,
            coin_type : v1,
        };
        0x2::event::emit<BundlePurchased>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x3836a23db29080cba7f68da685d18c1cff036a81db3e6e05f3e68bda265e0480::auctionhouse::get_owner(arg1));
    }

    public entry fun buy_bundle_entry<T0>(arg0: &mut MultiBundleStore, arg1: &mut 0x3836a23db29080cba7f68da685d18c1cff036a81db3e6e05f3e68bda265e0480::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        buy_bundle<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun cancel_bundle(arg0: &mut MultiBundleStore, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftBundle>(&arg0.id, arg1), 4);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftBundle>(&arg0.id, arg1);
        let v1 = v0.seller;
        assert!(0x2::tx_context::sender(arg2) == v1, 3);
        assert!(v0.status == 0, 2);
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, NftBundle>(&mut arg0.id, arg1).status = 2;
        let v2 = BundleCancelled{
            bundle_id : arg1,
            seller    : v1,
            nft_count : v0.nft_count,
            coin_type : v0.coin_type,
        };
        0x2::event::emit<BundleCancelled>(v2);
    }

    public entry fun cancel_bundle_entry(arg0: &mut MultiBundleStore, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        cancel_bundle(arg0, arg1, arg2);
    }

    public fun cancel_bundle_nft<T0: store + key>(arg0: &mut MultiBundleStore, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftBundle>(&arg0.id, arg1), 4);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftBundle>(&arg0.id, arg1);
        assert!(v0.status == 2, 2);
        assert!(0x2::tx_context::sender(arg4) == v0.seller, 3);
        assert!(verify_nft_in_bundle(v0, arg2), 20);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, BundledNft<T0>>(&arg0.id, arg2), 13);
        let BundledNft {
            id           : v1,
            bundle_id    : v2,
            kiosk_id     : v3,
            nft_id       : _,
            purchase_cap : v5,
            claimed      : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, BundledNft<T0>>(&mut arg0.id, arg2);
        assert!(v2 == arg1, 4);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg3) == v3, 6);
        let v7 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, NftBundle>(&mut arg0.id, arg1);
        let v8 = 0;
        while (v8 < 0x1::vector::length<0x2::object::ID>(&v7.nft_keys)) {
            if (*0x1::vector::borrow<0x2::object::ID>(&v7.nft_keys, v8) == arg2) {
                0x1::vector::remove<0x2::object::ID>(&mut v7.nft_keys, v8);
                break
            };
            v8 = v8 + 1;
        };
        0x2::object::delete(v1);
        0x2::kiosk::return_purchase_cap<T0>(arg3, v5);
    }

    public entry fun cancel_bundle_nft_entry<T0: store + key>(arg0: &mut MultiBundleStore, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::tx_context::TxContext) {
        cancel_bundle_nft<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun claim_bundle_nft<T0: store + key>(arg0: &mut MultiBundleStore, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftBundle>(&arg0.id, arg1), 4);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftBundle>(&arg0.id, arg1);
        assert!(v0.status == 1, 18);
        assert!(0x1::option::is_some<address>(&v0.buyer), 18);
        let v1 = *0x1::option::borrow<address>(&v0.buyer);
        assert!(0x2::tx_context::sender(arg5) == v1, 17);
        assert!(verify_nft_in_bundle(v0, arg2), 20);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, BundledNft<T0>>(&arg0.id, arg2), 13);
        let BundledNft {
            id           : v2,
            bundle_id    : v3,
            kiosk_id     : v4,
            nft_id       : v5,
            purchase_cap : v6,
            claimed      : v7,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, BundledNft<T0>>(&mut arg0.id, arg2);
        assert!(v3 == arg1, 4);
        assert!(!v7, 16);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg3) == v4, 6);
        assert!(0x2::kiosk::has_item(arg3, v5), 13);
        let v8 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, NftBundle>(&mut arg0.id, arg1);
        let v9 = 0;
        while (v9 < 0x1::vector::length<0x2::object::ID>(&v8.nft_keys)) {
            if (*0x1::vector::borrow<0x2::object::ID>(&v8.nft_keys, v9) == arg2) {
                0x1::vector::remove<0x2::object::ID>(&mut v8.nft_keys, v9);
                break
            };
            v9 = v9 + 1;
        };
        let v10 = BundleNftClaimed{
            bundle_id : arg1,
            nft_id    : v5,
            buyer     : v1,
            nft_type  : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<BundleNftClaimed>(v10);
        0x2::object::delete(v2);
        0x2::kiosk::purchase_with_cap<T0>(arg3, v6, 0x2::coin::zero<0x2::sui::SUI>(arg5))
    }

    public entry fun claim_bundle_nft_to_kiosk<T0: store + key>(arg0: &mut MultiBundleStore, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg6);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = claim_bundle_nft<T0>(arg0, arg1, arg2, arg3, arg4, arg6);
        let v6 = v5;
        0x2::kiosk::lock<T0>(&mut v3, &v2, arg4, v4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg4, &mut v6, arg5);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v6, &v3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v6);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v3, v2, arg6), arg6);
    }

    public entry fun clean_expired_bundle(arg0: &mut MultiBundleStore, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftBundle>(&arg0.id, arg1), 4);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftBundle>(&arg0.id, arg1);
        assert!(is_safely_expired(v0.expires_at, arg2), 12);
        assert!(v0.status == 0, 2);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, NftBundle>(&mut arg0.id, arg1);
        v1.status = 2;
        let v2 = BundleExpired{
            bundle_id : arg1,
            seller    : v1.seller,
            nft_count : v1.nft_count,
            timestamp : 0x2::tx_context::epoch(arg2),
            coin_type : v1.coin_type,
        };
        0x2::event::emit<BundleExpired>(v2);
    }

    public entry fun create_and_share_multi_bundle_store(arg0: &0x3836a23db29080cba7f68da685d18c1cff036a81db3e6e05f3e68bda265e0480::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<MultiBundleStore>(create_multi_bundle_store(arg0, arg1));
    }

    public fun create_empty_bundle<T0>(arg0: &mut MultiBundleStore, arg1: u64, arg2: u16, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg1 > 0, 1);
        assert!(arg2 <= 10000, 14);
        assert!(arg3 > 0, 10);
        let v0 = 0x2::tx_context::epoch(arg4);
        let v1 = v0 + arg3;
        let v2 = 0x2::object::new(arg4);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = 0x1::type_name::get<T0>();
        let v5 = NftBundle{
            id         : v2,
            seller     : 0x2::tx_context::sender(arg4),
            price      : arg1,
            status     : 0,
            fee_bps    : arg2,
            created_at : v0,
            expires_at : v1,
            coin_type  : v4,
            nft_count  : 0,
            buyer      : 0x1::option::none<address>(),
            nft_keys   : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, NftBundle>(&mut arg0.id, v3, v5);
        let v6 = NftBundleCreated{
            bundle_id  : v3,
            seller     : 0x2::tx_context::sender(arg4),
            price      : arg1,
            nft_count  : 0,
            fee_bps    : arg2,
            expires_at : v1,
            coin_type  : v4,
        };
        0x2::event::emit<NftBundleCreated>(v6);
        v3
    }

    public entry fun create_empty_bundle_entry<T0>(arg0: &mut MultiBundleStore, arg1: u64, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) {
        create_empty_bundle<T0>(arg0, arg1, arg2, 7776000, arg3);
    }

    public fun create_multi_bundle_store(arg0: &0x3836a23db29080cba7f68da685d18c1cff036a81db3e6e05f3e68bda265e0480::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) : MultiBundleStore {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x3836a23db29080cba7f68da685d18c1cff036a81db3e6e05f3e68bda265e0480::auctionhouse::is_admin(arg0, v0), 8);
        let v1 = 0x2::object::new(arg1);
        let v2 = MultiBundleStore{
            id               : v1,
            auction_house    : 0x2::object::id<0x3836a23db29080cba7f68da685d18c1cff036a81db3e6e05f3e68bda265e0480::auctionhouse::AuctionHouse>(arg0),
            reentrancy_guard : false,
        };
        let v3 = MultiBundleStoreCreated{
            store_id      : 0x2::object::uid_to_inner(&v1),
            auction_house : 0x2::object::id<0x3836a23db29080cba7f68da685d18c1cff036a81db3e6e05f3e68bda265e0480::auctionhouse::AuctionHouse>(arg0),
            creator       : v0,
        };
        0x2::event::emit<MultiBundleStoreCreated>(v3);
        v2
    }

    public fun get_bundle_buyer(arg0: &MultiBundleStore, arg1: 0x2::object::ID) : 0x1::option::Option<address> {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftBundle>(&arg0.id, arg1), 4);
        0x2::dynamic_object_field::borrow<0x2::object::ID, NftBundle>(&arg0.id, arg1).buyer
    }

    public fun get_bundle_nft_count(arg0: &MultiBundleStore, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftBundle>(&arg0.id, arg1), 4);
        0x2::dynamic_object_field::borrow<0x2::object::ID, NftBundle>(&arg0.id, arg1).nft_count
    }

    public fun get_bundle_nft_keys(arg0: &MultiBundleStore, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : vector<0x2::object::ID> {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftBundle>(&arg0.id, arg1), 4);
        0x2::dynamic_object_field::borrow<0x2::object::ID, NftBundle>(&arg0.id, arg1).nft_keys
    }

    public fun get_bundle_price(arg0: &MultiBundleStore, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftBundle>(&arg0.id, arg1), 4);
        0x2::dynamic_object_field::borrow<0x2::object::ID, NftBundle>(&arg0.id, arg1).price
    }

    public fun get_bundle_seller(arg0: &MultiBundleStore, arg1: 0x2::object::ID) : address {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftBundle>(&arg0.id, arg1), 4);
        0x2::dynamic_object_field::borrow<0x2::object::ID, NftBundle>(&arg0.id, arg1).seller
    }

    public fun get_bundle_status(arg0: &MultiBundleStore, arg1: 0x2::object::ID) : u8 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftBundle>(&arg0.id, arg1), 4);
        0x2::dynamic_object_field::borrow<0x2::object::ID, NftBundle>(&arg0.id, arg1).status
    }

    public fun is_bundle_expired(arg0: &MultiBundleStore, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : bool {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftBundle>(&arg0.id, arg1), 4);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftBundle>(&arg0.id, arg1);
        let v1 = is_safely_expired(v0.expires_at, arg2);
        if (v1) {
            let v2 = BundleExpired{
                bundle_id : arg1,
                seller    : v0.seller,
                nft_count : v0.nft_count,
                timestamp : 0x2::tx_context::epoch(arg2),
                coin_type : v0.coin_type,
            };
            0x2::event::emit<BundleExpired>(v2);
        };
        v1
    }

    public fun is_nft_in_bundle(arg0: &MultiBundleStore, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : bool {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftBundle>(&arg0.id, arg1), 4);
        verify_nft_in_bundle(0x2::dynamic_object_field::borrow<0x2::object::ID, NftBundle>(&arg0.id, arg1), arg2)
    }

    public fun is_safely_expired(arg0: u64, arg1: &0x2::tx_context::TxContext) : bool {
        0x2::tx_context::epoch(arg1) + 5 > arg0
    }

    fun verify_nft_in_bundle(arg0: &NftBundle, arg1: 0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg0.nft_keys)) {
            if (*0x1::vector::borrow<0x2::object::ID>(&arg0.nft_keys, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    // decompiled from Move bytecode v6
}

