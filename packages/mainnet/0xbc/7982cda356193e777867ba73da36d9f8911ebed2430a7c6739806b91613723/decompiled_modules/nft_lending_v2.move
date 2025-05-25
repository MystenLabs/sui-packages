module 0xbc7982cda356193e777867ba73da36d9f8911ebed2430a7c6739806b91613723::nft_lending_v2 {
    struct LendingProtocolStore has key {
        id: 0x2::object::UID,
        protocol_kiosk_id: 0x2::object::ID,
        protocol_kiosk_cap: 0x2::kiosk::KioskOwnerCap,
        protocol_treasury: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct NftPurchasePermission<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        original_owner: address,
        borrower_kiosk_id: 0x2::object::ID,
        listed_price: u64,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
    }

    struct NftAsCollateral has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        original_owner: address,
        amount_paid_by_protocol: u64,
    }

    struct PurchaseCapPermissionGranted has copy, drop {
        protocol_store_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        original_owner: address,
        borrower_kiosk_id: 0x2::object::ID,
        listed_price: u64,
    }

    struct NftClaimedWithPurchaseCap has copy, drop {
        protocol_store_id: 0x2::object::ID,
        protocol_kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        original_owner: address,
        borrower_kiosk_id: 0x2::object::ID,
        amount_paid_by_protocol: u64,
    }

    struct ProtocolCostsReimbursed has copy, drop {
        protocol_store_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        original_owner: address,
        amount_reimbursed: u64,
    }

    public entry fun borrower_grant_purchase_cap_permission<T0: store + key>(arg0: &mut LendingProtocolStore, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::kiosk::Kiosk, arg4: 0x2::object::ID, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg4), 3);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v2 = NftPurchasePermission<T0>{
            id                : 0x2::object::new(arg7),
            nft_id            : arg4,
            original_owner    : v0,
            borrower_kiosk_id : v1,
            listed_price      : 0,
            purchase_cap      : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg4, 0, arg7),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, NftPurchasePermission<T0>>(&mut arg0.id, arg4, v2);
        let v3 = PurchaseCapPermissionGranted{
            protocol_store_id : 0x2::object::uid_to_inner(&arg0.id),
            nft_id            : arg4,
            original_owner    : v0,
            borrower_kiosk_id : v1,
            listed_price      : 0,
        };
        0x2::event::emit<PurchaseCapPermissionGranted>(v3);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg3) == arg0.protocol_kiosk_id, 5);
        let NftPurchasePermission {
            id                : v4,
            nft_id            : _,
            original_owner    : v6,
            borrower_kiosk_id : v7,
            listed_price      : v8,
            purchase_cap      : v9,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftPurchasePermission<T0>>(&mut arg0.id, arg4);
        assert!(v6 == v0, 1);
        assert!(v7 == v1, 5);
        assert!(arg6 >= v8, 2);
        let (v10, v11) = 0x2::kiosk::purchase_with_cap<T0>(arg1, v9, 0x2::coin::take<0x2::sui::SUI>(&mut arg0.protocol_treasury, arg6, arg7));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg5, v11);
        0x2::kiosk::lock<T0>(arg3, &arg0.protocol_kiosk_cap, arg5, v10);
        let v15 = NftAsCollateral{
            id                      : 0x2::object::new(arg7),
            nft_id                  : arg4,
            original_owner          : v6,
            amount_paid_by_protocol : arg6,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, NftAsCollateral>(&mut arg0.id, arg4, v15);
        0x2::object::delete(v4);
        let v16 = NftClaimedWithPurchaseCap{
            protocol_store_id       : 0x2::object::uid_to_inner(&arg0.id),
            protocol_kiosk_id       : arg0.protocol_kiosk_id,
            nft_id                  : arg4,
            original_owner          : v6,
            borrower_kiosk_id       : v7,
            amount_paid_by_protocol : arg6,
        };
        0x2::event::emit<NftClaimedWithPurchaseCap>(v16);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        let v2 = v0;
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
        let v3 = LendingProtocolStore{
            id                 : 0x2::object::new(arg0),
            protocol_kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(&v2),
            protocol_kiosk_cap : v1,
            protocol_treasury  : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<LendingProtocolStore>(v3);
    }

    public entry fun reimburse_protocol_for_collateral_payment(arg0: &mut LendingProtocolStore, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftAsCollateral>(&arg0.id, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.original_owner, 1);
        let v1 = v0.amount_paid_by_protocol;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == v1, 2);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.protocol_treasury, arg2);
        let v2 = ProtocolCostsReimbursed{
            protocol_store_id : 0x2::object::uid_to_inner(&arg0.id),
            nft_id            : arg1,
            original_owner    : v0.original_owner,
            amount_reimbursed : v1,
        };
        0x2::event::emit<ProtocolCostsReimbursed>(v2);
    }

    // decompiled from Move bytecode v6
}

