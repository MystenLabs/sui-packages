module 0xc30d407b0c4cdee0ee4e70ef667c04e078078967e9ed6248c6672334a0b7ff28::ticket {
    struct NFTOBJ has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun url(arg0: &NFTOBJ) : &0x2::url::Url {
        &arg0.url
    }

    public fun description(arg0: &NFTOBJ) : &0x1::string::String {
        &arg0.description
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTOBJ{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            creator   : v1,
            name      : v0.name,
        };
        0x2::event::emit<MintNFTEvent>(v2);
        0x2::transfer::public_transfer<NFTOBJ>(v0, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg4);
    }

    public fun name(arg0: &NFTOBJ) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

