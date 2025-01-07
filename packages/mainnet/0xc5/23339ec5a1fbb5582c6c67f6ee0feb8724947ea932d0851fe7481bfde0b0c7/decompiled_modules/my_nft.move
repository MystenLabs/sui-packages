module 0xc523339ec5a1fbb5582c6c67f6ee0feb8724947ea932d0851fe7481bfde0b0c7::my_nft {
    struct FlatflaxNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct FlatflaxNFTMintEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct FlatflaxNFTTransferEvent has copy, drop {
        object_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct FlatflaxNFTBurnEvent has copy, drop {
        object_id: 0x2::object::ID,
    }

    public entry fun transfer(arg0: FlatflaxNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = FlatflaxNFTTransferEvent{
            object_id : 0x2::object::id<FlatflaxNFT>(&arg0),
            from      : 0x2::tx_context::sender(arg2),
            to        : arg1,
        };
        0x2::event::emit<FlatflaxNFTTransferEvent>(v0);
        0x2::transfer::public_transfer<FlatflaxNFT>(arg0, arg1);
    }

    public fun url(arg0: &FlatflaxNFT) : 0x2::url::Url {
        arg0.url
    }

    public entry fun burn(arg0: FlatflaxNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let FlatflaxNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        let v4 = v0;
        let v5 = FlatflaxNFTBurnEvent{object_id: 0x2::object::uid_to_inner(&v4)};
        0x2::event::emit<FlatflaxNFTBurnEvent>(v5);
        0x2::object::delete(v4);
    }

    public fun description(arg0: &FlatflaxNFT) : 0x1::string::String {
        arg0.description
    }

    public entry fun mint_nft(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = FlatflaxNFT{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"FlatflaxNft"),
            description : 0x1::string::utf8(b"flatflax's NFT"),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/14267118?v=4"),
        };
        let v1 = FlatflaxNFTMintEvent{
            object_id : 0x2::object::id<FlatflaxNFT>(&v0),
            creator   : 0x2::tx_context::sender(arg1),
            name      : v0.name,
        };
        0x2::event::emit<FlatflaxNFTMintEvent>(v1);
        0x2::transfer::public_transfer<FlatflaxNFT>(v0, arg0);
    }

    public fun name(arg0: &FlatflaxNFT) : 0x1::string::String {
        arg0.name
    }

    public entry fun update_description(arg0: &mut FlatflaxNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

