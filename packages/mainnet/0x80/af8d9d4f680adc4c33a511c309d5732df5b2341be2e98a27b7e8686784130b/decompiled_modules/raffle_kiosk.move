module 0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::raffle_kiosk {
    struct RaffleKiosk has key {
        id: 0x2::object::UID,
        kiosk_id: 0x2::object::ID,
        owner_cap_id: 0x2::object::ID,
        admin: address,
    }

    struct KioskNFTReceived has copy, drop {
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        nft_type: 0x1::string::String,
        from_kiosk_id: 0x2::object::ID,
        raffle_id: 0x2::object::ID,
    }

    struct KioskNFTTransferred has copy, drop {
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        nft_type: 0x1::string::String,
        to_kiosk_id: 0x2::object::ID,
        recipient: address,
    }

    public fun get_admin(arg0: &RaffleKiosk) : address {
        arg0.admin
    }

    public fun get_kiosk_id(arg0: &RaffleKiosk) : 0x2::object::ID {
        arg0.kiosk_id
    }

    public fun has_nft(arg0: &RaffleKiosk, arg1: &0x2::kiosk::Kiosk, arg2: 0x2::object::ID) : bool {
        0x2::kiosk::has_item(arg1, arg2)
    }

    public fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        let v2 = v1;
        let v3 = v0;
        let v4 = RaffleKiosk{
            id           : 0x2::object::new(arg0),
            kiosk_id     : 0x2::object::id<0x2::kiosk::Kiosk>(&v3),
            owner_cap_id : 0x2::object::id<0x2::kiosk::KioskOwnerCap>(&v2),
            admin        : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<RaffleKiosk>(v4);
    }

    public fun receive_nft_from_kiosk<T0: store + key>(arg0: &RaffleKiosk, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: &0x2::transfer_policy::TransferPolicy<T0>, arg7: 0x2::object::ID, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::object::id<0x2::kiosk::KioskOwnerCap>(arg2) == arg0.owner_cap_id, 1);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == arg0.kiosk_id, 1);
        let v0 = 0x2::kiosk::take<T0>(arg3, arg4, arg5);
        let v1 = 0x2::object::id<T0>(&v0);
        0x2::kiosk::lock<T0>(arg1, arg2, arg6, v0);
        let v2 = KioskNFTReceived{
            kiosk_id      : arg0.kiosk_id,
            nft_id        : v1,
            nft_type      : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            from_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg3),
            raffle_id     : arg7,
        };
        0x2::event::emit<KioskNFTReceived>(v2);
        v1
    }

    public fun transfer_nft_to_kiosk<T0: store + key>(arg0: &RaffleKiosk, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: &0x2::transfer_policy::TransferPolicy<T0>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x2::kiosk::KioskOwnerCap>(arg2) == arg0.owner_cap_id, 1);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == arg0.kiosk_id, 1);
        0x2::kiosk::place<T0>(arg3, arg4, 0x2::kiosk::take<T0>(arg1, arg2, arg5));
        let v0 = KioskNFTTransferred{
            kiosk_id    : arg0.kiosk_id,
            nft_id      : arg5,
            nft_type    : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            to_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg3),
            recipient   : arg7,
        };
        0x2::event::emit<KioskNFTTransferred>(v0);
    }

    // decompiled from Move bytecode v6
}

