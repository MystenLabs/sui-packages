module 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry {
    fun decrement_ticket_for_entry(arg0: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_bundle::CollectionBundle, arg1: &0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::CollectionMaintainer) {
        let v0 = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::ticket_units_for_entry(arg1);
        assert!(v0 > 0, 2);
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_bundle::decrement(arg0, v0);
    }

    public entry fun kiosk_and_mint_and_submit(arg0: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::CollectionMaintainer, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::assert_maintainer_version_and_paused(arg0);
        let (v0, v1) = 0x2::kiosk::new(arg8);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::tx_context::sender(arg8);
        let (v5, v6) = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft::pay_and_create(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v7 = 0x1::vector::empty<0x2::coin::Coin<0x2::sui::SUI>>();
        0x1::vector::push_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut v7, v6);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::submit_entry_and_pay(v5, v7, arg0, &mut v3, &v2, arg7, arg8), v4);
    }

    public entry fun kiosk_and_mint_and_submit_with_bundle(arg0: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::CollectionMaintainer, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_bundle::CollectionBundle, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg8);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft::pay_and_create_with_bundle(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0, arg7, arg8);
        decrement_ticket_for_entry(arg3, arg0);
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::submit_entry(v4, arg0, &mut v3, &v2, arg7, 0, arg8);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg8));
    }

    public entry fun kiosk_and_submit(arg0: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::CollectionMaintainer, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::assert_maintainer_version_and_paused(arg0);
        let (v0, v1) = 0x2::kiosk::new(arg4);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::tx_context::sender(arg4);
        assert!(v4 == 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::creator(&arg2), 0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::submit_entry_and_pay(arg2, arg1, arg0, &mut v3, &v2, arg3, arg4), v4);
    }

    public entry fun kiosk_and_submit_with_bundle(arg0: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::CollectionMaintainer, arg1: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_bundle::CollectionBundle, arg2: 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg4);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::tx_context::sender(arg4);
        assert!(v4 == 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::creator(&arg2), 0);
        decrement_ticket_for_entry(arg1, arg0);
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::submit_entry(arg2, arg0, &mut v3, &v2, arg3, 0, arg4);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, v4);
    }

    public entry fun mint_and_submit(arg0: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::CollectionMaintainer, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::assert_maintainer_version_and_paused(arg0);
        let (v0, v1) = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft::pay_and_create(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg9, arg10);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<0x2::sui::SUI>>();
        0x1::vector::push_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut v2, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::submit_entry_and_pay(v0, v2, arg0, arg7, arg8, arg9, arg10), 0x2::tx_context::sender(arg10));
    }

    public entry fun mint_and_submit_with_bundle(arg0: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::CollectionMaintainer, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_bundle::CollectionBundle, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft::pay_and_create_with_bundle(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0, arg9, arg10);
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_bundle::assert_valid_purchase(arg3, 4);
        decrement_ticket_for_entry(arg3, arg0);
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::submit_entry(v0, arg0, arg7, arg8, arg9, 0, arg10);
    }

    public entry fun remove_entry(arg0: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::CollectionMaintainer, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &mut 0x2::tx_context::TxContext) {
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::assert_maintainer_version_and_paused(arg0);
        assert!(0x2::kiosk::has_access(arg2, arg3), 1);
        0x2::transfer::public_transfer<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft>(0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::remove_entry(arg0, arg2, arg3, arg1, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun submit(arg0: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::CollectionMaintainer, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::assert_maintainer_version_and_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(v0 == 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::creator(&arg2), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::submit_entry_and_pay(arg2, arg1, arg0, arg3, arg4, arg5, arg6), v0);
    }

    public entry fun submit_with_bundle(arg0: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::CollectionMaintainer, arg1: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_bundle::CollectionBundle, arg2: 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::creator(&arg2), 0);
        decrement_ticket_for_entry(arg1, arg0);
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::submit_entry(arg2, arg0, arg3, arg4, arg5, 0, arg6);
    }

    // decompiled from Move bytecode v6
}

