module 0xfdae224ac1575d84b012e0e6f9c5e28a8b957b4f6b31d7e4e843ede099aff8c6::message_nft {
    struct MessageNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        message: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: address,
    }

    struct NFTCreated has copy, drop {
        object_id: address,
        creator: address,
        name: 0x1::string::String,
        recipient: address,
    }

    public entry fun burn_nft(arg0: MessageNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let MessageNFT {
            id        : v0,
            name      : _,
            message   : _,
            image_url : _,
            creator   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun creator(arg0: &MessageNFT) : address {
        arg0.creator
    }

    public fun image_url(arg0: &MessageNFT) : &0x1::string::String {
        &arg0.image_url
    }

    public fun message(arg0: &MessageNFT) : &0x1::string::String {
        &arg0.message
    }

    public entry fun mint_message_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = MessageNFT{
            id        : 0x2::object::new(arg4),
            name      : 0x1::string::utf8(arg0),
            message   : 0x1::string::utf8(arg1),
            image_url : 0x1::string::utf8(arg2),
            creator   : v0,
        };
        let v2 = NFTCreated{
            object_id : 0x2::object::uid_to_address(&v1.id),
            creator   : v0,
            name      : v1.name,
            recipient : arg3,
        };
        0x2::event::emit<NFTCreated>(v2);
        0x2::transfer::public_transfer<MessageNFT>(v1, arg3);
    }

    public fun name(arg0: &MessageNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun transfer_nft(arg0: MessageNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<MessageNFT>(arg0, arg1);
    }

    public entry fun update_message(arg0: &mut MessageNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 0);
        arg0.message = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

