module 0x7c4dd7cc0345581d3deca01bd0f6bd37692842ab5fa21843595d92bb4f4102a::Yunjude_NFT {
    struct YunjudeNFT has store, key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct YunjudeNFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct YunjudeNFTBurnEvent has copy, drop {
        object_id: 0x2::object::ID,
    }

    struct YunjudeNFTTransferEvent has copy, drop {
        object_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    public entry fun transfer(arg0: YunjudeNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = YunjudeNFTTransferEvent{
            object_id : 0x2::object::id<YunjudeNFT>(&arg0),
            from      : 0x2::tx_context::sender(arg2),
            to        : arg1,
        };
        0x2::event::emit<YunjudeNFTTransferEvent>(v0);
        0x2::transfer::public_transfer<YunjudeNFT>(arg0, arg1);
    }

    public fun url(arg0: &YunjudeNFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: YunjudeNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let YunjudeNFT {
            id          : v0,
            creator     : _,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        let v5 = v0;
        let v6 = YunjudeNFTBurnEvent{object_id: 0x2::object::uid_to_inner(&v5)};
        0x2::event::emit<YunjudeNFTBurnEvent>(v6);
        0x2::object::delete(v5);
    }

    public fun description(arg0: &YunjudeNFT) : &0x1::string::String {
        &arg0.description
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = YunjudeNFT{
            id          : 0x2::object::new(arg3),
            creator     : 0x2::tx_context::sender(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v1 = YunjudeNFTMinted{
            object_id : 0x2::object::id<YunjudeNFT>(&v0),
            creator   : 0x2::tx_context::sender(arg3),
            name      : v0.name,
        };
        0x2::event::emit<YunjudeNFTMinted>(v1);
        0x2::transfer::public_transfer<YunjudeNFT>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun name(arg0: &YunjudeNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut YunjudeNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

