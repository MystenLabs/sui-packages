module 0xa9c1a62fcf73b95fce42bdf6985f41a688a31782b8c7ef9b3863a16faedcb92d::example_nft {
    struct ExampleNft has store, key {
        id: 0x2::object::UID,
    }

    struct EventNftsMinted has copy, drop {
        nft_ids: vector<0x2::object::ID>,
    }

    public entry fun mint_nfts(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        while (arg1 > 0) {
            let v1 = ExampleNft{id: 0x2::object::new(arg2)};
            0x2::transfer::transfer<ExampleNft>(v1, arg0);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id<ExampleNft>(&v1));
            arg1 = arg1 - 1;
        };
        let v2 = EventNftsMinted{nft_ids: v0};
        0x2::event::emit<EventNftsMinted>(v2);
        v0
    }

    // decompiled from Move bytecode v6
}

