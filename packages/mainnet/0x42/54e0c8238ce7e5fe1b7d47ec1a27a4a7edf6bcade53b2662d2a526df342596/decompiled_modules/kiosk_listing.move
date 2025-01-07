module 0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::kiosk_listing {
    struct ListingEvent has copy, drop {
        nft_id: 0x2::object::ID,
        price: u64,
        seller: address,
        kiosk_id: 0x2::object::ID,
    }

    struct SaleEvent has copy, drop {
        nft_id: 0x2::object::ID,
        price: u64,
        seller: address,
        buyer: address,
        kiosk_id: 0x2::object::ID,
    }

    public entry fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun get_listing_details(arg0: &0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::listing_registry::ListingRegistry, arg1: 0x2::object::ID) : (0x2::object::ID, u64, address) {
        0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::listing_registry::get_listing_info(arg0, arg1)
    }

    public fun get_platform_fee<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: u64) : u64 {
        0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::transfer_policy_rules::calculate_platform_fee<T0>(arg0, arg1)
    }

    public entry fun list_nft(arg0: &mut 0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::listing_registry::ListingRegistry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::simple_nft::NFT, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"DEBUG: list_nft start");
        0x1::debug::print<0x1::string::String>(&v0);
        assert!(0x2::kiosk::has_access(arg1, arg2), 4);
        assert!(arg4 >= 1000000, 1);
        let v1 = 0x2::object::id<0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::simple_nft::NFT>(&arg3);
        let v2 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v3 = 0x2::tx_context::sender(arg5);
        0x1::debug::print<0x2::object::ID>(&v1);
        0x1::debug::print<0x2::object::ID>(&v2);
        0x1::debug::print<address>(&v3);
        0x2::kiosk::place<0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::simple_nft::NFT>(arg1, arg2, arg3);
        0x2::kiosk::list<0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::simple_nft::NFT>(arg1, arg2, v1, arg4);
        0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::listing_registry::register_or_update_listing(arg0, v1, v2, arg4, v3);
        let v4 = ListingEvent{
            nft_id   : v1,
            price    : arg4,
            seller   : v3,
            kiosk_id : v2,
        };
        0x2::event::emit<ListingEvent>(v4);
    }

    fun process_purchase_internal(arg0: &mut 0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::listing_registry::ListingRegistry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::transfer_policy::TransferPolicy<0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::simple_nft::NFT>, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : 0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::simple_nft::NFT {
        let (v0, v1, v2) = 0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::listing_registry::get_listing_info(arg0, arg3);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == v0, 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v1, 3);
        let (v3, v4) = 0x2::kiosk::purchase<0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::simple_nft::NFT>(arg1, arg3, 0x2::coin::split<0x2::sui::SUI>(&mut arg4, v1, arg5));
        let v5 = v4;
        0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::transfer_policy_rules::pay_royalty<0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::simple_nft::NFT>(arg2, &mut v5, &mut arg4, arg5);
        0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::transfer_policy_rules::pay_platform_fee<0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::simple_nft::NFT>(arg2, &mut v5, &mut arg4, arg5);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::simple_nft::NFT>(arg2, v5);
        if (0x2::coin::value<0x2::sui::SUI>(&arg4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg4);
        };
        0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::listing_registry::remove_listing(arg0, arg3);
        let v9 = SaleEvent{
            nft_id   : arg3,
            price    : v1,
            seller   : v2,
            buyer    : 0x2::tx_context::sender(arg5),
            kiosk_id : v0,
        };
        0x2::event::emit<SaleEvent>(v9);
        v3
    }

    public entry fun purchase_and_receive_nft(arg0: &mut 0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::listing_registry::ListingRegistry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::transfer_policy::TransferPolicy<0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::simple_nft::NFT>, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = purchase_nft(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::simple_nft::NFT>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun purchase_nft(arg0: &mut 0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::listing_registry::ListingRegistry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::transfer_policy::TransferPolicy<0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::simple_nft::NFT>, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : 0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::simple_nft::NFT {
        process_purchase_internal(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public entry fun purchase_nft_to_kiosk(arg0: &mut 0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::listing_registry::ListingRegistry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &mut 0x2::transfer_policy::TransferPolicy<0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::simple_nft::NFT>, arg5: 0x2::object::ID, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg2, arg3), 4);
        0x2::kiosk::place<0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::simple_nft::NFT>(arg2, arg3, process_purchase_internal(arg0, arg1, arg4, arg5, arg6, arg7));
    }

    // decompiled from Move bytecode v6
}

