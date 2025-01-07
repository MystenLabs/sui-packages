module 0x48e113de1af3d4c1d1cf5b50dbaf4f2d8a1c5db46b48aae82e666e3e94c678ec::special_collection_nft {
    struct SPECIAL_COLLECTION_NFT has drop {
        dummy_field: bool,
    }

    struct JerryNFT has store, key {
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

    struct JerryCollection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        nfts: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    public entry fun transfer(arg0: JerryNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<JerryNFT>(arg0, arg1);
    }

    public fun url(arg0: &JerryNFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: JerryNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let JerryNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun create_collection(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = JerryCollection{
            id          : 0x2::object::new(arg2),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            nfts        : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::public_transfer<JerryCollection>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun description(arg0: &JerryNFT) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: SPECIAL_COLLECTION_NFT, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ethos-example-app.onrender.com/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Jerry"));
        let v4 = 0x2::package::claim<SPECIAL_COLLECTION_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<JerryNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<JerryNFT>(&mut v5);
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"symbol"));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"Jerry"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"Jerry"));
        let v10 = 0x2::display::new_with_fields<JerryCollection>(&v4, v6, v8, arg1);
        0x2::display::update_version<JerryCollection>(&mut v10);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<JerryNFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<JerryCollection>>(v10, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : JerryNFT {
        let v0 = JerryNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<JerryNFT>(&v0),
            creator   : 0x2::tx_context::sender(arg3),
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v1);
        v0
    }

    public entry fun mint_to_collection(arg0: &mut JerryCollection, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg1, arg2, arg3, arg4);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.nfts, 0x2::object::id<JerryNFT>(&v0));
        0x2::transfer::public_transfer<JerryNFT>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<JerryNFT>(mint(arg0, arg1, arg2, arg3), v0);
    }

    public fun name(arg0: &JerryNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun remove_from_collection(arg0: &mut JerryCollection, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.nfts, &arg1);
    }

    public entry fun update_description(arg0: &mut JerryNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

