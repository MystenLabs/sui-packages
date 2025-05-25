module 0x1afae51a7905eba2a8a3ece971c165b4ee5f030206e79c183244b1d568ff9fe7::multi_kiosk_bidding_house {
    struct Multi_Kiosk_Auctionhouse has store, key {
        id: 0x2::object::UID,
        auction_house: 0x2::object::ID,
        nft_to_bundle: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
    }

    struct Bundle<phantom T0> has store, key {
        id: 0x2::object::UID,
        seller: address,
        price: u64,
        status: u8,
        fee_bps: u16,
        expires_at_ms: u64,
        coin_type: 0x1::type_name::TypeName,
        buyer: 0x1::option::Option<address>,
        nfts: vector<0x2::object::ID>,
        created_at_ms: u64,
        cancellation_in_progress: bool,
    }

    struct BundledNft<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        bundle_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
        display_value: u64,
    }

    struct BundleCreated has copy, drop {
        bundle_id: 0x2::object::ID,
        seller: address,
        price: u64,
        coin_type: 0x1::type_name::TypeName,
        expires_at_ms: u64,
        duration_hours: u64,
        duration_days: u64,
        fee_bps: u16,
    }

    struct NftAdded has copy, drop {
        bundle_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        display_value: u64,
        total_nfts: u64,
    }

    struct BundleSold has copy, drop {
        bundle_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
        coin_type: 0x1::type_name::TypeName,
        fee_amount: u64,
        seller_amount: u64,
    }

    struct NftClaimed has copy, drop {
        bundle_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        buyer: address,
    }

    struct BundleCancelled has copy, drop {
        bundle_id: 0x2::object::ID,
        seller: address,
        nfts_count: u64,
        was_expired: bool,
        timestamp_ms: u64,
    }

    struct BundleNftReturned has copy, drop {
        bundle_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
        kiosk_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct BundleFullyCancelled has copy, drop {
        bundle_id: 0x2::object::ID,
        seller: address,
        timestamp_ms: u64,
    }

    struct CancellationStarted has copy, drop {
        bundle_id: 0x2::object::ID,
        seller: address,
        nfts_count: u64,
        timestamp_ms: u64,
    }

    struct CancellationCompleted has copy, drop {
        bundle_id: 0x2::object::ID,
        seller: address,
        timestamp_ms: u64,
    }

    public fun add_nft<T0: store + key, T1>(arg0: &mut Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Bundle<T1>>(&arg0.id, arg1), 4);
        assert!(0x2::kiosk::has_item(arg2, arg4), 10);
        assert!(0x2::kiosk::has_access(arg2, arg3), 11);
        assert!(0x2::kiosk::owner(arg2) == 0x2::tx_context::sender(arg7), 20);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Bundle<T1>>(&arg0.id, arg1);
        let v1 = 0x1::vector::length<0x2::object::ID>(&v0.nfts);
        assert!(v0.seller == 0x2::tx_context::sender(arg7), 3);
        assert!(v0.status == 0, 2);
        assert!(!v0.cancellation_in_progress, 23);
        assert!(0x2::clock::timestamp_ms(arg6) <= v0.expires_at_ms, 5);
        assert!(v1 < 10, 7);
        let v2 = BundledNft<T0>{
            id            : 0x2::object::new(arg7),
            bundle_id     : arg1,
            kiosk_id      : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            nft_id        : arg4,
            purchase_cap  : 0x2::kiosk::list_with_purchase_cap<T0>(arg2, arg3, arg4, arg5, arg7),
            display_value : arg5,
        };
        let v3 = 0x2::object::id<BundledNft<T0>>(&v2);
        0x2::dynamic_object_field::add<0x2::object::ID, BundledNft<T0>>(&mut arg0.id, v3, v2);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.nft_to_bundle, arg4, arg1);
        0x1::vector::push_back<0x2::object::ID>(&mut 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Bundle<T1>>(&mut arg0.id, arg1).nfts, v3);
        let v4 = NftAdded{
            bundle_id     : arg1,
            nft_id        : arg4,
            display_value : arg5,
            total_nfts    : v1 + 1,
        };
        0x2::event::emit<NftAdded>(v4);
    }

    public fun bundle_exists<T0>(arg0: &Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Bundle<T0>>(&arg0.id, arg1)
    }

    public fun buy_bundle<T0>(arg0: &mut Multi_Kiosk_Auctionhouse, arg1: &mut 0x1afae51a7905eba2a8a3ece971c165b4ee5f030206e79c183244b1d568ff9fe7::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Bundle<T0>>(&arg0.id, arg2), 4);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Bundle<T0>>(&mut arg0.id, arg2);
        assert!(v0.coin_type == 0x1::type_name::get<T0>(), 12);
        assert!(v0.status == 0, 2);
        assert!(!v0.cancellation_in_progress, 23);
        assert!(0x2::clock::timestamp_ms(arg4) <= v0.expires_at_ms, 5);
        assert!(v0.seller != 0x2::tx_context::sender(arg5), 8);
        assert!(0x2::coin::value<T0>(&arg3) >= v0.price, 9);
        let v1 = v0.price * (v0.fee_bps as u64) / 10000;
        let v2 = v0.price - v1;
        v0.status = 1;
        v0.buyer = 0x1::option::some<address>(0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v2, arg5), v0.seller);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v1, arg5), 0x1afae51a7905eba2a8a3ece971c165b4ee5f030206e79c183244b1d568ff9fe7::auctionhouse::get_owner(arg1));
        if (0x2::coin::value<T0>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<T0>(arg3);
        };
        let v3 = BundleSold{
            bundle_id     : arg2,
            seller        : v0.seller,
            buyer         : 0x2::tx_context::sender(arg5),
            price         : v0.price,
            coin_type     : 0x1::type_name::get<T0>(),
            fee_amount    : v1,
            seller_amount : v2,
        };
        0x2::event::emit<BundleSold>(v3);
    }

    public fun cancel_bundle_nft<T0: store + key, T1>(arg0: &mut Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Bundle<T1>>(&arg0.id, arg1), 4);
        assert!(0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.nft_to_bundle, arg2), 18);
        assert!(0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.nft_to_bundle, arg2) == &arg1, 18);
        let v2 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Bundle<T1>>(&arg0.id, arg1);
        assert!(v0 == v2.seller, 16);
        assert!(v2.status == 2, 17);
        assert!(v2.cancellation_in_progress, 17);
        let v3 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Bundle<T1>>(&arg0.id, arg1);
        let v4 = 0x1::option::none<0x2::object::ID>();
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x2::object::ID>(&v3.nfts)) {
            let v6 = *0x1::vector::borrow<0x2::object::ID>(&v3.nfts, v5);
            if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, BundledNft<T0>>(&arg0.id, v6)) {
                if (0x2::dynamic_object_field::borrow<0x2::object::ID, BundledNft<T0>>(&arg0.id, v6).nft_id == arg2) {
                    v4 = 0x1::option::some<0x2::object::ID>(v6);
                    break
                };
            };
            v5 = v5 + 1;
        };
        assert!(0x1::option::is_some<0x2::object::ID>(&v4), 18);
        let v7 = *0x1::option::borrow<0x2::object::ID>(&v4);
        let BundledNft {
            id            : v8,
            bundle_id     : _,
            kiosk_id      : v10,
            nft_id        : _,
            purchase_cap  : v12,
            display_value : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, BundledNft<T0>>(&mut arg0.id, v7);
        0x2::table::remove<0x2::object::ID, 0x2::object::ID>(&mut arg0.nft_to_bundle, arg2);
        let v14 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Bundle<T1>>(&mut arg0.id, arg1);
        let (v15, v16) = 0x1::vector::index_of<0x2::object::ID>(&v14.nfts, &v7);
        if (v15) {
            0x1::vector::remove<0x2::object::ID>(&mut v14.nfts, v16);
        };
        0x2::kiosk::return_purchase_cap<T0>(arg3, v12);
        0x2::object::delete(v8);
        let v17 = BundleNftReturned{
            bundle_id    : arg1,
            nft_id       : arg2,
            seller       : v0,
            kiosk_id     : v10,
            timestamp_ms : v1,
        };
        0x2::event::emit<BundleNftReturned>(v17);
        if (0x1::vector::is_empty<0x2::object::ID>(&v14.nfts)) {
            complete_bundle_cancellation<T1>(arg0, arg1, v1);
        };
    }

    public entry fun cancel_bundle_nft_entry<T0: store + key, T1>(arg0: &mut Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        cancel_bundle_nft<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun claim_nft<T0: store + key, T1>(arg0: &mut Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Bundle<T1>>(&arg0.id, arg1);
        assert!(v0.status == 1, 2);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(0x1::option::contains<address>(&v0.buyer, &v1), 6);
        let BundledNft {
            id            : v2,
            bundle_id     : _,
            kiosk_id      : _,
            nft_id        : v5,
            purchase_cap  : v6,
            display_value : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, BundledNft<T0>>(&mut arg0.id, arg2);
        if (0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.nft_to_bundle, v5)) {
            0x2::table::remove<0x2::object::ID, 0x2::object::ID>(&mut arg0.nft_to_bundle, v5);
        };
        let v8 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Bundle<T1>>(&mut arg0.id, arg1);
        let (v9, v10) = 0x1::vector::index_of<0x2::object::ID>(&v8.nfts, &arg2);
        if (v9) {
            0x1::vector::remove<0x2::object::ID>(&mut v8.nfts, v10);
        };
        0x2::object::delete(v2);
        let (v11, v12) = 0x2::kiosk::purchase_with_cap<T0>(arg3, v6, 0x2::coin::zero<0x2::sui::SUI>(arg5));
        let v13 = NftClaimed{
            bundle_id : arg1,
            nft_id    : v5,
            buyer     : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<NftClaimed>(v13);
        (v11, v12)
    }

    public entry fun claim_nft_to_new_kiosk<T0: store + key, T1>(arg0: &mut Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg6);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = claim_nft<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6);
        let v6 = v5;
        0x2::kiosk::lock<T0>(&mut v3, &v2, arg4, v4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg4, &mut v6, arg5);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v6, &v3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v6);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v3, v2, arg6), arg6);
    }

    fun complete_bundle_cancellation<T0>(arg0: &mut Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID, arg2: u64) {
        let Bundle {
            id                       : v0,
            seller                   : v1,
            price                    : _,
            status                   : _,
            fee_bps                  : _,
            expires_at_ms            : _,
            coin_type                : _,
            buyer                    : _,
            nfts                     : v8,
            created_at_ms            : _,
            cancellation_in_progress : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Bundle<T0>>(&mut arg0.id, arg1);
        0x1::vector::destroy_empty<0x2::object::ID>(v8);
        0x2::object::delete(v0);
        let v11 = BundleFullyCancelled{
            bundle_id    : arg1,
            seller       : v1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<BundleFullyCancelled>(v11);
        let v12 = CancellationCompleted{
            bundle_id    : arg1,
            seller       : v1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<CancellationCompleted>(v12);
    }

    public fun create_bundle_days<T0>(arg0: &mut Multi_Kiosk_Auctionhouse, arg1: u64, arg2: u16, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        create_bundle_with_duration<T0>(arg0, arg1, arg2, days_to_ms(arg3), arg4, arg5)
    }

    public fun create_bundle_hours<T0>(arg0: &mut Multi_Kiosk_Auctionhouse, arg1: u64, arg2: u16, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        create_bundle_with_duration<T0>(arg0, arg1, arg2, hours_to_ms(arg3), arg4, arg5)
    }

    public fun create_bundle_with_duration<T0>(arg0: &mut Multi_Kiosk_Auctionhouse, arg1: u64, arg2: u16, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg1 > 0, 1);
        assert!(arg2 <= 1000, 21);
        validate_duration(arg3);
        let v0 = 0x2::object::new(arg5);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        let v3 = safe_add_u64(v2, arg3);
        let v4 = Bundle<T0>{
            id                       : v0,
            seller                   : 0x2::tx_context::sender(arg5),
            price                    : arg1,
            status                   : 0,
            fee_bps                  : arg2,
            expires_at_ms            : v3,
            coin_type                : 0x1::type_name::get<T0>(),
            buyer                    : 0x1::option::none<address>(),
            nfts                     : 0x1::vector::empty<0x2::object::ID>(),
            created_at_ms            : v2,
            cancellation_in_progress : false,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Bundle<T0>>(&mut arg0.id, v1, v4);
        let v5 = BundleCreated{
            bundle_id      : v1,
            seller         : 0x2::tx_context::sender(arg5),
            price          : arg1,
            coin_type      : 0x1::type_name::get<T0>(),
            expires_at_ms  : v3,
            duration_hours : arg3 / 3600000,
            duration_days  : arg3 / 86400000,
            fee_bps        : arg2,
        };
        0x2::event::emit<BundleCreated>(v5);
        v1
    }

    public entry fun create_shared_store(arg0: &0x1afae51a7905eba2a8a3ece971c165b4ee5f030206e79c183244b1d568ff9fe7::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1afae51a7905eba2a8a3ece971c165b4ee5f030206e79c183244b1d568ff9fe7::auctionhouse::is_admin(arg0, 0x2::tx_context::sender(arg1)), 999);
        let v0 = Multi_Kiosk_Auctionhouse{
            id            : 0x2::object::new(arg1),
            auction_house : 0x2::object::id<0x1afae51a7905eba2a8a3ece971c165b4ee5f030206e79c183244b1d568ff9fe7::auctionhouse::AuctionHouse>(arg0),
            nft_to_bundle : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg1),
        };
        0x2::transfer::share_object<Multi_Kiosk_Auctionhouse>(v0);
    }

    public fun create_store(arg0: &0x1afae51a7905eba2a8a3ece971c165b4ee5f030206e79c183244b1d568ff9fe7::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) : Multi_Kiosk_Auctionhouse {
        assert!(0x1afae51a7905eba2a8a3ece971c165b4ee5f030206e79c183244b1d568ff9fe7::auctionhouse::is_admin(arg0, 0x2::tx_context::sender(arg1)), 999);
        Multi_Kiosk_Auctionhouse{
            id            : 0x2::object::new(arg1),
            auction_house : 0x2::object::id<0x1afae51a7905eba2a8a3ece971c165b4ee5f030206e79c183244b1d568ff9fe7::auctionhouse::AuctionHouse>(arg0),
            nft_to_bundle : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg1),
        }
    }

    public fun days_to_ms(arg0: u64) : u64 {
        let v0 = safe_mul_u64(arg0, 86400000);
        validate_duration(v0);
        v0
    }

    public fun get_bundle_expiration_info<T0>(arg0: &Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : (u64, u64, u64, bool) {
        let v0 = get_remaining_time_ms<T0>(arg0, arg1, arg2);
        (v0, v0 / 3600000, v0 / 86400000, v0 == 0)
    }

    public fun get_bundle_info<T0>(arg0: &Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID) : (address, u64, u8, u64, 0x1::type_name::TypeName, 0x1::option::Option<address>, bool) {
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Bundle<T0>>(&arg0.id, arg1);
        (v0.seller, v0.price, v0.status, v0.expires_at_ms, v0.coin_type, v0.buyer, v0.cancellation_in_progress)
    }

    public fun get_bundle_info_with_time<T0>(arg0: &Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : (u64, u8, u64, 0x1::type_name::TypeName, u64, bool, bool) {
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Bundle<T0>>(&arg0.id, arg1);
        (v0.price, v0.status, 0x1::vector::length<0x2::object::ID>(&v0.nfts), v0.coin_type, get_remaining_time_ms<T0>(arg0, arg1, arg2), 0x2::clock::timestamp_ms(arg2) > v0.expires_at_ms, v0.cancellation_in_progress)
    }

    public fun get_duration_limits() : (u64, u64, u64, u64) {
        (3600000, 31536000000, get_min_duration_hours(), get_max_duration_days())
    }

    public fun get_fee_info() : (u16, u16) {
        (0, 1000)
    }

    public fun get_max_duration_days() : u64 {
        31536000000 / 86400000
    }

    public fun get_max_duration_ms() : u64 {
        31536000000
    }

    public fun get_min_duration_hours() : u64 {
        3600000 / 3600000
    }

    public fun get_min_duration_ms() : u64 {
        3600000
    }

    public fun get_nft_bundle_id(arg0: &Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.nft_to_bundle, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.nft_to_bundle, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun get_remaining_days<T0>(arg0: &Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        get_remaining_time_ms<T0>(arg0, arg1, arg2) / 86400000
    }

    public fun get_remaining_hours<T0>(arg0: &Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        get_remaining_time_ms<T0>(arg0, arg1, arg2) / 3600000
    }

    public fun get_remaining_nfts<T0>(arg0: &Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID) : vector<0x2::object::ID> {
        0x2::dynamic_object_field::borrow<0x2::object::ID, Bundle<T0>>(&arg0.id, arg1).nfts
    }

    public fun get_remaining_time_ms<T0>(arg0: &Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Bundle<T0>>(&arg0.id, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (v1 >= v0.expires_at_ms) {
            0
        } else {
            v0.expires_at_ms - v1
        }
    }

    public fun hours_to_ms(arg0: u64) : u64 {
        let v0 = safe_mul_u64(arg0, 3600000);
        validate_duration(v0);
        v0
    }

    public fun is_bundle_expired<T0>(arg0: &Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg2) > 0x2::dynamic_object_field::borrow<0x2::object::ID, Bundle<T0>>(&arg0.id, arg1).expires_at_ms
    }

    public fun is_valid_duration(arg0: u64) : bool {
        arg0 >= 3600000 && arg0 <= 31536000000
    }

    public fun minutes_to_ms(arg0: u64) : u64 {
        let v0 = safe_mul_u64(arg0, 60000);
        validate_duration(v0);
        v0
    }

    fun safe_add_u64(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 19);
        arg0 + arg1
    }

    fun safe_mul_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg0 <= 18446744073709551615 / arg1, 19);
        arg0 * arg1
    }

    public fun start_bundle_cancellation<T0>(arg0: &mut Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Bundle<T0>>(&arg0.id, arg1), 4);
        let v2 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Bundle<T0>>(&arg0.id, arg1);
        let v3 = 0x1::vector::length<0x2::object::ID>(&v2.nfts);
        let v4 = v2.expires_at_ms;
        assert!(v0 == v2.seller, 16);
        assert!(v2.status == 0, 2);
        assert!(!v2.cancellation_in_progress, 23);
        let v5 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Bundle<T0>>(&mut arg0.id, arg1);
        v5.status = 2;
        v5.cancellation_in_progress = true;
        let v6 = CancellationStarted{
            bundle_id    : arg1,
            seller       : v0,
            nfts_count   : v3,
            timestamp_ms : v1,
        };
        0x2::event::emit<CancellationStarted>(v6);
        let v7 = BundleCancelled{
            bundle_id    : arg1,
            seller       : v0,
            nfts_count   : v3,
            was_expired  : v1 > v4,
            timestamp_ms : v1,
        };
        0x2::event::emit<BundleCancelled>(v7);
    }

    public entry fun start_bundle_cancellation_entry<T0>(arg0: &mut Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        start_bundle_cancellation<T0>(arg0, arg1, arg2, arg3);
    }

    public fun try_days_to_ms(arg0: u64) : 0x1::option::Option<u64> {
        let v0 = arg0 * 86400000;
        if (is_valid_duration(v0)) {
            0x1::option::some<u64>(v0)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun try_hours_to_ms(arg0: u64) : 0x1::option::Option<u64> {
        let v0 = arg0 * 3600000;
        if (is_valid_duration(v0)) {
            0x1::option::some<u64>(v0)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun validate_duration(arg0: u64) {
        assert!(arg0 >= 3600000, 14);
        assert!(arg0 <= 31536000000, 15);
    }

    public fun weeks_to_ms(arg0: u64) : u64 {
        let v0 = safe_mul_u64(arg0, 604800000);
        validate_duration(v0);
        v0
    }

    // decompiled from Move bytecode v6
}

