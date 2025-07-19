module 0x52f94b5408538cdba9a9f03098b7cc442b6c7274e5144a5069aefaabe4422c60::artfi_nft {
    struct ARTFI_NFT has drop {
        dummy_field: bool,
    }

    struct AdminRegistry has key {
        id: 0x2::object::UID,
        admins: 0x2::vec_set::VecSet<address>,
    }

    struct ArtfiConnectNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        project_url: 0x1::string::String,
        creator: 0x1::string::String,
    }

    struct InitEvent has copy, drop {
        admin: address,
    }

    struct AdminAddedEvent has copy, drop {
        admin: address,
    }

    struct AdminRemovedEvent has copy, drop {
        admin: address,
    }

    struct MintEvent has copy, drop {
        object_id: 0x2::object::ID,
        recipient: address,
        name: 0x1::string::String,
    }

    public entry fun add_admin(arg0: &mut AdminRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &v0), 1);
        0x2::vec_set::insert<address>(&mut arg0.admins, arg1);
        let v1 = AdminAddedEvent{admin: arg1};
        0x2::event::emit<AdminAddedEvent>(v1);
    }

    public fun get_creator(arg0: &ArtfiConnectNFT) : &0x1::string::String {
        &arg0.creator
    }

    public fun get_description(arg0: &ArtfiConnectNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun get_image_url(arg0: &ArtfiConnectNFT) : &0x1::string::String {
        &arg0.image_url
    }

    public fun get_name(arg0: &ArtfiConnectNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun get_project_url(arg0: &ArtfiConnectNFT) : &0x1::string::String {
        &arg0.project_url
    }

    fun init(arg0: ARTFI_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ARTFI_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{project_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        let v5 = 0x2::display::new_with_fields<ArtfiConnectNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<ArtfiConnectNFT>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        let v7 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v7, v6);
        let v8 = AdminRegistry{
            id     : 0x2::object::new(arg1),
            admins : v7,
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v6);
        0x2::transfer::public_transfer<0x2::display::Display<ArtfiConnectNFT>>(v5, v6);
        0x2::transfer::share_object<AdminRegistry>(v8);
        let v9 = InitEvent{admin: v6};
        0x2::event::emit<InitEvent>(v9);
    }

    public entry fun mint_nft(arg0: &mut AdminRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1, 2);
        let v0 = 0x2::vec_set::keys<address>(&arg0.admins);
        assert!(!0x1::vector::is_empty<address>(v0), 1);
        let v1 = 0x1::string::utf8(b"Artfi Connect- Minimizing the Barriers.");
        let v2 = ArtfiConnectNFT{
            id          : 0x2::object::new(arg2),
            name        : v1,
            description : 0x1::string::utf8(b"Artfi Connect is a universal pass bridging cultures and communities, blending inclusivity with art to create a globally connected experience."),
            image_url   : 0x1::string::utf8(b"https://gateway.pinata.cloud/ipfs/QmRjZ76y7JXa5FUfAfRNi3G7uYzqVKTcfb76k5WxHgLyWG"),
            project_url : 0x1::string::utf8(b"https://artficonnect.com/"),
            creator     : 0x2::address::to_string(*0x1::vector::borrow<address>(v0, 0)),
        };
        let v3 = MintEvent{
            object_id : 0x2::object::id<ArtfiConnectNFT>(&v2),
            recipient : arg1,
            name      : v1,
        };
        0x2::event::emit<MintEvent>(v3);
        0x2::transfer::public_transfer<ArtfiConnectNFT>(v2, arg1);
    }

    public entry fun remove_admin(arg0: &mut AdminRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &v0), 1);
        0x2::vec_set::remove<address>(&mut arg0.admins, &arg1);
        let v1 = AdminRemovedEvent{admin: arg1};
        0x2::event::emit<AdminRemovedEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

