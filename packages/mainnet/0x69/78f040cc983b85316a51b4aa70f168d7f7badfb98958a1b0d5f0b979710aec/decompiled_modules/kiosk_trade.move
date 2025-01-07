module 0x6978f040cc983b85316a51b4aa70f168d7f7badfb98958a1b0d5f0b979710aec::kiosk_trade {
    struct KioskListEvent has copy, drop, store {
        nft_id: 0x2::object::ID,
        seller_kiosk: 0x2::object::ID,
        transfer_policy: 0x2::object::ID,
        seller: address,
        price: u64,
        nft_type: 0x1::string::String,
    }

    struct KioskDelistEvent has copy, drop, store {
        nft_id: 0x2::object::ID,
        seller_kiosk: 0x2::object::ID,
        seller: address,
        nft_type: 0x1::string::String,
    }

    struct KiosKBuyEvent has copy, drop, store {
        nft_id: 0x2::object::ID,
        seller_kiosk: 0x2::object::ID,
        buyer_kiosk: 0x2::object::ID,
        transfer_policy: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
        nft_type: 0x1::string::String,
    }

    public entry fun kiosk_buy<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 == 0x2::coin::value<0x2::sui::SUI>(&arg6), 0);
        let v0 = arg5 * 250 / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg6, v0, arg7), @0x8084455a96bdde21edd8fe48ec3f15dbe1c82b2ee2e0e963d800f3d7d8fbbcd5);
        let (v1, v2) = 0x2::kiosk::purchase<T0>(arg0, arg4, arg6);
        let v3 = v2;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg1, &mut v3, 0x2::coin::split<0x2::sui::SUI>(&mut arg6, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg1, arg5 - v0), arg7));
        0x2::kiosk::lock<T0>(arg2, arg3, arg1, v1);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v3, arg2);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg1, v3);
        let v7 = KiosKBuyEvent{
            nft_id          : arg4,
            seller_kiosk    : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            buyer_kiosk     : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            transfer_policy : 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg1),
            seller          : 0x2::kiosk::owner(arg0),
            buyer           : 0x2::tx_context::sender(arg7),
            price           : arg5,
            nft_type        : 0x6978f040cc983b85316a51b4aa70f168d7f7badfb98958a1b0d5f0b979710aec::utils::get_token_name<T0>(),
        };
        0x2::event::emit<KiosKBuyEvent>(v7);
    }

    public entry fun kiosk_delist<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::delist<T0>(arg0, arg1, arg2);
        let v0 = KioskDelistEvent{
            nft_id       : arg2,
            seller_kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            seller       : 0x2::tx_context::sender(arg3),
            nft_type     : 0x6978f040cc983b85316a51b4aa70f168d7f7badfb98958a1b0d5f0b979710aec::utils::get_token_name<T0>(),
        };
        0x2::event::emit<KioskDelistEvent>(v0);
    }

    public entry fun kiosk_list<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::list<T0>(arg0, arg1, arg3, arg4 - arg4 * 250 / 10000);
        let v0 = KioskListEvent{
            nft_id          : arg3,
            seller_kiosk    : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            transfer_policy : 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg2),
            seller          : 0x2::tx_context::sender(arg5),
            price           : arg4,
            nft_type        : 0x6978f040cc983b85316a51b4aa70f168d7f7badfb98958a1b0d5f0b979710aec::utils::get_token_name<T0>(),
        };
        0x2::event::emit<KioskListEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

