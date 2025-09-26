module 0x39ac1494599d9dfc34930dd07f3c7e3571843b56a567a41a0efe3666b1e8700e::staking_escrow {
    struct STAKING_ESCROW has drop {
        dummy_field: bool,
    }

    struct StakingManager has store, key {
        id: 0x2::object::UID,
        admin: address,
        vault_cap: 0x2::kiosk::KioskOwnerCap,
        receipt_index: 0x2::table::Table<0x2::object::ID, StakedNftReceiptData>,
    }

    struct StakedNftReceiptData has drop, store {
        owner: address,
        original_nft_id: 0x2::object::ID,
        original_nft_type_bytes: vector<u8>,
        stake_timestamp_ms: u64,
    }

    struct StakedNftReceipt has store, key {
        id: 0x2::object::UID,
        original_nft_id: 0x2::object::ID,
        owner: address,
        stake_timestamp_ms: u64,
    }

    struct StakedEvent has copy, drop {
        owner: address,
        nft_id: 0x2::object::ID,
        nft_type_bytes: vector<u8>,
        timestamp_ms: u64,
    }

    struct UnstakedEvent has copy, drop {
        owner: address,
        nft_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    public fun admin_set_admin(arg0: &mut StakingManager, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 8005);
        arg0.admin = arg1;
    }

    fun init(arg0: STAKING_ESCROW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::kiosk::new(arg1);
        let v3 = StakingManager{
            id            : 0x2::object::new(arg1),
            admin         : v0,
            vault_cap     : v2,
            receipt_index : 0x2::table::new<0x2::object::ID, StakedNftReceiptData>(arg1),
        };
        0x2::transfer::public_share_object<StakingManager>(v3);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<STAKING_ESCROW>(arg0, arg1), v0);
    }

    public fun stake<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut StakingManager, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::object::ID, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0x2::kiosk::owner(arg0) == v0, 8004);
        let v1 = 0x2::kiosk::take<T0>(arg0, arg1, arg5);
        let v2 = 0x2::object::id<T0>(&v1);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, 0x2::transfer_policy::new_request<T0>(v2, 0x2::coin::value<0x2::sui::SUI>(&arg6), v2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, arg3.admin);
        0x2::kiosk::place<T0>(arg2, &arg3.vault_cap, v1);
        let v6 = StakedNftReceipt{
            id                 : 0x2::object::new(arg8),
            original_nft_id    : v2,
            owner              : v0,
            stake_timestamp_ms : 0x2::clock::timestamp_ms(arg7),
        };
        let v7 = 0x2::object::id<StakedNftReceipt>(&v6);
        let v8 = StakedNftReceiptData{
            owner                   : v0,
            original_nft_id         : v2,
            original_nft_type_bytes : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            stake_timestamp_ms      : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::table::add<0x2::object::ID, StakedNftReceiptData>(&mut arg3.receipt_index, v7, v8);
        0x2::transfer::public_transfer<StakedNftReceipt>(v6, v0);
        let v9 = StakedEvent{
            owner          : v0,
            nft_id         : v2,
            nft_type_bytes : 0x2::table::borrow<0x2::object::ID, StakedNftReceiptData>(&arg3.receipt_index, v7).original_nft_type_bytes,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<StakedEvent>(v9);
    }

    public fun unstake<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut StakingManager, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: StakedNftReceipt, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::object::id<StakedNftReceipt>(&arg5);
        let StakedNftReceipt {
            id                 : v2,
            original_nft_id    : v3,
            owner              : v4,
            stake_timestamp_ms : _,
        } = arg5;
        0x2::object::delete(v2);
        assert!(v0 == v4, 8002);
        assert!(0x2::table::contains<0x2::object::ID, StakedNftReceiptData>(&arg1.receipt_index, v1), 8006);
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())) == 0x2::table::borrow<0x2::object::ID, StakedNftReceiptData>(&arg1.receipt_index, v1).original_nft_type_bytes, 8003);
        0x2::table::remove<0x2::object::ID, StakedNftReceiptData>(&mut arg1.receipt_index, v1);
        let v6 = 0x2::kiosk::take<T0>(arg0, &arg1.vault_cap, v3);
        let v7 = 0x2::object::id<T0>(&v6);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, 0x2::transfer_policy::new_request<T0>(v7, 0x2::coin::value<0x2::sui::SUI>(&arg6), v7));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, arg1.admin);
        assert!(0x2::kiosk::owner(arg2) == v0, 8004);
        0x2::kiosk::place<T0>(arg2, arg3, v6);
        let v11 = UnstakedEvent{
            owner        : v0,
            nft_id       : v3,
            timestamp_ms : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<UnstakedEvent>(v11);
    }

    public fun unstake_by_receipt_id<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut StakingManager, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::object::ID, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0x2::table::contains<0x2::object::ID, StakedNftReceiptData>(&arg1.receipt_index, arg5), 8006);
        let v1 = 0x2::table::borrow<0x2::object::ID, StakedNftReceiptData>(&arg1.receipt_index, arg5);
        assert!(v0 == v1.owner, 8002);
        let v2 = v1.original_nft_id;
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())) == v1.original_nft_type_bytes, 8003);
        0x2::table::remove<0x2::object::ID, StakedNftReceiptData>(&mut arg1.receipt_index, arg5);
        let v3 = 0x2::kiosk::take<T0>(arg0, &arg1.vault_cap, v2);
        let v4 = 0x2::object::id<T0>(&v3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, 0x2::transfer_policy::new_request<T0>(v4, 0x2::coin::value<0x2::sui::SUI>(&arg6), v4));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, arg1.admin);
        assert!(0x2::kiosk::owner(arg2) == v0, 8004);
        0x2::kiosk::place<T0>(arg2, arg3, v3);
        let v8 = UnstakedEvent{
            owner        : v0,
            nft_id       : v2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<UnstakedEvent>(v8);
    }

    // decompiled from Move bytecode v6
}

