module 0xbfdfac99613211507919e79fe86ca00d7d958bda1a3a16358c9d4caec986e871::danny_nft {
    struct DannyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct DannyNFTMintEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct DannyNFTTransferEvent has copy, drop {
        object_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct DannyNFTBurnEvent has copy, drop {
        object_id: 0x2::object::ID,
    }

    public fun url(arg0: &DannyNFT) : 0x2::url::Url {
        arg0.url
    }

    public entry fun burn_nft(arg0: DannyNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let DannyNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        let v4 = v0;
        let v5 = DannyNFTBurnEvent{object_id: 0x2::object::uid_to_inner(&v4)};
        0x2::event::emit<DannyNFTBurnEvent>(v5);
        0x2::object::delete(v4);
    }

    public fun description(arg0: &DannyNFT) : 0x1::string::String {
        arg0.description
    }

    public entry fun mint_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = DannyNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = DannyNFTMintEvent{
            object_id : 0x2::object::id<DannyNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<DannyNFTMintEvent>(v2);
        0x2::transfer::public_transfer<DannyNFT>(v1, v0);
    }

    public fun name(arg0: &DannyNFT) : 0x1::string::String {
        arg0.name
    }

    public entry fun transfer_nft(arg0: DannyNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = DannyNFTTransferEvent{
            object_id : 0x2::object::id<DannyNFT>(&arg0),
            from      : 0x2::tx_context::sender(arg2),
            to        : arg1,
        };
        0x2::event::emit<DannyNFTTransferEvent>(v0);
        0x2::transfer::public_transfer<DannyNFT>(arg0, arg1);
    }

    public entry fun update_description(arg0: &mut DannyNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

