module 0xb64953f3b985d4868aa8605a19437c40f75151e8d6675d92bf327230f5c380bb::proof_of_existence {
    struct MetaData has copy, drop {
        creator: address,
        metadata: vector<u8>,
    }

    public entry fun mint() {
    }

    public entry fun nft_mint(arg0: vector<u8>) {
    }

    public entry fun nft_mint_w_event(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MetaData{
            creator  : 0x2::tx_context::sender(arg1),
            metadata : arg0,
        };
        0x2::event::emit<MetaData>(v0);
    }

    // decompiled from Move bytecode v6
}

