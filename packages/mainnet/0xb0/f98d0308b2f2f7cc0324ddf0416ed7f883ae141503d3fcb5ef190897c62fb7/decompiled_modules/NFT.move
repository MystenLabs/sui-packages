module 0xb0f98d0308b2f2f7cc0324ddf0416ed7f883ae141503d3fcb5ef190897c62fb7::NFT {
    struct NFTMetadata has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        website: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        admins: 0x2::vec_set::VecSet<address>,
        creator: address,
    }

    public entry fun add_admin(arg0: &mut AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 403);
        0x2::vec_set::insert<address>(&mut arg0.admins, arg1);
    }

    public entry fun batch_mint(arg0: &mut AdminCap, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: vector<address>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg0.creator == v0 || 0x2::vec_set::contains<address>(&arg0.admins, &v0), 403);
        let v1 = 0x1::vector::length<0x1::string::String>(&arg1);
        assert!(v1 == 0x1::vector::length<0x1::string::String>(&arg2), 0);
        assert!(v1 == 0x1::vector::length<0x1::string::String>(&arg3), 0);
        assert!(v1 == 0x1::vector::length<0x1::string::String>(&arg4), 0);
        assert!(v1 == 0x1::vector::length<address>(&arg5), 0);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = NFTMetadata{
                id          : 0x2::object::new(arg6),
                name        : *0x1::vector::borrow<0x1::string::String>(&arg1, v2),
                description : *0x1::vector::borrow<0x1::string::String>(&arg2, v2),
                website     : *0x1::vector::borrow<0x1::string::String>(&arg3, v2),
                image_url   : *0x1::vector::borrow<0x1::string::String>(&arg4, v2),
            };
            0x2::transfer::public_transfer<NFTMetadata>(v3, *0x1::vector::borrow<address>(&arg5, v2));
        };
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"website"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{website}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"W3Tools"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFTMetadata>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFTMetadata>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFTMetadata>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{
            id      : 0x2::object::new(arg1),
            admins  : 0x2::vec_set::empty<address>(),
            creator : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<AdminCap>(v6);
    }

    public fun is_admin(arg0: &mut AdminCap, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.admins, &arg1)
    }

    public entry fun mint(arg0: &mut AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg0.creator == v0 || 0x2::vec_set::contains<address>(&arg0.admins, &v0), 403);
        let v1 = NFTMetadata{
            id          : 0x2::object::new(arg6),
            name        : arg1,
            description : arg2,
            website     : arg3,
            image_url   : arg4,
        };
        0x2::transfer::public_transfer<NFTMetadata>(v1, arg5);
    }

    public entry fun remove_admin(arg0: &mut AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 403);
        0x2::vec_set::remove<address>(&mut arg0.admins, &arg1);
    }

    // decompiled from Move bytecode v6
}

