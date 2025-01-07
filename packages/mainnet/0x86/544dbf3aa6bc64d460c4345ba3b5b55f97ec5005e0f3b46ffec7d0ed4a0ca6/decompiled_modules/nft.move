module 0x86544dbf3aa6bc64d460c4345ba3b5b55f97ec5005e0f3b46ffec7d0ed4a0ca6::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct BeLaunchNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        img_url: 0x2::url::Url,
        url: 0x2::url::Url,
        creator: address,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun url(arg0: &BeLaunchNFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: BeLaunchNFT) {
        let BeLaunchNFT {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            img_url     : _,
            url         : _,
            creator     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &BeLaunchNFT) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description} - Minted by BeLaunch"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://belaunch.io/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<BeLaunchNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<BeLaunchNFT>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v6);
        0x2::transfer::public_transfer<0x2::display::Display<BeLaunchNFT>>(v5, v6);
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = BeLaunchNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg2),
            img_url     : 0x2::url::new_unsafe_from_bytes(arg2),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            creator     : v0,
        };
        let v2 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v1.id),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<MintNFTEvent>(v2);
        0x2::transfer::transfer<BeLaunchNFT>(v1, v0);
    }

    public fun name(arg0: &BeLaunchNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut BeLaunchNFT, arg1: vector<u8>) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

