module 0x14715371121fc36218899c9b995219415f3e53f39009b6674df5d365e46a4be6::nft_mint {
    struct NFT_MINT has drop {
        dummy_field: bool,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        creator: address,
    }

    fun init(arg0: NFT_MINT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<NFT_MINT>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : NFT {
        NFT{
            id          : 0x2::object::new(arg3),
            name        : arg0,
            description : arg1,
            url         : arg2,
            creator     : 0x2::tx_context::sender(arg3),
        }
    }

    public entry fun mint_and_send(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<NFT>(mint(0x1::string::utf8(b"Test Name NoPub"), 0x1::string::utf8(b"Test Desc NoPub"), 0x1::string::utf8(b"test_nopub.png"), arg1), arg0);
    }

    // decompiled from Move bytecode v6
}

