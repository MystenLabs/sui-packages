module 0x6fa1f426661d03ceb11ecd6664322acb2f06d98bbeef03ec0419faeb8ea4ae1a::launch {
    public entry fun post_sale_mint_by_creator<T0: key>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::administrate::AdminCap<T0>, arg2: &mut 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::administrate::Launchpad<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::administrate::post_sale_mint_by_creator<T0>(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::NFT<T0>>(&v0)) {
            0x2::transfer::public_transfer<0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::NFT<T0>>(0x1::vector::pop_back<0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::NFT<T0>>(&mut v0), 0x2::tx_context::sender(arg4));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::NFT<T0>>(v0);
    }

    public entry fun post_sale_mint<T0: key>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::permission::Permission, arg2: &mut 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::administrate::Launchpad<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::administrate::post_sale_mint_by_admin<T0>(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::NFT<T0>>(&v0)) {
            0x2::transfer::public_transfer<0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::NFT<T0>>(0x1::vector::pop_back<0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::NFT<T0>>(&mut v0), 0x2::tx_context::sender(arg4));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::NFT<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

