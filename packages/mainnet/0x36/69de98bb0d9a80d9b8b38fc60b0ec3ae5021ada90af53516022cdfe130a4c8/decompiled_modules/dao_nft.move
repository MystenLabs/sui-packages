module 0x3669de98bb0d9a80d9b8b38fc60b0ec3ae5021ada90af53516022cdfe130a4c8::dao_nft {
    struct DaoNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct GovCap has store, key {
        id: 0x2::object::UID,
    }

    struct DAO_NFT has drop {
        dummy_field: bool,
    }

    public fun get_description(arg0: &DaoNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun get_id(arg0: &DaoNFT) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun get_image_url(arg0: &DaoNFT) : &0x1::string::String {
        &arg0.image_url
    }

    public fun get_name(arg0: &DaoNFT) : &0x1::string::String {
        &arg0.name
    }

    fun init(arg0: DAO_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        let v4 = 0x2::package::claim<DAO_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<DaoNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<DaoNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<DaoNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = GovCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<GovCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &GovCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = DaoNFT{
            id          : 0x2::object::new(arg5),
            name        : arg1,
            description : arg2,
            image_url   : arg3,
        };
        0x2::transfer::transfer<DaoNFT>(v0, arg4);
    }

    // decompiled from Move bytecode v6
}

