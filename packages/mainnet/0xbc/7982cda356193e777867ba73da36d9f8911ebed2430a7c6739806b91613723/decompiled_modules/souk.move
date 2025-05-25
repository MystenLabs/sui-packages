module 0xbc7982cda356193e777867ba73da36d9f8911ebed2430a7c6739806b91613723::souk {
    struct Phantom<T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct SoukCap has store, key {
        id: 0x2::object::UID,
        protocol_kiosk: 0x2::kiosk::Kiosk,
        protocol_kiosk_cap: 0x2::kiosk::KioskOwnerCap,
    }

    struct LoanTicket<T0> has store, key {
        id: 0x2::object::UID,
        nft_type: Phantom<T0>,
        original_owner: address,
        nft_id: 0x2::object::ID,
        min_price: u64,
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

    public entry fun redeem_nft<T0: store + key>(arg0: LoanTicket<T0>, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: &mut SoukCap, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.original_owner, 0);
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<T0>(&mut arg2.protocol_kiosk, 0x2::kiosk::list_with_purchase_cap<T0>(&mut arg2.protocol_kiosk, &arg2.protocol_kiosk_cap, arg0.nft_id, arg0.min_price, arg6), arg5);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg1, v1);
        0x2::kiosk::lock<T0>(arg3, arg4, arg1, v0);
        0x2::transfer::public_transfer<LoanTicket<T0>>(arg0, @0x0);
    }

    public entry fun transfer_nft_to_protocol<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &mut SoukCap, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<T0>(arg0, 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, arg2, arg3, arg7), arg4);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg5, v1);
        0x2::kiosk::lock<T0>(&mut arg6.protocol_kiosk, &arg6.protocol_kiosk_cap, arg5, v0);
        let v5 = Phantom<T0>{dummy_field: false};
        let v6 = LoanTicket<T0>{
            id             : 0x2::object::new(arg7),
            nft_type       : v5,
            original_owner : 0x2::tx_context::sender(arg7),
            nft_id         : arg2,
            min_price      : arg3,
        };
        0x2::transfer::transfer<LoanTicket<T0>>(v6, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

