module 0x7a9695b16975f9a8614a81fc3eb67464699255f42294f4cb7df55e9d8169f506::event_nft {
    struct EventNFT has store, key {
        id: 0x2::object::UID,
        image_cid: 0x1::string::String,
        image_mime: 0x1::string::String,
    }

    struct Collection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        image_cid: 0x1::string::String,
        image_mime: 0x1::string::String,
    }

    public entry fun create_collection(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Collection{
            id         : 0x2::object::new(arg5),
            name       : arg1,
            symbol     : arg2,
            image_cid  : arg3,
            image_mime : arg4,
        };
        0x2::transfer::public_transfer<Collection>(v0, arg0);
    }

    public entry fun mint_to(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = EventNFT{
            id         : 0x2::object::new(arg3),
            image_cid  : arg1,
            image_mime : arg2,
        };
        0x2::transfer::public_transfer<EventNFT>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

