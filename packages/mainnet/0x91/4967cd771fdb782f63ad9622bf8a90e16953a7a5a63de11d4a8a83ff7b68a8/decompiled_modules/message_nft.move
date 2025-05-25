module 0x914967cd771fdb782f63ad9622bf8a90e16953a7a5a63de11d4a8a83ff7b68a8::message_nft {
    struct MessageNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        attribute_keys: vector<0x1::string::String>,
        attribute_values: vector<0x1::string::String>,
        creator: address,
    }

    struct NFTCreated has copy, drop {
        object_id: address,
        creator: address,
        name: 0x1::string::String,
        recipient: address,
    }

    public fun attribute_keys(arg0: &MessageNFT) : &vector<0x1::string::String> {
        &arg0.attribute_keys
    }

    public fun attribute_values(arg0: &MessageNFT) : &vector<0x1::string::String> {
        &arg0.attribute_values
    }

    public entry fun burn_nft(arg0: MessageNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let MessageNFT {
            id               : v0,
            name             : _,
            description      : _,
            url              : _,
            attribute_keys   : _,
            attribute_values : _,
            creator          : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun creator(arg0: &MessageNFT) : address {
        arg0.creator
    }

    public fun description(arg0: &MessageNFT) : &0x1::string::String {
        &arg0.description
    }

    public entry fun mint_message_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"Type"));
        0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::utf8(b"Recovery Message"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"Purpose"));
        0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::utf8(b"Fund Recovery"));
        let v3 = MessageNFT{
            id               : 0x2::object::new(arg4),
            name             : 0x1::string::utf8(arg0),
            description      : 0x1::string::utf8(arg1),
            url              : 0x1::string::utf8(arg2),
            attribute_keys   : v1,
            attribute_values : v2,
            creator          : v0,
        };
        let v4 = NFTCreated{
            object_id : 0x2::object::uid_to_address(&v3.id),
            creator   : v0,
            name      : v3.name,
            recipient : arg3,
        };
        0x2::event::emit<NFTCreated>(v4);
        0x2::transfer::public_transfer<MessageNFT>(v3, arg3);
    }

    public fun name(arg0: &MessageNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun transfer_nft(arg0: MessageNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<MessageNFT>(arg0, arg1);
    }

    public entry fun update_description(arg0: &mut MessageNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 0);
        arg0.description = 0x1::string::utf8(arg1);
    }

    public fun url(arg0: &MessageNFT) : &0x1::string::String {
        &arg0.url
    }

    // decompiled from Move bytecode v6
}

