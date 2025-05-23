module 0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::multi_kiosk_bidding_house {
    struct MultiBundleStore has store, key {
        id: 0x2::object::UID,
        auction_house: 0x2::object::ID,
        owner: address,
        paused: bool,
        reentrancy_guard: bool,
        operation_lock_holder: 0x1::option::Option<address>,
        operation_in_progress: bool,
        last_operation: 0x1::option::Option<OperationDetails>,
        bundle_counter: u64,
        global_nonce: u64,
        active_operations: 0x2::table::Table<0x2::object::ID, OperationLock>,
    }

    struct OperationLock has drop, store {
        operation_type: u8,
        lock_holder: address,
        timestamp: u64,
        nonce: u64,
    }

    struct OperationDetails has drop, store {
        operation_type: u8,
        bundle_id: 0x2::object::ID,
        timestamp: u64,
        additional_data: vector<u8>,
        initiator: address,
        nonce: u64,
        expected_completion: u64,
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
        nft_key_table: 0x2::table::Table<0x2::object::ID, NftInfo>,
        integrity_hash: vector<u8>,
        version: u64,
        last_modified: u64,
        bundle_nonce: u64,
    }

    struct NftInfo has drop, store {
        nft_type: 0x1::type_name::TypeName,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        claimed: bool,
        added_at: u64,
        validation_hash: vector<u8>,
    }

    struct BundledNft<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        bundle_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
        validated_at: u64,
        nft_hash: vector<u8>,
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
        nonce: u64,
    }

    struct NftAddedToBundle has copy, drop {
        bundle_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        nft_type: 0x1::type_name::TypeName,
        nft_key: 0x2::object::ID,
        bundle_version: u64,
    }

    struct BundlePurchased has copy, drop {
        bundle_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
        nft_count: u64,
        coin_type: 0x1::type_name::TypeName,
        purchase_nonce: u64,
    }

    struct BundleNftClaimed has copy, drop {
        bundle_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        buyer: address,
        nft_type: 0x1::type_name::TypeName,
        claim_nonce: u64,
    }

    struct BundleCancelledAtomic has copy, drop {
        bundle_id: 0x2::object::ID,
        seller: address,
        nft_count: u64,
        coin_type: 0x1::type_name::TypeName,
        nfts_returned: u64,
    }

    struct BundleExpired has copy, drop {
        bundle_id: 0x2::object::ID,
        seller: address,
        nft_count: u64,
        timestamp: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct OperationRecoveryAttempted has copy, drop {
        bundle_id: 0x2::object::ID,
        operation_type: u8,
        timestamp: u64,
        success: bool,
        recovery_type: u8,
        recovery_reason: u8,
    }

    struct ContractPauseToggled has copy, drop {
        paused: bool,
        admin: address,
        timestamp: u64,
    }

    struct BundleIntegrityValidated has copy, drop {
        bundle_id: 0x2::object::ID,
        expected_count: u64,
        actual_count: u64,
        valid: bool,
        version: u64,
    }

    struct OperationLockAcquired has copy, drop {
        bundle_id: 0x2::object::ID,
        operation_type: u8,
        lock_holder: address,
        nonce: u64,
        timestamp: u64,
    }

    struct OperationLockReleased has copy, drop {
        bundle_id: 0x2::object::ID,
        operation_type: u8,
        lock_holder: address,
        nonce: u64,
        timestamp: u64,
    }

    fun acquire_operation_lock(arg0: &mut MultiBundleStore, arg1: 0x2::object::ID, arg2: u8, arg3: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::tx_context::epoch(arg3);
        if (0x2::table::contains<0x2::object::ID, OperationLock>(&arg0.active_operations, arg1)) {
            let v2 = 0x2::table::borrow<0x2::object::ID, OperationLock>(&arg0.active_operations, arg1);
            if (v1 > v2.timestamp + 600) {
                0x2::table::remove<0x2::object::ID, OperationLock>(&mut arg0.active_operations, arg1);
            } else {
                assert!(v2.lock_holder == v0, 35);
            };
        };
        arg0.global_nonce = arg0.global_nonce + 1;
        let v3 = arg0.global_nonce;
        let v4 = OperationLock{
            operation_type : arg2,
            lock_holder    : v0,
            timestamp      : v1,
            nonce          : v3,
        };
        0x2::table::add<0x2::object::ID, OperationLock>(&mut arg0.active_operations, arg1, v4);
        let v5 = OperationLockAcquired{
            bundle_id      : arg1,
            operation_type : arg2,
            lock_holder    : v0,
            nonce          : v3,
            timestamp      : v1,
        };
        0x2::event::emit<OperationLockAcquired>(v5);
        v3
    }

    public fun add_nft_to_bundle<T0: store + key>(arg0: &mut MultiBundleStore, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        assert_not_paused(arg0);
        let v0 = acquire_operation_lock(arg0, arg1, 2, arg5);
        let v1 = start_operation_secure(arg0, 2, arg1, 0x1::vector::empty<u8>(), arg5);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftBundle>(&arg0.id, arg1), 4);
        assert!(0x2::kiosk::has_item(arg2, arg4), 13);
        assert!(0x2::kiosk::has_access(arg2, arg3), 5);
        let v2 = 0x2::tx_context::epoch(arg5);
        let v3 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftBundle>(&arg0.id, arg1);
        assert!(validate_bundle_integrity(v3), 27);
        assert!(0x2::tx_context::sender(arg5) == v3.seller, 3);
        assert!(v3.status == 0, 2);
        assert!(!is_safely_expired(v3.expires_at, arg5), 9);
        assert!(v3.nft_count < 50, 23);
        assert!(validate_nft_in_kiosk<T0>(arg2, arg4, 0x2::object::id<0x2::kiosk::Kiosk>(arg2)), 33);
        let v4 = BundledNft<T0>{
            id           : 0x2::object::new(arg5),
            bundle_id    : arg1,
            kiosk_id     : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            nft_id       : arg4,
            purchase_cap : 0x2::kiosk::list_with_purchase_cap<T0>(arg2, arg3, arg4, 0, arg5),
            validated_at : v2,
            nft_hash     : generate_nft_hash(arg4, 0x2::object::id<0x2::kiosk::Kiosk>(arg2), 0x1::type_name::get<T0>()),
        };
        let v5 = 0x2::object::id<BundledNft<T0>>(&v4);
        0x2::dynamic_object_field::add<0x2::object::ID, BundledNft<T0>>(&mut arg0.id, v5, v4);
        let v6 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, NftBundle>(&mut arg0.id, arg1);
        let v7 = NftInfo{
            nft_type        : 0x1::type_name::get<T0>(),
            kiosk_id        : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            nft_id          : arg4,
            claimed         : false,
            added_at        : v2,
            validation_hash : generate_nft_hash(arg4, 0x2::object::id<0x2::kiosk::Kiosk>(arg2), 0x1::type_name::get<T0>()),
        };
        0x2::table::add<0x2::object::ID, NftInfo>(&mut v6.nft_key_table, v5, v7);
        v6.nft_count = v6.nft_count + 1;
        v6.version = v6.version + 1;
        v6.last_modified = v2;
        v6.integrity_hash = generate_integrity_hash(&v6.nft_key_table, v6.version, v6.nft_count);
        let v8 = NftAddedToBundle{
            bundle_id      : arg1,
            nft_id         : arg4,
            kiosk_id       : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            nft_type       : 0x1::type_name::get<T0>(),
            nft_key        : v5,
            bundle_version : v6.version,
        };
        0x2::event::emit<NftAddedToBundle>(v8);
        end_operation_secure(arg0, v1);
        release_operation_lock(arg0, arg1, v0, arg5);
    }

    fun assert_no_self_trade(arg0: address, arg1: address) {
        assert!(arg0 != arg1, 29);
    }

    fun assert_not_paused(arg0: &MultiBundleStore) {
        assert!(!arg0.paused, 25);
    }

    fun assert_owner(arg0: &MultiBundleStore, arg1: address) {
        assert!(arg0.owner == arg1, 26);
    }

    public entry fun attempt_automatic_recovery(arg0: &mut MultiBundleStore, arg1: &mut 0x2::tx_context::TxContext) {
        if (!arg0.operation_in_progress || 0x1::option::is_none<OperationDetails>(&arg0.last_operation)) {
            return
        };
        let v0 = 0x1::option::borrow<OperationDetails>(&arg0.last_operation);
        let v1 = 0x2::tx_context::epoch(arg1);
        if (v1 < v0.expected_completion) {
            return
        };
        let v2 = v0.bundle_id;
        let v3 = v0.operation_type;
        let v4 = false;
        let v5 = 1;
        let v6 = 0x2::tx_context::sender(arg1);
        if (v6 != v0.initiator && v6 != arg0.owner) {
            return
        };
        if (v3 == 1) {
            arg0.operation_in_progress = false;
            arg0.operation_lock_holder = 0x1::option::none<address>();
            v4 = true;
        } else if (v3 == 3) {
            if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftBundle>(&arg0.id, v2)) {
                let v7 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftBundle>(&arg0.id, v2);
                if (v7.status == 1 || v7.status == 4) {
                    if (v7.status == 4) {
                        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, NftBundle>(&mut arg0.id, v2).status = 1;
                        v5 = 2;
                    };
                    arg0.operation_in_progress = false;
                    arg0.operation_lock_holder = 0x1::option::none<address>();
                    v4 = true;
                };
            };
        } else if (v3 == 4) {
            arg0.operation_in_progress = false;
            arg0.operation_lock_holder = 0x1::option::none<address>();
            v4 = true;
        };
        if (0x2::table::contains<0x2::object::ID, OperationLock>(&arg0.active_operations, v2)) {
            if (v1 > 0x2::table::borrow<0x2::object::ID, OperationLock>(&arg0.active_operations, v2).timestamp + 600) {
                0x2::table::remove<0x2::object::ID, OperationLock>(&mut arg0.active_operations, v2);
            };
        };
        let v8 = OperationRecoveryAttempted{
            bundle_id       : v2,
            operation_type  : v3,
            timestamp       : v1,
            success         : v4,
            recovery_type   : 3,
            recovery_reason : v5,
        };
        0x2::event::emit<OperationRecoveryAttempted>(v8);
    }

    public fun bundle_exists(arg0: &MultiBundleStore, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftBundle>(&arg0.id, arg1)
    }

    public fun buy_bundle<T0>(arg0: &mut MultiBundleStore, arg1: &mut 0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_not_paused(arg0);
        let v0 = acquire_operation_lock(arg0, arg2, 3, arg4);
        let v1 = start_operation_secure(arg0, 3, arg2, 0x1::vector::empty<u8>(), arg4);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftBundle>(&arg0.id, arg2), 4);
        let v2 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftBundle>(&arg0.id, arg2);
        assert!(validate_bundle_integrity(v2), 27);
        assert!(v2.status == 0, 2);
        assert!(!is_safely_expired(v2.expires_at, arg4), 9);
        assert!(v2.nft_count > 0, 15);
        assert_no_self_trade(v2.seller, 0x2::tx_context::sender(arg4));
        let v3 = v2.coin_type;
        assert!(v3 == 0x1::type_name::get<T0>(), 11);
        let v4 = v2.price;
        assert!(0x2::coin::value<T0>(&arg3) == v4, 19);
        let v5 = v2.seller;
        let v6 = v2.nft_count;
        let v7 = 0x2::coin::split<T0>(&mut arg3, 0x2::coin::value<T0>(&arg3) * (v2.fee_bps as u64) / 10000, arg4);
        arg0.global_nonce = arg0.global_nonce + 1;
        let v8 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, NftBundle>(&mut arg0.id, arg2);
        v8.status = 4;
        v8.buyer = 0x1::option::some<address>(0x2::tx_context::sender(arg4));
        v8.version = v8.version + 1;
        v8.last_modified = 0x2::tx_context::epoch(arg4);
        v8.integrity_hash = generate_integrity_hash(&v8.nft_key_table, v8.version, v8.nft_count);
        let v9 = BundlePurchased{
            bundle_id      : arg2,
            seller         : v5,
            buyer          : 0x2::tx_context::sender(arg4),
            price          : v4,
            nft_count      : v6,
            coin_type      : v3,
            purchase_nonce : arg0.global_nonce,
        };
        0x2::event::emit<BundlePurchased>(v9);
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, NftBundle>(&mut arg0.id, arg2).status = 1;
        end_operation_secure(arg0, v1);
        release_operation_lock(arg0, arg2, v0, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, 0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::get_owner(arg1));
    }

    public fun claim_bundle_nft<T0: store + key>(arg0: &mut MultiBundleStore, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        assert_not_paused(arg0);
        let v0 = acquire_operation_lock(arg0, arg1, 4, arg5);
        let v1 = start_operation_secure(arg0, 4, arg1, 0x1::vector::empty<u8>(), arg5);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftBundle>(&arg0.id, arg1), 4);
        let v2 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftBundle>(&arg0.id, arg1);
        assert!(validate_bundle_integrity(v2), 27);
        assert!(v2.status == 1, 18);
        assert!(0x1::option::is_some<address>(&v2.buyer), 18);
        let v3 = *0x1::option::borrow<address>(&v2.buyer);
        assert!(0x2::tx_context::sender(arg5) == v3, 17);
        assert!(0x2::table::contains<0x2::object::ID, NftInfo>(&v2.nft_key_table, arg2), 20);
        let v4 = 0x2::table::borrow<0x2::object::ID, NftInfo>(&v2.nft_key_table, arg2);
        assert!(!v4.claimed, 16);
        let v5 = v4.nft_id;
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, BundledNft<T0>>(&arg0.id, arg2), 13);
        assert!(validate_nft_in_kiosk<T0>(arg3, v5, v4.kiosk_id), 33);
        let BundledNft {
            id           : v6,
            bundle_id    : v7,
            kiosk_id     : v8,
            nft_id       : v9,
            purchase_cap : v10,
            validated_at : _,
            nft_hash     : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, BundledNft<T0>>(&mut arg0.id, arg2);
        assert!(v7 == arg1, 4);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg3) == v8, 6);
        assert!(v9 == v5, 13);
        arg0.global_nonce = arg0.global_nonce + 1;
        let v13 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, NftBundle>(&mut arg0.id, arg1);
        0x2::table::borrow_mut<0x2::object::ID, NftInfo>(&mut v13.nft_key_table, arg2).claimed = true;
        v13.version = v13.version + 1;
        v13.last_modified = 0x2::tx_context::epoch(arg5);
        v13.integrity_hash = generate_integrity_hash(&v13.nft_key_table, v13.version, v13.nft_count);
        let v14 = BundleNftClaimed{
            bundle_id   : arg1,
            nft_id      : v5,
            buyer       : v3,
            nft_type    : 0x1::type_name::get<T0>(),
            claim_nonce : arg0.global_nonce,
        };
        0x2::event::emit<BundleNftClaimed>(v14);
        0x2::object::delete(v6);
        end_operation_secure(arg0, v1);
        release_operation_lock(arg0, arg1, v0, arg5);
        0x2::kiosk::purchase_with_cap<T0>(arg3, v10, 0x2::coin::zero<0x2::sui::SUI>(arg5))
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

    public entry fun create_and_share_multi_bundle_store(arg0: &0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<MultiBundleStore>(create_multi_bundle_store(arg0, arg1));
    }

    public fun create_empty_bundle<T0>(arg0: &mut MultiBundleStore, arg1: u64, arg2: u16, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_not_paused(arg0);
        assert!(arg1 > 0, 1);
        assert!(arg2 <= 1000, 14);
        assert!(arg3 > 0 && arg3 <= 7776000 * 2, 10);
        let v0 = 0x2::tx_context::epoch(arg4);
        let v1 = v0 + arg3;
        let v2 = 0x2::object::new(arg4);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = acquire_operation_lock(arg0, v3, 1, arg4);
        let v5 = start_operation_secure(arg0, 1, v3, 0x1::vector::empty<u8>(), arg4);
        let v6 = 0x1::type_name::get<T0>();
        let v7 = 0x2::table::new<0x2::object::ID, NftInfo>(arg4);
        arg0.bundle_counter = arg0.bundle_counter + 1;
        let v8 = arg0.bundle_counter;
        let v9 = NftBundle{
            id             : v2,
            seller         : 0x2::tx_context::sender(arg4),
            price          : arg1,
            status         : 0,
            fee_bps        : arg2,
            created_at     : v0,
            expires_at     : v1,
            coin_type      : v6,
            nft_count      : 0,
            buyer          : 0x1::option::none<address>(),
            nft_key_table  : v7,
            integrity_hash : generate_integrity_hash(&v7, 0, 0),
            version        : 0,
            last_modified  : v0,
            bundle_nonce   : v8,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, NftBundle>(&mut arg0.id, v3, v9);
        let v10 = NftBundleCreated{
            bundle_id  : v3,
            seller     : 0x2::tx_context::sender(arg4),
            price      : arg1,
            nft_count  : 0,
            fee_bps    : arg2,
            expires_at : v1,
            coin_type  : v6,
            nonce      : v8,
        };
        0x2::event::emit<NftBundleCreated>(v10);
        end_operation_secure(arg0, v5);
        release_operation_lock(arg0, v3, v4, arg4);
        v3
    }

    public fun create_multi_bundle_store(arg0: &0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) : MultiBundleStore {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::is_admin(arg0, v0), 8);
        let v1 = 0x2::object::new(arg1);
        let v2 = MultiBundleStore{
            id                    : v1,
            auction_house         : 0x2::object::id<0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse>(arg0),
            owner                 : v0,
            paused                : false,
            reentrancy_guard      : false,
            operation_lock_holder : 0x1::option::none<address>(),
            operation_in_progress : false,
            last_operation        : 0x1::option::none<OperationDetails>(),
            bundle_counter        : 0,
            global_nonce          : 0,
            active_operations     : 0x2::table::new<0x2::object::ID, OperationLock>(arg1),
        };
        let v3 = MultiBundleStoreCreated{
            store_id      : 0x2::object::uid_to_inner(&v1),
            auction_house : 0x2::object::id<0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse>(arg0),
            creator       : v0,
        };
        0x2::event::emit<MultiBundleStoreCreated>(v3);
        v2
    }

    public entry fun emergency_recovery(arg0: &mut MultiBundleStore, arg1: 0x2::object::ID, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x2::tx_context::epoch(arg3);
        let v1 = false;
        if (arg0.operation_in_progress && 0x1::option::is_some<OperationDetails>(&arg0.last_operation)) {
            if (v0 > 0x1::option::borrow<OperationDetails>(&arg0.last_operation).expected_completion) {
                v1 = true;
            };
        };
        assert!(v1 || arg2 == 4, 34);
        arg0.operation_in_progress = false;
        arg0.operation_lock_holder = 0x1::option::none<address>();
        arg0.last_operation = 0x1::option::none<OperationDetails>();
        if (0x2::table::contains<0x2::object::ID, OperationLock>(&arg0.active_operations, arg1)) {
            0x2::table::remove<0x2::object::ID, OperationLock>(&mut arg0.active_operations, arg1);
        };
        let v2 = OperationRecoveryAttempted{
            bundle_id       : arg1,
            operation_type  : 0,
            timestamp       : v0,
            success         : true,
            recovery_type   : 2,
            recovery_reason : arg2,
        };
        0x2::event::emit<OperationRecoveryAttempted>(v2);
    }

    fun end_operation_secure(arg0: &mut MultiBundleStore, arg1: u64) {
        if (0x1::option::is_some<OperationDetails>(&arg0.last_operation)) {
            assert!(0x1::option::borrow<OperationDetails>(&arg0.last_operation).nonce == arg1, 31);
        };
        arg0.operation_in_progress = false;
        arg0.operation_lock_holder = 0x1::option::none<address>();
    }

    fun generate_integrity_hash(arg0: &0x2::table::Table<0x2::object::ID, NftInfo>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, (0x2::table::length<0x2::object::ID, NftInfo>(arg0) as u8));
        0x1::vector::push_back<u8>(&mut v0, (arg1 as u8));
        0x1::vector::push_back<u8>(&mut v0, (arg2 as u8));
        v0
    }

    fun generate_nft_hash(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::type_name::TypeName>(&arg2));
        0x2::hash::blake2b256(&v0)
    }

    public fun get_bundle_price(arg0: &MultiBundleStore, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftBundle>(&arg0.id, arg1), 4);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftBundle>(&arg0.id, arg1);
        assert!(validate_bundle_integrity(v0), 27);
        v0.price
    }

    public fun get_bundle_status(arg0: &MultiBundleStore, arg1: 0x2::object::ID) : u8 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftBundle>(&arg0.id, arg1), 4);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftBundle>(&arg0.id, arg1);
        assert!(validate_bundle_integrity(v0), 27);
        v0.status
    }

    public fun get_store_owner(arg0: &MultiBundleStore) : address {
        arg0.owner
    }

    public fun is_paused(arg0: &MultiBundleStore) : bool {
        arg0.paused
    }

    public fun is_safely_expired(arg0: u64, arg1: &0x2::tx_context::TxContext) : bool {
        0x2::tx_context::epoch(arg1) + 5 > arg0
    }

    public entry fun pause_contract(arg0: &mut MultiBundleStore, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert_owner(arg0, v0);
        arg0.paused = true;
        let v1 = ContractPauseToggled{
            paused    : true,
            admin     : v0,
            timestamp : 0x2::tx_context::epoch(arg1),
        };
        0x2::event::emit<ContractPauseToggled>(v1);
    }

    fun release_operation_lock(arg0: &mut MultiBundleStore, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        if (0x2::table::contains<0x2::object::ID, OperationLock>(&arg0.active_operations, arg1)) {
            let v1 = 0x2::table::remove<0x2::object::ID, OperationLock>(&mut arg0.active_operations, arg1);
            assert!(v1.lock_holder == v0, 35);
            assert!(v1.nonce == arg2, 31);
            let v2 = OperationLockReleased{
                bundle_id      : arg1,
                operation_type : v1.operation_type,
                lock_holder    : v0,
                nonce          : v1.nonce,
                timestamp      : 0x2::tx_context::epoch(arg3),
            };
            0x2::event::emit<OperationLockReleased>(v2);
        };
    }

    fun start_operation_secure(arg0: &mut MultiBundleStore, arg1: u8, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) : u64 {
        assert!(!arg0.operation_in_progress, 24);
        let v0 = 0x2::tx_context::epoch(arg4);
        arg0.global_nonce = arg0.global_nonce + 1;
        let v1 = arg0.global_nonce;
        arg0.operation_in_progress = true;
        arg0.operation_lock_holder = 0x1::option::some<address>(0x2::tx_context::sender(arg4));
        let v2 = OperationDetails{
            operation_type      : arg1,
            bundle_id           : arg2,
            timestamp           : v0,
            additional_data     : arg3,
            initiator           : 0x2::tx_context::sender(arg4),
            nonce               : v1,
            expected_completion : v0 + 600,
        };
        arg0.last_operation = 0x1::option::some<OperationDetails>(v2);
        v1
    }

    public entry fun unpause_contract(arg0: &mut MultiBundleStore, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert_owner(arg0, v0);
        arg0.paused = false;
        let v1 = ContractPauseToggled{
            paused    : false,
            admin     : v0,
            timestamp : 0x2::tx_context::epoch(arg1),
        };
        0x2::event::emit<ContractPauseToggled>(v1);
    }

    fun validate_bundle_integrity(arg0: &NftBundle) : bool {
        generate_integrity_hash(&arg0.nft_key_table, arg0.version, arg0.nft_count) == arg0.integrity_hash && 0x2::table::length<0x2::object::ID, NftInfo>(&arg0.nft_key_table) == arg0.nft_count
    }

    public entry fun validate_bundle_integrity_public(arg0: &MultiBundleStore, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftBundle>(&arg0.id, arg1), 4);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftBundle>(&arg0.id, arg1);
        let v1 = BundleIntegrityValidated{
            bundle_id      : arg1,
            expected_count : v0.nft_count,
            actual_count   : 0x2::table::length<0x2::object::ID, NftInfo>(&v0.nft_key_table),
            valid          : validate_bundle_integrity(v0),
            version        : v0.version,
        };
        0x2::event::emit<BundleIntegrityValidated>(v1);
    }

    fun validate_nft_in_kiosk<T0: store + key>(arg0: &0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : bool {
        0x2::object::id<0x2::kiosk::Kiosk>(arg0) == arg2 && 0x2::kiosk::has_item(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

