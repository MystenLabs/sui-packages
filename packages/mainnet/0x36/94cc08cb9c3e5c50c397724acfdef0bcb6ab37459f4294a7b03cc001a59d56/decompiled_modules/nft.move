module 0x3694cc08cb9c3e5c50c397724acfdef0bcb6ab37459f4294a7b03cc001a59d56::nft {
    struct DynamicNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        controller_id: 0x2::object::ID,
        trait_mapping: vector<0x1::string::String>,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        controller_id: 0x2::object::ID,
    }

    public fun add_trait_to_nft(arg0: &mut DynamicNFT, arg1: &0x3694cc08cb9c3e5c50c397724acfdef0bcb6ab37459f4294a7b03cc001a59d56::controller::SharedTraitController, arg2: &0x3694cc08cb9c3e5c50c397724acfdef0bcb6ab37459f4294a7b03cc001a59d56::controller::AdminCap, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == 0x3694cc08cb9c3e5c50c397724acfdef0bcb6ab37459f4294a7b03cc001a59d56::controller::get_admin(arg1), 1);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.trait_mapping, arg3);
    }

    public fun admin_update_nft_traits(arg0: &mut DynamicNFT, arg1: &0x3694cc08cb9c3e5c50c397724acfdef0bcb6ab37459f4294a7b03cc001a59d56::controller::SharedTraitController, arg2: &0x3694cc08cb9c3e5c50c397724acfdef0bcb6ab37459f4294a7b03cc001a59d56::controller::AdminCap, arg3: vector<0x1::string::String>, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == 0x3694cc08cb9c3e5c50c397724acfdef0bcb6ab37459f4294a7b03cc001a59d56::controller::get_admin(arg1), 1);
        arg0.trait_mapping = arg3;
    }

    public fun get_controller_id(arg0: &DynamicNFT) : 0x2::object::ID {
        arg0.controller_id
    }

    public fun get_description(arg0: &DynamicNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun get_name(arg0: &DynamicNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun get_trait_image(arg0: &DynamicNFT, arg1: &0x3694cc08cb9c3e5c50c397724acfdef0bcb6ab37459f4294a7b03cc001a59d56::controller::SharedTraitController) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"<svg xmlns='http://www.w3.org/2000/svg' width='512' height='512'>");
        let v1 = &arg0.trait_mapping;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(v1)) {
            let v3 = 0x1::vector::borrow<0x1::string::String>(v1, v2);
            if (0x3694cc08cb9c3e5c50c397724acfdef0bcb6ab37459f4294a7b03cc001a59d56::storage::trait_exists(0x3694cc08cb9c3e5c50c397724acfdef0bcb6ab37459f4294a7b03cc001a59d56::controller::get_trait_storage(arg1), *v3)) {
                0x1::string::append(&mut v0, 0x1::string::utf8(b"<image href='"));
                0x1::string::append(&mut v0, 0x3694cc08cb9c3e5c50c397724acfdef0bcb6ab37459f4294a7b03cc001a59d56::controller::get_reconstructed_trait(arg1, *v3));
                0x1::string::append(&mut v0, 0x1::string::utf8(b"' x='0' y='0' width='512' height='512'/>"));
            };
            v2 = v2 + 1;
        };
        0x1::string::append(&mut v0, 0x1::string::utf8(b"</svg>"));
        v0
    }

    public fun get_trait_mapping(arg0: &DynamicNFT) : &vector<0x1::string::String> {
        &arg0.trait_mapping
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"traits"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"data:image/svg+xml;utf8,{dynamic_image}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{trait_list}"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<DynamicNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<DynamicNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<DynamicNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &0x3694cc08cb9c3e5c50c397724acfdef0bcb6ab37459f4294a7b03cc001a59d56::controller::SharedTraitController, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) : DynamicNFT {
        let v0 = DynamicNFT{
            id            : 0x2::object::new(arg4),
            name          : arg0,
            description   : arg1,
            controller_id : 0x2::object::id<0x3694cc08cb9c3e5c50c397724acfdef0bcb6ab37459f4294a7b03cc001a59d56::controller::SharedTraitController>(arg2),
            trait_mapping : arg3,
        };
        let v1 = NFTMinted{
            nft_id        : 0x2::object::uid_to_inner(&v0.id),
            owner         : 0x2::tx_context::sender(arg4),
            controller_id : v0.controller_id,
        };
        0x2::event::emit<NFTMinted>(v1);
        v0
    }

    public fun mint_and_transfer(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &0x3694cc08cb9c3e5c50c397724acfdef0bcb6ab37459f4294a7b03cc001a59d56::controller::SharedTraitController, arg3: vector<0x1::string::String>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<DynamicNFT>(mint(arg0, arg1, arg2, arg3, arg5), arg4);
    }

    public fun remove_trait_from_nft(arg0: &mut DynamicNFT, arg1: &0x3694cc08cb9c3e5c50c397724acfdef0bcb6ab37459f4294a7b03cc001a59d56::controller::SharedTraitController, arg2: &0x3694cc08cb9c3e5c50c397724acfdef0bcb6ab37459f4294a7b03cc001a59d56::controller::AdminCap, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == 0x3694cc08cb9c3e5c50c397724acfdef0bcb6ab37459f4294a7b03cc001a59d56::controller::get_admin(arg1), 1);
        0x1::vector::remove<0x1::string::String>(&mut arg0.trait_mapping, arg3);
    }

    public fun update_description(arg0: &mut DynamicNFT, arg1: &0x3694cc08cb9c3e5c50c397724acfdef0bcb6ab37459f4294a7b03cc001a59d56::controller::SharedTraitController, arg2: &0x3694cc08cb9c3e5c50c397724acfdef0bcb6ab37459f4294a7b03cc001a59d56::controller::AdminCap, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == 0x3694cc08cb9c3e5c50c397724acfdef0bcb6ab37459f4294a7b03cc001a59d56::controller::get_admin(arg1), 1);
        arg0.description = arg3;
    }

    public fun update_name(arg0: &mut DynamicNFT, arg1: &0x3694cc08cb9c3e5c50c397724acfdef0bcb6ab37459f4294a7b03cc001a59d56::controller::SharedTraitController, arg2: &0x3694cc08cb9c3e5c50c397724acfdef0bcb6ab37459f4294a7b03cc001a59d56::controller::AdminCap, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == 0x3694cc08cb9c3e5c50c397724acfdef0bcb6ab37459f4294a7b03cc001a59d56::controller::get_admin(arg1), 1);
        arg0.name = arg3;
    }

    // decompiled from Move bytecode v6
}

