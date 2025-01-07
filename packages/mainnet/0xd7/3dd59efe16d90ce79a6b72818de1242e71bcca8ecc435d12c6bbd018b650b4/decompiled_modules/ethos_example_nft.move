module 0xd73dd59efe16d90ce79a6b72818de1242e71bcca8ecc435d12c6bbd018b650b4::ethos_example_nft {
    struct EthosNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct ETHOS_EXAMPLE_NFT has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun transfer(arg0: EthosNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<EthosNFT>(arg0, arg1);
    }

    public fun url(arg0: &EthosNFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: EthosNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let EthosNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &EthosNFT) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: ETHOS_EXAMPLE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"temp"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Temp_plate.svg/1280px-Temp_plate.svg.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"temp temp"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://temp.com/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"temp"));
        let v4 = 0x2::package::claim<ETHOS_EXAMPLE_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<EthosNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<EthosNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EthosNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : EthosNFT {
        let v0 = EthosNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<EthosNFT>(&v0),
            creator   : 0x2::tx_context::sender(arg3),
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v1);
        v0
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<EthosNFT>(mint(arg0, arg1, arg2, arg3), v0);
    }

    public fun name(arg0: &EthosNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut EthosNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

