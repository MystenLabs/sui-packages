module 0xd0b1eebda75bac531c58c1d94ef0f14d3386413ba95503b6961d85c6f9f1ed7d::kiosk_trade {
    struct KioskListEvent has copy, drop, store {
        nft_id: 0x2::object::ID,
        seller_kiosk: 0x2::object::ID,
        seller_kiosk_cap: 0x2::object::ID,
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

    public entry fun kiosk_buy_direct<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg7);
        let v0 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg1, arg5);
        assert!(arg5 + arg5 * 250 / 10000 + v0 == 0x2::coin::value<0x2::sui::SUI>(&arg6), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, @0x8084455a96bdde21edd8fe48ec3f15dbe1c82b2ee2e0e963d800f3d7d8fbbcd5);
        let (v1, v2) = 0x2::kiosk::purchase<T0>(arg0, arg4, 0x2::coin::split<0x2::sui::SUI>(&mut arg6, arg5, arg7));
        let v3 = v2;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg1, &mut v3, 0x2::coin::split<0x2::sui::SUI>(&mut arg6, v0, arg7));
        0x2::kiosk::lock<T0>(arg2, arg3, arg1, v1);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v3, arg2);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg1, v3);
    }

    public entry fun kiosk_delist<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::delist<T0>(arg0, arg1, arg2);
    }

    public entry fun kiosk_list<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::list<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

