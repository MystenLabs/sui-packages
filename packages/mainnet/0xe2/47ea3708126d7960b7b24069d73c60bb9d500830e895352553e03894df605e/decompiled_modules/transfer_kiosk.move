module 0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::transfer_kiosk {
    struct TransferStore has key {
        id: 0x2::object::UID,
        total_transfers: u64,
        total_nfts_transferred: u64,
        admin: address,
    }

    struct BatchTransferConfig has copy, drop, store {
        max_batch_size: u64,
        auto_create_kiosk: bool,
        emit_detailed_events: bool,
    }

    struct TransferReceipt has store, key {
        id: 0x2::object::UID,
        sender: address,
        recipient: address,
        sender_kiosk_id: 0x2::object::ID,
        recipient_kiosk_id: 0x2::object::ID,
        nft_ids: vector<0x2::object::ID>,
        timestamp: u64,
        batch_id: u64,
    }

    struct NFTTransferred has copy, drop {
        sender: address,
        recipient: address,
        sender_kiosk_id: 0x2::object::ID,
        recipient_kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        timestamp: u64,
        batch_id: u64,
    }

    struct BatchTransferCompleted has copy, drop {
        sender: address,
        recipient: address,
        sender_kiosk_id: 0x2::object::ID,
        recipient_kiosk_id: 0x2::object::ID,
        nft_count: u64,
        timestamp: u64,
        batch_id: u64,
    }

    struct RecipientKioskCreated has copy, drop {
        creator: address,
        recipient: address,
        kiosk_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct TransferStoreCreated has copy, drop {
        admin: address,
        timestamp: u64,
    }

    struct KioskCapNeedsForwarding has copy, drop {
        sender: address,
        recipient: address,
        kiosk_id: 0x2::object::ID,
        timestamp: u64,
    }

    public fun batch_transfer_to_existing_kiosk<T0: store + key>(arg0: &mut TransferStore, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: vector<0x2::object::ID>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg7: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg8: BatchTransferConfig, arg9: &mut 0x2::tx_context::TxContext) : TransferReceipt {
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::tx_context::epoch(arg9);
        let v2 = generate_batch_id(arg9);
        let v3 = 0x2::kiosk::owner(arg4);
        validate_kiosk_access(arg1, arg2);
        validate_kiosk_access(arg4, arg5);
        validate_batch_inputs(&arg3, &arg7, &arg8);
        validate_not_self_transfer(v0, v3);
        let v4 = 0;
        let v5 = 0x1::vector::length<0x2::object::ID>(&arg3);
        let v6 = 0x1::vector::empty<0x2::object::ID>();
        while (v4 < v5) {
            let v7 = *0x1::vector::borrow<0x2::object::ID>(&arg3, v4);
            assert!(0x2::kiosk::has_item(arg1, v7), 2);
            let (v8, v9) = 0x2::kiosk::purchase_with_cap<T0>(arg1, 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, v7, 0, arg9), 0x2::coin::zero<0x2::sui::SUI>(arg9));
            let v10 = v9;
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg6, &mut v10, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg7));
            0x2::kiosk::lock<T0>(arg4, arg5, arg6, v8);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v10, arg4);
            let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg6, v10);
            0x1::vector::push_back<0x2::object::ID>(&mut v6, v7);
            if (arg8.emit_detailed_events) {
                let v14 = NFTTransferred{
                    sender             : v0,
                    recipient          : v3,
                    sender_kiosk_id    : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
                    recipient_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg4),
                    nft_id             : v7,
                    timestamp          : v1,
                    batch_id           : v2,
                };
                0x2::event::emit<NFTTransferred>(v14);
            };
            v4 = v4 + 1;
        };
        while (!0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg7)) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg7));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg7);
        arg0.total_transfers = arg0.total_transfers + 1;
        arg0.total_nfts_transferred = arg0.total_nfts_transferred + v5;
        let v15 = TransferReceipt{
            id                 : 0x2::object::new(arg9),
            sender             : v0,
            recipient          : v3,
            sender_kiosk_id    : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            recipient_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg4),
            nft_ids            : v6,
            timestamp          : v1,
            batch_id           : v2,
        };
        let v16 = BatchTransferCompleted{
            sender             : v0,
            recipient          : v3,
            sender_kiosk_id    : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            recipient_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg4),
            nft_count          : v5,
            timestamp          : v1,
            batch_id           : v2,
        };
        0x2::event::emit<BatchTransferCompleted>(v16);
        v15
    }

    public entry fun batch_transfer_to_existing_kiosk_entry<T0: store + key>(arg0: &mut TransferStore, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: vector<0x2::object::ID>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg7: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = batch_transfer_to_existing_kiosk<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, default_batch_config(), arg8);
        0x2::transfer::public_transfer<TransferReceipt>(v0, 0x2::tx_context::sender(arg8));
    }

    public fun batch_transfer_with_new_kiosk<T0: store + key>(arg0: &mut TransferStore, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: vector<0x2::object::ID>, arg4: address, arg5: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg6: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg7: BatchTransferConfig, arg8: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, TransferReceipt) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::tx_context::epoch(arg8);
        let v2 = generate_batch_id(arg8);
        validate_kiosk_access(arg1, arg2);
        validate_batch_inputs(&arg3, &arg6, &arg7);
        validate_not_self_transfer(v0, arg4);
        let (v3, v4) = 0x2::kiosk::new(arg8);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x2::object::id<0x2::kiosk::Kiosk>(&v6);
        let v8 = RecipientKioskCreated{
            creator   : v0,
            recipient : arg4,
            kiosk_id  : v7,
            timestamp : v1,
        };
        0x2::event::emit<RecipientKioskCreated>(v8);
        let v9 = 0;
        let v10 = 0x1::vector::length<0x2::object::ID>(&arg3);
        let v11 = 0x1::vector::empty<0x2::object::ID>();
        while (v9 < v10) {
            let v12 = *0x1::vector::borrow<0x2::object::ID>(&arg3, v9);
            assert!(0x2::kiosk::has_item(arg1, v12), 2);
            let (v13, v14) = 0x2::kiosk::purchase_with_cap<T0>(arg1, 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, v12, 0, arg8), 0x2::coin::zero<0x2::sui::SUI>(arg8));
            let v15 = v14;
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg5, &mut v15, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg6));
            0x2::kiosk::lock<T0>(&mut v6, &v5, arg5, v13);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v15, &v6);
            let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg5, v15);
            0x1::vector::push_back<0x2::object::ID>(&mut v11, v12);
            if (arg7.emit_detailed_events) {
                let v19 = NFTTransferred{
                    sender             : v0,
                    recipient          : arg4,
                    sender_kiosk_id    : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
                    recipient_kiosk_id : v7,
                    nft_id             : v12,
                    timestamp          : v1,
                    batch_id           : v2,
                };
                0x2::event::emit<NFTTransferred>(v19);
            };
            v9 = v9 + 1;
        };
        while (!0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg6)) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg6));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg6);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v6);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v6, v5, arg8), arg8);
        let v20 = KioskCapNeedsForwarding{
            sender    : v0,
            recipient : arg4,
            kiosk_id  : v7,
            timestamp : v1,
        };
        0x2::event::emit<KioskCapNeedsForwarding>(v20);
        arg0.total_transfers = arg0.total_transfers + 1;
        arg0.total_nfts_transferred = arg0.total_nfts_transferred + v10;
        let v21 = TransferReceipt{
            id                 : 0x2::object::new(arg8),
            sender             : v0,
            recipient          : arg4,
            sender_kiosk_id    : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            recipient_kiosk_id : v7,
            nft_ids            : v11,
            timestamp          : v1,
            batch_id           : v2,
        };
        let v22 = BatchTransferCompleted{
            sender             : v0,
            recipient          : arg4,
            sender_kiosk_id    : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            recipient_kiosk_id : v7,
            nft_count          : v10,
            timestamp          : v1,
            batch_id           : v2,
        };
        0x2::event::emit<BatchTransferCompleted>(v22);
        (v7, v21)
    }

    public entry fun batch_transfer_with_new_kiosk_entry<T0: store + key>(arg0: &mut TransferStore, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: vector<0x2::object::ID>, arg4: address, arg5: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg6: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg7: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = batch_transfer_with_new_kiosk<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, default_batch_config(), arg7);
        0x2::transfer::public_transfer<TransferReceipt>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun create_and_share_transfer_store(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<TransferStore>(create_transfer_store(arg0, arg1));
    }

    public fun create_transfer_store(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : TransferStore {
        let v0 = TransferStore{
            id                     : 0x2::object::new(arg1),
            total_transfers        : 0,
            total_nfts_transferred : 0,
            admin                  : arg0,
        };
        let v1 = TransferStoreCreated{
            admin     : arg0,
            timestamp : 0x2::tx_context::epoch(arg1),
        };
        0x2::event::emit<TransferStoreCreated>(v1);
        v0
    }

    public fun default_batch_config() : BatchTransferConfig {
        BatchTransferConfig{
            max_batch_size       : 50,
            auto_create_kiosk    : true,
            emit_detailed_events : true,
        }
    }

    fun generate_batch_id(arg0: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::epoch(arg0);
        let v1 = 0x2::tx_context::sender(arg0);
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<address>(&v1));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&v0));
        let v3 = 0x2::hash::keccak256(&v2);
        let v4 = 0;
        let v5 = 0;
        while (v5 < 8 && v5 < 0x1::vector::length<u8>(&v3)) {
            let v6 = v4 * 256;
            v4 = v6 + (*0x1::vector::borrow<u8>(&v3, v5) as u64);
            v5 = v5 + 1;
        };
        v4
    }

    public fun get_receipt_details(arg0: &TransferReceipt) : (address, address, u64, u64, u64) {
        (arg0.sender, arg0.recipient, 0x1::vector::length<0x2::object::ID>(&arg0.nft_ids), arg0.timestamp, arg0.batch_id)
    }

    public fun get_receipt_nft_ids(arg0: &TransferReceipt) : vector<0x2::object::ID> {
        arg0.nft_ids
    }

    public fun get_store_admin(arg0: &TransferStore) : address {
        arg0.admin
    }

    public fun get_store_stats(arg0: &TransferStore) : (u64, u64) {
        (arg0.total_transfers, arg0.total_nfts_transferred)
    }

    public fun is_valid_batch_size(arg0: u64, arg1: &BatchTransferConfig) : bool {
        arg0 >= 1 && arg0 <= arg1.max_batch_size
    }

    public fun single_transfer_with_new_kiosk<T0: store + key>(arg0: &mut TransferStore, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: address, arg5: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, TransferReceipt) {
        batch_transfer_with_new_kiosk<T0>(arg0, arg1, arg2, 0x1::vector::singleton<0x2::object::ID>(arg3), arg4, arg5, 0x1::vector::singleton<0x2::coin::Coin<0x2::sui::SUI>>(arg6), default_batch_config(), arg7)
    }

    public entry fun single_transfer_with_new_kiosk_entry<T0: store + key>(arg0: &mut TransferStore, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: address, arg5: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = single_transfer_with_new_kiosk<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<TransferReceipt>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun transfer_admin(arg0: &mut TransferStore, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.admin = arg1;
    }

    fun validate_batch_inputs(arg0: &vector<0x2::object::ID>, arg1: &vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: &BatchTransferConfig) {
        let v0 = 0x1::vector::length<0x2::object::ID>(arg0);
        assert!(v0 >= 1, 6);
        assert!(v0 <= arg2.max_batch_size, 5);
        assert!(v0 == 0x1::vector::length<0x2::coin::Coin<0x2::sui::SUI>>(arg1), 4);
    }

    fun validate_kiosk_access(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap) {
        assert!(0x2::kiosk::has_access(arg0, arg1), 3);
    }

    fun validate_not_self_transfer(arg0: address, arg1: address) {
        assert!(arg0 != arg1, 7);
    }

    // decompiled from Move bytecode v6
}

