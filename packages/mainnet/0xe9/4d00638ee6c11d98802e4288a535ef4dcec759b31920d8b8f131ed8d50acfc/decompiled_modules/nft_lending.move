module 0xe94d00638ee6c11d98802e4288a535ef4dcec759b31920d8b8f131ed8d50acfc::nft_lending {
    struct LendingProtocolStore has key {
        id: 0x2::object::UID,
        protocol_kiosk_id: 0x2::object::ID,
        protocol_kiosk_cap: 0x2::kiosk::KioskOwnerCap,
    }

    struct NftDepositPermission<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        original_owner: address,
        borrower_kiosk_id: 0x2::object::ID,
        listed_price: u64,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
    }

    struct ClaimedNftInfo has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        original_owner: address,
        royalty_paid_by_protocol: u64,
        price_paid_to_borrower: u64,
    }

    struct NftDepositPermissioned has copy, drop {
        protocol_store_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        original_owner: address,
        borrower_kiosk_id: 0x2::object::ID,
        listed_price: u64,
    }

    struct NftClaimedByProtocol has copy, drop {
        protocol_store_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        original_owner: address,
        protocol_kiosk_id: 0x2::object::ID,
        royalty_paid: u64,
        price_paid_to_borrower: u64,
    }

    struct ProtocolCostsReimbursed has copy, drop {
        protocol_store_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        original_owner: address,
        amount_reimbursed: u64,
    }

    struct DepositCancelled has copy, drop {
        dummy_field: bool,
    }

    public entry fun borrower_deposit_nft_permission<T0: store + key>(arg0: &mut LendingProtocolStore, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = NftDepositPermission<T0>{
            id                : 0x2::object::new(arg5),
            nft_id            : arg3,
            original_owner    : v0,
            borrower_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            listed_price      : arg4,
            purchase_cap      : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, arg4, arg5),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, NftDepositPermission<T0>>(&mut arg0.id, arg3, v1);
        let v2 = NftDepositPermissioned{
            protocol_store_id : 0x2::object::uid_to_inner(&arg0.id),
            nft_id            : arg3,
            original_owner    : v0,
            borrower_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            listed_price      : arg4,
        };
        0x2::event::emit<NftDepositPermissioned>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        let v2 = v0;
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
        let v3 = LendingProtocolStore{
            id                 : 0x2::object::new(arg0),
            protocol_kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(&v2),
            protocol_kiosk_cap : v1,
        };
        0x2::transfer::share_object<LendingProtocolStore>(v3);
    }

    public entry fun protocol_claim_nft<T0: store + key>(arg0: &mut LendingProtocolStore, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        let NftDepositPermission {
            id                : v0,
            nft_id            : _,
            original_owner    : v2,
            borrower_kiosk_id : v3,
            listed_price      : v4,
            purchase_cap      : v5,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftDepositPermission<T0>>(&mut arg0.id, arg3);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v3, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) == v4, 4);
        let (v6, v7) = 0x2::kiosk::purchase_with_cap<T0>(arg2, v5, arg6);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v7);
        let v11 = 0x2::coin::value<0x2::sui::SUI>(arg5) - 0x2::coin::value<0x2::sui::SUI>(arg5);
        0x2::kiosk::lock<T0>(arg1, &arg0.protocol_kiosk_cap, arg4, v6);
        let v12 = ClaimedNftInfo{
            id                       : 0x2::object::new(arg7),
            nft_id                   : arg3,
            original_owner           : v2,
            royalty_paid_by_protocol : v11,
            price_paid_to_borrower   : v4,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, ClaimedNftInfo>(&mut arg0.id, arg3, v12);
        0x2::object::delete(v0);
        let v13 = NftClaimedByProtocol{
            protocol_store_id      : 0x2::object::uid_to_inner(&arg0.id),
            nft_id                 : arg3,
            original_owner         : v2,
            protocol_kiosk_id      : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            royalty_paid           : v11,
            price_paid_to_borrower : v4,
        };
        0x2::event::emit<NftClaimedByProtocol>(v13);
    }

    public entry fun reimburse_protocol_costs(arg0: &mut LendingProtocolStore, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let ClaimedNftInfo {
            id                       : v1,
            nft_id                   : _,
            original_owner           : v3,
            royalty_paid_by_protocol : v4,
            price_paid_to_borrower   : v5,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, ClaimedNftInfo>(&mut arg0.id, arg1);
        assert!(v0 == v3, 1);
        let v6 = v4 + v5;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == v6, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v0);
        0x2::object::delete(v1);
        let v7 = ProtocolCostsReimbursed{
            protocol_store_id : 0x2::object::uid_to_inner(&arg0.id),
            nft_id            : arg1,
            original_owner    : v3,
            amount_reimbursed : v6,
        };
        0x2::event::emit<ProtocolCostsReimbursed>(v7);
    }

    // decompiled from Move bytecode v6
}

