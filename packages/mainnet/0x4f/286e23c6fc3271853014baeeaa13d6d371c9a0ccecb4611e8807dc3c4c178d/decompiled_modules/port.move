module 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::port {
    public fun sale_mint<T0: key, T1>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &mut 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::administrate::Launchpad<T0>, arg2: &mut 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::plan::SalePlan<T0, T1>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : vector<0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::NFT<T0>> {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::plan::get_plan_price<T0, T1>(arg2, arg3);
        if (v1 != 0) {
            let v2 = v1 * arg4;
            assert!(0x2::coin::value<T1>(&arg6) >= v2, 0);
            0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::financial::settlement<T1>(0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::plan::borrow_beneficiary_mut<T0, T1>(arg2), 0x2::coin::split<T1>(&mut arg6, v2, arg8), arg8);
        };
        0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::plan::check_with_plan<T0, T1>(arg2, arg3, arg4, arg7, arg8);
        if (0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::plan::does_whitelist<T0, T1>(arg2, arg3)) {
            0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::plan::check_whitelist<T0, T1>(v0, arg2, arg3, &arg5);
        };
        0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::plan::increase_sale_plan_counter<T0, T1>(arg2, arg3, arg4, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg6, v0);
        0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::administrate::sale_mint<T0>(arg0, arg1, arg4, arg8)
    }

    public fun sale_mint_entry<T0: key, T1>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &mut 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::administrate::Launchpad<T0>, arg2: &mut 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::plan::SalePlan<T0, T1>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = sale_mint<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::NFT<T0>>(&v0)) {
            0x2::transfer::public_transfer<0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::NFT<T0>>(0x1::vector::pop_back<0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::NFT<T0>>(&mut v0), 0x2::tx_context::sender(arg8));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::NFT<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

