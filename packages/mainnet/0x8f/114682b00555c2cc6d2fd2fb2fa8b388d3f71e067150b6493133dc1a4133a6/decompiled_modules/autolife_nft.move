module 0x8f114682b00555c2cc6d2fd2fb2fa8b388d3f71e067150b6493133dc1a4133a6::autolife_nft {
    struct RobotNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct AUTOLIFE_NFT has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun transfer(arg0: RobotNft, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<RobotNft>(arg0, arg1);
    }

    public entry fun burn(arg0: &AdminCap, arg1: RobotNft, arg2: &mut 0x2::tx_context::TxContext) {
        let RobotNft {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    fun init(arg0: AUTOLIFE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Autolife-Robotics"));
        let v4 = 0x2::package::claim<AUTOLIFE_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<RobotNft>(&v4, v0, v2, arg1);
        0x2::display::update_version<RobotNft>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<RobotNft>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    fun inner_mint_to(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = RobotNft{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<RobotNft>(&v0),
            creator   : arg3,
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<RobotNft>(v0, arg3);
    }

    public entry fun mint_to(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        inner_mint_to(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        inner_mint_to(arg0, arg1, arg2, v0, arg3);
    }

    public entry fun update_description(arg0: &mut RobotNft, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

