module 0xab2b8527cafe2d9b40f3246f57d764404e7bde55c82c40a54469ba87ba9c5751::gaowanlang_nft {
    struct GaowanlangNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct GaowanlangNFTMintEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct GaowanlangNFTTransferEvent has copy, drop {
        object_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct GaowanlangNFTBurnEvent has copy, drop {
        object_id: 0x2::object::ID,
    }

    public fun url(arg0: &GaowanlangNFT) : 0x2::url::Url {
        arg0.url
    }

    public entry fun burn_nft(arg0: GaowanlangNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let GaowanlangNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        let v4 = v0;
        let v5 = GaowanlangNFTBurnEvent{object_id: 0x2::object::uid_to_inner(&v4)};
        0x2::event::emit<GaowanlangNFTBurnEvent>(v5);
        0x2::object::delete(v4);
    }

    public fun description(arg0: &GaowanlangNFT) : 0x1::string::String {
        arg0.description
    }

    public entry fun mint_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = GaowanlangNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = GaowanlangNFTMintEvent{
            object_id : 0x2::object::id<GaowanlangNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<GaowanlangNFTMintEvent>(v2);
        0x2::transfer::public_transfer<GaowanlangNFT>(v1, v0);
    }

    public fun name(arg0: &GaowanlangNFT) : 0x1::string::String {
        arg0.name
    }

    public entry fun transfer_nft(arg0: GaowanlangNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = GaowanlangNFTTransferEvent{
            object_id : 0x2::object::id<GaowanlangNFT>(&arg0),
            from      : 0x2::tx_context::sender(arg2),
            to        : arg1,
        };
        0x2::event::emit<GaowanlangNFTTransferEvent>(v0);
        0x2::transfer::public_transfer<GaowanlangNFT>(arg0, arg1);
    }

    public entry fun update_description(arg0: &mut GaowanlangNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

