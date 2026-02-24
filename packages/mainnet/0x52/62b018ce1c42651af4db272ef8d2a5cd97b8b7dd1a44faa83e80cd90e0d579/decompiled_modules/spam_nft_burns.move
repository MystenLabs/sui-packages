module 0x5262b018ce1c42651af4db272ef8d2a5cd97b8b7dd1a44faa83e80cd90e0d579::spam_nft_burns {
    struct SpamNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct MinimalNFT has store, key {
        id: 0x2::object::UID,
    }

    struct DescriptiveNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    public fun batch_burn_descriptive_nfts(arg0: vector<DescriptiveNFT>) {
        while (!0x1::vector::is_empty<DescriptiveNFT>(&arg0)) {
            burn_descriptive_nft(0x1::vector::pop_back<DescriptiveNFT>(&mut arg0));
        };
        0x1::vector::destroy_empty<DescriptiveNFT>(arg0);
    }

    public fun batch_burn_minimal_nfts(arg0: vector<MinimalNFT>) {
        while (!0x1::vector::is_empty<MinimalNFT>(&arg0)) {
            burn_minimal_nft(0x1::vector::pop_back<MinimalNFT>(&mut arg0));
        };
        0x1::vector::destroy_empty<MinimalNFT>(arg0);
    }

    public fun batch_burn_spam_nfts(arg0: vector<SpamNFT>) {
        while (!0x1::vector::is_empty<SpamNFT>(&arg0)) {
            burn_spam_nft(0x1::vector::pop_back<SpamNFT>(&mut arg0));
        };
        0x1::vector::destroy_empty<SpamNFT>(arg0);
    }

    public fun burn_descriptive_nft(arg0: DescriptiveNFT) {
        let DescriptiveNFT {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun burn_minimal_nft(arg0: MinimalNFT) {
        let MinimalNFT { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun burn_spam_nft(arg0: SpamNFT) {
        let SpamNFT {
            id        : v0,
            name      : _,
            image_url : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

