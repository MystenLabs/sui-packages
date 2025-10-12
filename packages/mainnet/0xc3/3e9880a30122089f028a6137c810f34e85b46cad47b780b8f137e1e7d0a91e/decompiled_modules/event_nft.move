module 0xc33e9880a30122089f028a6137c810f34e85b46cad47b780b8f137e1e7d0a91e::event_nft {
    struct EVENT_NFT has drop {
        dummy_field: bool,
    }

    struct EventNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
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

    fun init(arg0: EVENT_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<EVENT_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<EventNFT>(&v0, arg1);
        0x2::display::add<EventNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<EventNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://wal-aggregator-testnet.staketab.org/v1/{image_cid}"));
        0x2::display::add<EventNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"SXT Event NFT"));
        0x2::display::update_version<EventNFT>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::display::Display<EventNFT>>(v1);
    }

    public entry fun mint_to(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = EventNFT{
            id         : 0x2::object::new(arg4),
            name       : arg1,
            image_cid  : arg2,
            image_mime : arg3,
        };
        0x2::transfer::public_transfer<EventNFT>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

