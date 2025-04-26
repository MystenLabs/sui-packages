module 0x23bce84099ad42756200231f172313b31b46a5edd21e9ddc0a9f8aa650a59e6c::nft_mint {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        creator: address,
    }

    struct NFT_MINT has drop {
        dummy_field: bool,
    }

    struct Dummy has store, key {
        id: 0x2::object::UID,
    }

    public entry fun create_dummy(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Dummy{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<Dummy>(v0, 0x2::tx_context::sender(arg0));
    }

    fun init(arg0: NFT_MINT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<NFT_MINT>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    fun mint(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : NFT {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = NFT{
            id          : 0x2::object::new(arg4),
            name        : arg1,
            description : arg2,
            url         : arg3,
            creator     : v0,
        };
        let v2 = 0x2::display::new<NFT>(arg0, arg4);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"creator"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, v1.name);
        0x1::vector::push_back<0x1::string::String>(v6, v1.description);
        0x1::vector::push_back<0x1::string::String>(v6, v1.url);
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"Creator Address Placeholder"));
        0x2::display::add_multiple<NFT>(&mut v2, v3, v5);
        0x2::display::update_version<NFT>(&mut v2);
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v2, v0);
        v1
    }

    public entry fun mint_and_send(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<NFT>(mint(arg0, arg1, arg2, arg3, arg5), arg4);
    }

    public entry fun test_dummy_object(arg0: &Dummy, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun test_publisher_object(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

