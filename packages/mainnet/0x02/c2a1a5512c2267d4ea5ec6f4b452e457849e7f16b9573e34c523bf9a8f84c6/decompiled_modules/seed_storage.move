module 0x2c2a1a5512c2267d4ea5ec6f4b452e457849e7f16b9573e34c523bf9a8f84c6::seed_storage {
    struct MarketNFTs has store, key {
        id: 0x2::object::UID,
        market_nfts: 0x2c2a1a5512c2267d4ea5ec6f4b452e457849e7f16b9573e34c523bf9a8f84c6::seed_shared_structs::NFT,
    }

    public fun getMarketNFT(arg0: u64) {
        let v0 = arg0 + 1;
        0x1::debug::print<u64>(&v0);
    }

    // decompiled from Move bytecode v6
}

