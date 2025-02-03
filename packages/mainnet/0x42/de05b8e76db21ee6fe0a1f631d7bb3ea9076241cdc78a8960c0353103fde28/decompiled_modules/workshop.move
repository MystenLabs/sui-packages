module 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::workshop {
    public(friend) fun mint_token_with_mint_cap<T0: key>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: u64, arg2: &0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::warehouse::NFTContent, arg3: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::NFT<T0> {
        let (_, v1) = 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::warehouse::get_nft_attributes_keys(arg2);
        let (_, v3) = 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::warehouse::get_nft_attributes_values(arg2);
        0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::mint_nft_with_cap<T0>(arg0, arg1, 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::warehouse::get_nft_name(arg2), 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::warehouse::get_nft_url(arg2), arg3, v1, v3, arg4)
    }

    // decompiled from Move bytecode v6
}

