module 0x2c2a1a5512c2267d4ea5ec6f4b452e457849e7f16b9573e34c523bf9a8f84c6::seed_shared_structs {
    struct NFT has store {
        id: u64,
        nftContract: address,
        tokenId: u64,
        owner: address,
        referal: address,
        royaltyAddress: address,
        price: u64,
        targetPrice: u64,
        auctionExpireDatetime: u64,
        transferCount: u64,
        creators: vector<Creator>,
        bids: vector<Bid>,
        lock: bool,
    }

    struct Creator has store {
        address: address,
        share: u64,
    }

    struct Bid has store {
        bidder: address,
        price: u64,
    }

    // decompiled from Move bytecode v6
}

