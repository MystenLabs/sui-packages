module 0x50f35b9caf3162ca876d1199746717155055b9be3d7cb23f56c6ca5be7877353::souk_test_nft {
    struct SoukTestNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct SOUK_TEST_NFT has drop {
        dummy_field: bool,
    }

    public fun transfer(arg0: SoukTestNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<SoukTestNFT>(arg0, arg1);
    }

    public fun url(arg0: &SoukTestNFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: SoukTestNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let SoukTestNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &SoukTestNFT) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: SOUK_TEST_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"a cool goose out of the pond"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ih1.redbubble.net/image.4986086051.7887/flat,750x,075,f-pad,750x1000,f8f8f8.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ih1.redbubble.net/image.4986086051.7887/flat,750x,075,f-pad,750x1000,f8f8f8.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://google.com"));
        let v4 = 0x2::package::claim<SOUK_TEST_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SoukTestNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<SoukTestNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SoukTestNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = SoukTestNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<SoukTestNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<SoukTestNFT>(v1, v0);
    }

    public fun name(arg0: &SoukTestNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun register_transfer_policy(arg0: &0x2::package::Publisher, arg1: u16, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<SoukTestNFT>(arg0, arg4);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<SoukTestNFT>>(v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<SoukTestNFT>>(v1, 0x2::tx_context::sender(arg4));
    }

    public fun update_description(arg0: &mut SoukTestNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

