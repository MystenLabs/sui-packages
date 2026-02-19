module 0x7883f18a9764824858f831615df9269dcbe6c6158a4b7e426eaba96a04cd0e89::sxt_nft {
    struct SXT_NFT has drop {
        dummy_field: bool,
    }

    struct EventNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_cid: 0x1::string::String,
        image_mime: 0x1::string::String,
        event_date: 0x1::string::String,
        collection_name: 0x1::string::String,
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

    fun init(arg0: SXT_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SXT_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<EventNFT>(&v0, arg1);
        0x2::display::add<EventNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<EventNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://wal-aggregator-mainnet.staketab.org/v1/blobs/{image_cid}"));
        0x2::display::add<EventNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<EventNFT>(&mut v1, 0x1::string::utf8(b"event_date"), 0x1::string::utf8(b"{event_date}"));
        0x2::display::add<EventNFT>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"{collection_name}"));
        0x2::display::update_version<EventNFT>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::display::Display<EventNFT>>(v1);
    }

    public entry fun mint_to(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = EventNFT{
            id              : 0x2::object::new(arg7),
            name            : arg1,
            description     : arg2,
            image_cid       : arg3,
            image_mime      : arg4,
            event_date      : arg5,
            collection_name : arg6,
        };
        0x2::transfer::public_transfer<EventNFT>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

