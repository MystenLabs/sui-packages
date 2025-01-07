module 0xed148df1679eb81a0ae2ace6a0aba73d5c72c96922e7a77e966cb25709d2cfce::entries {
    public entry fun burn(arg0: 0xed148df1679eb81a0ae2ace6a0aba73d5c72c96922e7a77e966cb25709d2cfce::nft::BirdNFT, arg1: &0x5e56f71d58afe90d014bad9bc79191175fa4da255bad46c0d06bcab57872bc2a::version::Version, arg2: &0x2::tx_context::TxContext) {
        0xed148df1679eb81a0ae2ace6a0aba73d5c72c96922e7a77e966cb25709d2cfce::nft::burn3(arg0, arg1, arg2);
    }

    public entry fun depositNft(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xed148df1679eb81a0ae2ace6a0aba73d5c72c96922e7a77e966cb25709d2cfce::nft::NftPegVault, arg3: &mut 0x5e56f71d58afe90d014bad9bc79191175fa4da255bad46c0d06bcab57872bc2a::archieve::Archieve<0xed148df1679eb81a0ae2ace6a0aba73d5c72c96922e7a77e966cb25709d2cfce::nft::NFT>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x5e56f71d58afe90d014bad9bc79191175fa4da255bad46c0d06bcab57872bc2a::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xed148df1679eb81a0ae2ace6a0aba73d5c72c96922e7a77e966cb25709d2cfce::nft::depositNft3(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun setValidator(arg0: &0xed148df1679eb81a0ae2ace6a0aba73d5c72c96922e7a77e966cb25709d2cfce::nft::NftAdminCap, arg1: vector<u8>, arg2: &mut 0xed148df1679eb81a0ae2ace6a0aba73d5c72c96922e7a77e966cb25709d2cfce::nft::NftPegVault, arg3: &0x5e56f71d58afe90d014bad9bc79191175fa4da255bad46c0d06bcab57872bc2a::version::Version) {
        0xed148df1679eb81a0ae2ace6a0aba73d5c72c96922e7a77e966cb25709d2cfce::nft::setValidator3(arg0, arg1, arg2, arg3);
    }

    public entry fun withdrawFee(arg0: &0xed148df1679eb81a0ae2ace6a0aba73d5c72c96922e7a77e966cb25709d2cfce::nft::NftAdminCap, arg1: &mut 0xed148df1679eb81a0ae2ace6a0aba73d5c72c96922e7a77e966cb25709d2cfce::nft::NftPegVault, arg2: &0x5e56f71d58afe90d014bad9bc79191175fa4da255bad46c0d06bcab57872bc2a::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xed148df1679eb81a0ae2ace6a0aba73d5c72c96922e7a77e966cb25709d2cfce::nft::withdrawFee3(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdrawNft(arg0: &mut 0x5e56f71d58afe90d014bad9bc79191175fa4da255bad46c0d06bcab57872bc2a::archieve::Archieve<0xed148df1679eb81a0ae2ace6a0aba73d5c72c96922e7a77e966cb25709d2cfce::nft::NFT>, arg1: 0xed148df1679eb81a0ae2ace6a0aba73d5c72c96922e7a77e966cb25709d2cfce::nft::BirdNFT, arg2: &0x5e56f71d58afe90d014bad9bc79191175fa4da255bad46c0d06bcab57872bc2a::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xed148df1679eb81a0ae2ace6a0aba73d5c72c96922e7a77e966cb25709d2cfce::nft::withdrawNft3(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

