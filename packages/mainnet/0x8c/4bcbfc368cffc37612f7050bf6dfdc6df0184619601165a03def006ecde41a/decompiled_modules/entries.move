module 0xb23ee71e0f2d587fa5eea108f4f6c49c417f3c4b6a3fcfde8085e1c48558b34d::entries {
    public entry fun burn(arg0: 0xb23ee71e0f2d587fa5eea108f4f6c49c417f3c4b6a3fcfde8085e1c48558b34d::nft::BirdNFT, arg1: &0xa25e6ebb81c474af0afa86eb5077164fdbb15f600873b573f2a87a4dcda2eece::version::Version, arg2: &0x2::tx_context::TxContext) {
        0xb23ee71e0f2d587fa5eea108f4f6c49c417f3c4b6a3fcfde8085e1c48558b34d::nft::burn3(arg0, arg1, arg2);
    }

    public entry fun depositNft(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xb23ee71e0f2d587fa5eea108f4f6c49c417f3c4b6a3fcfde8085e1c48558b34d::nft::NftPegVault, arg3: &mut 0xa25e6ebb81c474af0afa86eb5077164fdbb15f600873b573f2a87a4dcda2eece::archieve::Archieve<0xb23ee71e0f2d587fa5eea108f4f6c49c417f3c4b6a3fcfde8085e1c48558b34d::nft::NFT>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0xa25e6ebb81c474af0afa86eb5077164fdbb15f600873b573f2a87a4dcda2eece::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xb23ee71e0f2d587fa5eea108f4f6c49c417f3c4b6a3fcfde8085e1c48558b34d::nft::depositNft3(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun setValidator(arg0: &0xb23ee71e0f2d587fa5eea108f4f6c49c417f3c4b6a3fcfde8085e1c48558b34d::nft::NftAdminCap, arg1: vector<u8>, arg2: &mut 0xb23ee71e0f2d587fa5eea108f4f6c49c417f3c4b6a3fcfde8085e1c48558b34d::nft::NftPegVault, arg3: &0xa25e6ebb81c474af0afa86eb5077164fdbb15f600873b573f2a87a4dcda2eece::version::Version) {
        0xb23ee71e0f2d587fa5eea108f4f6c49c417f3c4b6a3fcfde8085e1c48558b34d::nft::setValidator3(arg0, arg1, arg2, arg3);
    }

    public entry fun withdrawFee(arg0: &0xb23ee71e0f2d587fa5eea108f4f6c49c417f3c4b6a3fcfde8085e1c48558b34d::nft::NftAdminCap, arg1: &mut 0xb23ee71e0f2d587fa5eea108f4f6c49c417f3c4b6a3fcfde8085e1c48558b34d::nft::NftPegVault, arg2: &0xa25e6ebb81c474af0afa86eb5077164fdbb15f600873b573f2a87a4dcda2eece::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xb23ee71e0f2d587fa5eea108f4f6c49c417f3c4b6a3fcfde8085e1c48558b34d::nft::withdrawFee3(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdrawNft(arg0: &mut 0xa25e6ebb81c474af0afa86eb5077164fdbb15f600873b573f2a87a4dcda2eece::archieve::Archieve<0xb23ee71e0f2d587fa5eea108f4f6c49c417f3c4b6a3fcfde8085e1c48558b34d::nft::NFT>, arg1: 0xb23ee71e0f2d587fa5eea108f4f6c49c417f3c4b6a3fcfde8085e1c48558b34d::nft::BirdNFT, arg2: &0xa25e6ebb81c474af0afa86eb5077164fdbb15f600873b573f2a87a4dcda2eece::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xb23ee71e0f2d587fa5eea108f4f6c49c417f3c4b6a3fcfde8085e1c48558b34d::nft::withdrawNft3(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

