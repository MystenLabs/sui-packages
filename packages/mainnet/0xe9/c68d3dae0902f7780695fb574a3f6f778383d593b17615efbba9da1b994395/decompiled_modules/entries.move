module 0x95464b857cf02fb4c8b8cbadcb6c251b74027c0aa46ade563e6dd513ae30de17::entries {
    public entry fun burn(arg0: 0x95464b857cf02fb4c8b8cbadcb6c251b74027c0aa46ade563e6dd513ae30de17::nft::BirdNFT, arg1: &0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::version::Version, arg2: &0x2::tx_context::TxContext) {
        0x95464b857cf02fb4c8b8cbadcb6c251b74027c0aa46ade563e6dd513ae30de17::nft::burn3(arg0, arg1, arg2);
    }

    public entry fun depositNft(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x95464b857cf02fb4c8b8cbadcb6c251b74027c0aa46ade563e6dd513ae30de17::nft::NftPegVault, arg3: &mut 0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::archieve::Archieve<0x95464b857cf02fb4c8b8cbadcb6c251b74027c0aa46ade563e6dd513ae30de17::nft::NFT>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x95464b857cf02fb4c8b8cbadcb6c251b74027c0aa46ade563e6dd513ae30de17::nft::depositNft3(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun setValidator(arg0: &0x95464b857cf02fb4c8b8cbadcb6c251b74027c0aa46ade563e6dd513ae30de17::nft::NftAdminCap, arg1: vector<u8>, arg2: &mut 0x95464b857cf02fb4c8b8cbadcb6c251b74027c0aa46ade563e6dd513ae30de17::nft::NftPegVault, arg3: &0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::version::Version) {
        0x95464b857cf02fb4c8b8cbadcb6c251b74027c0aa46ade563e6dd513ae30de17::nft::setValidator3(arg0, arg1, arg2, arg3);
    }

    public entry fun withdrawFee(arg0: &0x95464b857cf02fb4c8b8cbadcb6c251b74027c0aa46ade563e6dd513ae30de17::nft::NftAdminCap, arg1: &mut 0x95464b857cf02fb4c8b8cbadcb6c251b74027c0aa46ade563e6dd513ae30de17::nft::NftPegVault, arg2: &0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x95464b857cf02fb4c8b8cbadcb6c251b74027c0aa46ade563e6dd513ae30de17::nft::withdrawFee3(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdrawNft(arg0: &mut 0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::archieve::Archieve<0x95464b857cf02fb4c8b8cbadcb6c251b74027c0aa46ade563e6dd513ae30de17::nft::NFT>, arg1: 0x95464b857cf02fb4c8b8cbadcb6c251b74027c0aa46ade563e6dd513ae30de17::nft::BirdNFT, arg2: &0x9edc63266f79189c33c3d663a97b372c8188074a03b601487a763f9a9e6372b3::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x95464b857cf02fb4c8b8cbadcb6c251b74027c0aa46ade563e6dd513ae30de17::nft::withdrawNft3(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

