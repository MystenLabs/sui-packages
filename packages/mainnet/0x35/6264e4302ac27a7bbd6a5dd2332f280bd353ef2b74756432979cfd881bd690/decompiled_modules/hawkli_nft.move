module 0x356264e4302ac27a7bbd6a5dd2332f280bd353ef2b74756432979cfd881bd690::hawkli_nft {
    struct HAWKLI_NFT has drop {
        dummy_field: bool,
    }

    struct HawkliNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        owner: address,
    }

    struct WITNESS has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        object_id: address,
        creator: address,
        name: 0x1::string::String,
    }

    public fun description(arg0: &HawkliNFT) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: HAWKLI_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<HAWKLI_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<HawkliNFT>(&v0, arg1);
        0x2::display::add<HawkliNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<HawkliNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<HawkliNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/11769524?v=4"));
        0x2::display::add<HawkliNFT>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Hawkli"));
        0x2::display::update_version<HawkliNFT>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<HawkliNFT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : HawkliNFT {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = HawkliNFT{
            id          : 0x2::object::new(arg2),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            owner       : v0,
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::uid_to_address(&v1.id),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        v1
    }

    public entry fun mint_and_transfer(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2);
        0x2::transfer::public_transfer<HawkliNFT>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun name(arg0: &HawkliNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun owner(arg0: &HawkliNFT) : address {
        arg0.owner
    }

    // decompiled from Move bytecode v6
}

