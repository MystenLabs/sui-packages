module 0x630e9ed9b594236222f8a749cdf5370eece969f762be540790784554135fdb3c::nft {
    struct Collection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct MyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        token_id: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        collection_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    public entry fun add_attribute(arg0: &mut MyNFT, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, arg1, arg2);
    }

    public entry fun batch_mint_to_collection(arg0: &0x2::package::Publisher, arg1: 0x2::object::ID, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: vector<vector<0x1::string::String>>, arg7: vector<vector<0x1::string::String>>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let v1 = mint_to_collection(arg0, arg1, *0x1::vector::borrow<0x1::string::String>(&arg2, v0), *0x1::vector::borrow<0x1::string::String>(&arg3, v0), *0x1::vector::borrow<0x1::string::String>(&arg4, v0), *0x1::vector::borrow<0x1::string::String>(&arg5, v0), create_attributes_map(*0x1::vector::borrow<vector<0x1::string::String>>(&arg6, v0), *0x1::vector::borrow<vector<0x1::string::String>>(&arg7, v0)), arg8);
            0x2::transfer::transfer<MyNFT>(v1, 0x2::tx_context::sender(arg8));
            v0 = v0 + 1;
        };
    }

    public entry fun burn(arg0: MyNFT) {
        0x2::transfer::public_transfer<MyNFT>(arg0, @0x0);
    }

    fun create_attributes_map(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg0)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg0, v1), *0x1::vector::borrow<0x1::string::String>(&arg1, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun create_collection(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : Collection {
        Collection{
            id          : 0x2::object::new(arg3),
            name        : arg0,
            description : arg1,
            image_url   : arg2,
        }
    }

    public entry fun create_collection_and_transfer(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = create_collection(arg0, arg1, arg2, arg3);
        0x2::transfer::transfer<Collection>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun get_attributes(arg0: &MyNFT) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public fun get_collection_id(arg0: &MyNFT) : 0x1::option::Option<0x2::object::ID> {
        arg0.collection_id
    }

    public fun get_token_id(arg0: &MyNFT) : 0x1::string::String {
        arg0.token_id
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<NFT>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) : MyNFT {
        MyNFT{
            id            : 0x2::object::new(arg5),
            name          : arg0,
            description   : arg1,
            image_url     : arg2,
            token_id      : arg3,
            attributes    : arg4,
            collection_id : 0x1::option::none<0x2::object::ID>(),
        }
    }

    public entry fun mint_and_transfer(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2, arg3, create_attributes_map(arg4, arg5), arg6);
        0x2::transfer::transfer<MyNFT>(v0, 0x2::tx_context::sender(arg6));
    }

    public fun mint_to_collection(arg0: &0x2::package::Publisher, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg7: &mut 0x2::tx_context::TxContext) : MyNFT {
        let v0 = MyNFT{
            id            : 0x2::object::new(arg7),
            name          : arg2,
            description   : arg3,
            image_url     : arg4,
            token_id      : arg5,
            attributes    : arg6,
            collection_id : 0x1::option::some<0x2::object::ID>(arg1),
        };
        0x2::object::id<MyNFT>(&v0);
        let v1 = 0x2::display::new<MyNFT>(arg0, arg7);
        0x2::display::add<MyNFT>(&mut v1, 0x1::string::utf8(b"name"), arg2);
        0x2::display::add<MyNFT>(&mut v1, 0x1::string::utf8(b"description"), arg3);
        0x2::display::add<MyNFT>(&mut v1, 0x1::string::utf8(b"image_url"), arg4);
        0x2::display::add<MyNFT>(&mut v1, 0x1::string::utf8(b"collection_id"), 0x1::string::utf8(0x2::bcs::to_bytes<0x2::object::ID>(&arg1)));
        0x2::display::update_version<MyNFT>(&mut v1);
        0x2::transfer::public_share_object<0x2::display::Display<MyNFT>>(v1);
        v0
    }

    public entry fun mint_to_collection_and_transfer(arg0: &0x2::package::Publisher, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<0x1::string::String>, arg7: vector<0x1::string::String>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_to_collection(arg0, arg1, arg2, arg3, arg4, arg5, create_attributes_map(arg6, arg7), arg8);
        0x2::transfer::transfer<MyNFT>(v0, 0x2::tx_context::sender(arg8));
    }

    public entry fun remove_attribute(arg0: &mut MyNFT, arg1: 0x1::string::String) {
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &arg1);
    }

    public entry fun remove_collection(arg0: &mut MyNFT) {
        arg0.collection_id = 0x1::option::none<0x2::object::ID>();
    }

    public entry fun set_collection(arg0: &mut MyNFT, arg1: 0x2::object::ID) {
        arg0.collection_id = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public entry fun take_from_kiosk_and_burn<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) {
        0x2::transfer::public_transfer<T0>(0x2::kiosk::take<T0>(arg0, arg1, arg2), @0x0);
    }

    public entry fun update_collection_description(arg0: &mut Collection, arg1: 0x1::string::String) {
        arg0.description = arg1;
    }

    public entry fun update_collection_image_url(arg0: &mut Collection, arg1: 0x1::string::String) {
        arg0.image_url = arg1;
    }

    public entry fun update_collection_name(arg0: &mut Collection, arg1: 0x1::string::String) {
        arg0.name = arg1;
    }

    public entry fun update_nft_description(arg0: &mut MyNFT, arg1: 0x1::string::String) {
        arg0.description = arg1;
    }

    public entry fun update_nft_image_url(arg0: &mut MyNFT, arg1: 0x1::string::String) {
        arg0.image_url = arg1;
    }

    public entry fun update_nft_name(arg0: &mut MyNFT, arg1: 0x1::string::String) {
        arg0.name = arg1;
    }

    public entry fun update_nft_token_id(arg0: &mut MyNFT, arg1: 0x1::string::String) {
        arg0.token_id = arg1;
    }

    // decompiled from Move bytecode v6
}

