module 0xd78e4fb54818af066e31769efc6710243479ca11a0eab984ef7cd6991b8b434b::strik3r_nft {
    struct NftMintCap has store, key {
        id: 0x2::object::UID,
    }

    struct Strik3rNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x2::url::Url,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NftMintCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<NftMintCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun mint(arg0: &NftMintCap, arg1: address, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Strik3rNft{
            id   : 0x2::object::new(arg4),
            name : arg2,
            url  : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        0x2::transfer::public_transfer<Strik3rNft>(v0, arg1);
    }

    // decompiled from Move bytecode v7
}

