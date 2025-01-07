module 0x47c8d4e4f92f877521a1b9dd553554dfec0f449277a9611aed4349c1c40a96ba::kiosk_transfers {
    struct Store has key {
        id: 0x2::object::UID,
        escrow_kiosk_cap: 0x2::kiosk::KioskOwnerCap,
    }

    struct Escrow has store, key {
        id: 0x2::object::UID,
        receiver: address,
    }

    struct RevertableEscrow has store, key {
        id: 0x2::object::UID,
        sender: address,
        receiver: address,
    }

    struct EscrowWithPurchaseCap<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        receiver: address,
        sender: address,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
    }

    struct TransferEvent has copy, drop {
        receiver: address,
        sender: address,
        nft_id: 0x2::object::ID,
    }

    struct TransferWithPurchaseCapEvent has copy, drop {
        receiver: address,
        sender: address,
        senser_kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
    }

    struct CancelEvent has copy, drop {
        nft_id: 0x2::object::ID,
    }

    struct CancelWithPurchaseCapEvent has copy, drop {
        receiver: address,
        sender: address,
        sender_kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
    }

    struct ClaimEvent has copy, drop {
        nft_id: 0x2::object::ID,
    }

    struct ClaimWithPurchaseCapEvent has copy, drop {
        receiver: address,
        receiver_kiosk_id: 0x2::object::ID,
        sender: address,
        sender_kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
    }

    public fun transfer<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: address, arg6: &0x2::transfer_policy::TransferPolicy<T0>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<T0>(arg2, 0x2::kiosk::list_with_purchase_cap<T0>(arg2, arg3, arg4, 0, arg7), 0x2::coin::zero<0x2::sui::SUI>(arg7));
        0x2::kiosk::lock<T0>(arg1, &arg0.escrow_kiosk_cap, arg6, v0);
        let v2 = 0x2::tx_context::sender(arg7);
        let v3 = RevertableEscrow{
            id       : 0x2::object::new(arg7),
            sender   : v2,
            receiver : arg5,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, RevertableEscrow>(&mut arg0.id, arg4, v3);
        let v4 = TransferEvent{
            receiver : arg5,
            sender   : v2,
            nft_id   : arg4,
        };
        0x2::event::emit<TransferEvent>(v4);
        v1
    }

    public fun admin_upgrade_escrow(arg0: &mut Store, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x51a1d3e9d4c9627739934b4a7be9e0dfe6c9c4bf4f7ec2e517f11f41c43d63bb, 0);
        let Escrow {
            id       : v0,
            receiver : v1,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Escrow>(&mut arg0.id, arg1);
        0x2::object::delete(v0);
        let v2 = RevertableEscrow{
            id       : 0x2::object::new(arg3),
            sender   : arg2,
            receiver : v1,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, RevertableEscrow>(&mut arg0.id, arg1, v2);
    }

    public fun cancel<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, RevertableEscrow>(&mut arg0.id, arg4);
        assert!(0x2::tx_context::sender(arg6) == v0.sender, 0);
        let RevertableEscrow {
            id       : v1,
            sender   : _,
            receiver : _,
        } = v0;
        0x2::object::delete(v1);
        let (v4, v5) = 0x2::kiosk::purchase_with_cap<T0>(arg1, 0x2::kiosk::list_with_purchase_cap<T0>(arg1, &arg0.escrow_kiosk_cap, arg4, 0, arg6), 0x2::coin::zero<0x2::sui::SUI>(arg6));
        0x2::kiosk::lock<T0>(arg2, arg3, arg5, v4);
        let v6 = CancelEvent{nft_id: arg4};
        0x2::event::emit<CancelEvent>(v6);
        v5
    }

    public fun cancel_with_purchase_cap<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, EscrowWithPurchaseCap<T0>>(&mut arg0.id, arg2);
        assert!(0x2::tx_context::sender(arg3) == v0.sender, 0);
        let EscrowWithPurchaseCap {
            id           : v1,
            receiver     : v2,
            sender       : v3,
            purchase_cap : v4,
        } = v0;
        0x2::object::delete(v1);
        0x2::kiosk::return_purchase_cap<T0>(arg1, v4);
        let v5 = CancelWithPurchaseCapEvent{
            receiver        : v2,
            sender          : v3,
            sender_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            nft_id          : arg2,
        };
        0x2::event::emit<CancelWithPurchaseCapEvent>(v5);
    }

    public fun claim<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Escrow>(&arg0.id, arg4)) {
            let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, Escrow>(&mut arg0.id, arg4);
            assert!(0x2::tx_context::sender(arg6) == v0.receiver, 0);
            let Escrow {
                id       : v1,
                receiver : _,
            } = v0;
            0x2::object::delete(v1);
        } else {
            let v3 = 0x2::dynamic_object_field::remove<0x2::object::ID, RevertableEscrow>(&mut arg0.id, arg4);
            assert!(0x2::tx_context::sender(arg6) == v3.receiver, 0);
            let RevertableEscrow {
                id       : v4,
                sender   : _,
                receiver : _,
            } = v3;
            0x2::object::delete(v4);
        };
        let (v7, v8) = 0x2::kiosk::purchase_with_cap<T0>(arg1, 0x2::kiosk::list_with_purchase_cap<T0>(arg1, &arg0.escrow_kiosk_cap, arg4, 0, arg6), 0x2::coin::zero<0x2::sui::SUI>(arg6));
        0x2::kiosk::lock<T0>(arg2, arg3, arg5, v7);
        let v9 = ClaimEvent{nft_id: arg4};
        0x2::event::emit<ClaimEvent>(v9);
        v8
    }

    public fun claim_with_purchase_cap<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, EscrowWithPurchaseCap<T0>>(&mut arg0.id, arg4);
        assert!(0x2::tx_context::sender(arg6) == v0.receiver, 0);
        let EscrowWithPurchaseCap {
            id           : v1,
            receiver     : v2,
            sender       : v3,
            purchase_cap : v4,
        } = v0;
        0x2::object::delete(v1);
        let (v5, v6) = 0x2::kiosk::purchase_with_cap<T0>(arg1, v4, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        0x2::kiosk::lock<T0>(arg2, arg3, arg5, v5);
        let v7 = ClaimWithPurchaseCapEvent{
            receiver          : v2,
            receiver_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            sender            : v3,
            sender_kiosk_id   : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            nft_id            : arg4,
        };
        0x2::event::emit<ClaimWithPurchaseCapEvent>(v7);
        v6
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        let v2 = Store{
            id               : 0x2::object::new(arg0),
            escrow_kiosk_cap : v1,
        };
        0x2::transfer::share_object<Store>(v2);
    }

    public fun transfer_with_purchase_capability<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = EscrowWithPurchaseCap<T0>{
            id           : 0x2::object::new(arg5),
            receiver     : arg4,
            sender       : v0,
            purchase_cap : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, 0, arg5),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, EscrowWithPurchaseCap<T0>>(&mut arg0.id, arg3, v1);
        let v2 = TransferWithPurchaseCapEvent{
            receiver        : arg4,
            sender          : v0,
            senser_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            nft_id          : arg3,
        };
        0x2::event::emit<TransferWithPurchaseCapEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

