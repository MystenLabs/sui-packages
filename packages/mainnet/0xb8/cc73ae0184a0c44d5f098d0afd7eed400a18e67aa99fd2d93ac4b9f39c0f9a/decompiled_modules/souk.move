module 0xb8cc73ae0184a0c44d5f098d0afd7eed400a18e67aa99fd2d93ac4b9f39c0f9a::souk {
    struct SoukCap has store, key {
        id: 0x2::object::UID,
        protocol_kiosk: 0x2::kiosk::Kiosk,
        protocol_kiosk_cap: 0x2::kiosk::KioskOwnerCap,
    }

    struct LoanTicket has store, key {
        id: 0x2::object::UID,
        original_owner: address,
        nft_id: 0x2::object::ID,
        min_price: u64,
        borrower_kiosk_id: 0x2::object::ID,
        borrower_kiosk_cap_id: 0x2::object::ID,
        transfer_policy_id: 0x2::object::ID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        let v2 = SoukCap{
            id                 : 0x2::object::new(arg0),
            protocol_kiosk     : v0,
            protocol_kiosk_cap : v1,
        };
        0x2::transfer::share_object<SoukCap>(v2);
    }

    public entry fun redeem_nft<T0: store + key>(arg0: LoanTicket, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: &mut SoukCap, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.original_owner, 0);
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<T0>(&mut arg2.protocol_kiosk, 0x2::kiosk::list_with_purchase_cap<T0>(&mut arg2.protocol_kiosk, &arg2.protocol_kiosk_cap, arg0.nft_id, arg0.min_price, arg6), arg5);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg1, v1);
        0x2::kiosk::lock<T0>(arg3, arg4, arg1, v0);
        0x2::transfer::public_transfer<LoanTicket>(arg0, @0x0);
    }

    public entry fun transfer_nft_to_protocol<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &mut SoukCap, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<T0>(arg0, 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, arg2, arg3, arg7), arg4);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg5, v1);
        0x2::kiosk::lock<T0>(&mut arg6.protocol_kiosk, &arg6.protocol_kiosk_cap, arg5, v0);
        let v5 = LoanTicket{
            id                    : 0x2::object::new(arg7),
            original_owner        : 0x2::tx_context::sender(arg7),
            nft_id                : arg2,
            min_price             : arg3,
            borrower_kiosk_id     : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            borrower_kiosk_cap_id : 0x2::object::id<0x2::kiosk::KioskOwnerCap>(arg1),
            transfer_policy_id    : 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg5),
        };
        0x2::transfer::transfer<LoanTicket>(v5, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

