module 0x78fbdf252391e2b90a522017e331983e5c3b950919f7c50511c477580442bc7d::lbiyou_nft {
    struct LBiyouNFT has store, key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct LBiyouNFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct LBiyouNFTBurnEvent has copy, drop {
        object_id: 0x2::object::ID,
    }

    struct LBiyouNFTTransferEvent has copy, drop {
        object_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    public entry fun transfer(arg0: LBiyouNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = LBiyouNFTTransferEvent{
            object_id : 0x2::object::id<LBiyouNFT>(&arg0),
            from      : 0x2::tx_context::sender(arg2),
            to        : arg1,
        };
        0x2::event::emit<LBiyouNFTTransferEvent>(v0);
        0x2::transfer::public_transfer<LBiyouNFT>(arg0, arg1);
    }

    public fun url(arg0: &LBiyouNFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: LBiyouNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let LBiyouNFT {
            id          : v0,
            creator     : _,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        let v5 = v0;
        let v6 = LBiyouNFTBurnEvent{object_id: 0x2::object::uid_to_inner(&v5)};
        0x2::event::emit<LBiyouNFTBurnEvent>(v6);
        0x2::object::delete(v5);
    }

    public fun description(arg0: &LBiyouNFT) : &0x1::string::String {
        &arg0.description
    }

    public entry fun mint_to_recipient(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = LBiyouNFT{
            id          : 0x2::object::new(arg4),
            creator     : 0x2::tx_context::sender(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v1 = LBiyouNFTMinted{
            object_id : 0x2::object::id<LBiyouNFT>(&v0),
            creator   : 0x2::tx_context::sender(arg4),
            name      : v0.name,
        };
        0x2::event::emit<LBiyouNFTMinted>(v1);
        0x2::transfer::public_transfer<LBiyouNFT>(v0, arg3);
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = LBiyouNFT{
            id          : 0x2::object::new(arg3),
            creator     : 0x2::tx_context::sender(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v1 = LBiyouNFTMinted{
            object_id : 0x2::object::id<LBiyouNFT>(&v0),
            creator   : 0x2::tx_context::sender(arg3),
            name      : v0.name,
        };
        0x2::event::emit<LBiyouNFTMinted>(v1);
        0x2::transfer::public_transfer<LBiyouNFT>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun name(arg0: &LBiyouNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut LBiyouNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

