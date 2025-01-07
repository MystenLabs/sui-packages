module 0x28fbce0eef827acdfa86eac5ed6365c7980c499643daaf4e60b5532d734d8a50::nft {
    struct CoCoNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x1::string::String,
        created_by: address,
        created_at: u64,
    }

    struct VisitorList has store, key {
        id: 0x2::object::UID,
        date: 0x1::string::String,
        expired_at: u64,
        visitors: 0x2::vec_set::VecSet<address>,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    public fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : CoCoNFT {
        CoCoNFT{
            id          : 0x2::object::new(arg4),
            name        : arg0,
            description : arg1,
            img_url     : arg2,
            created_by  : 0x2::tx_context::sender(arg4),
            created_at  : 0x2::clock::timestamp_ms(arg3),
        }
    }

    fun count_key() : 0x1::string::String {
        0x1::string::utf8(b"count")
    }

    public entry fun create_list(arg0: 0x1::string::String, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = VisitorList{
            id         : 0x2::object::new(arg2),
            date       : arg0,
            expired_at : arg1,
            visitors   : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::public_share_object<VisitorList>(v0);
    }

    fun date_key() : 0x1::string::String {
        0x1::string::utf8(b"date_list")
    }

    public entry fun first_mint(arg0: &mut VisitorList, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2, arg3, arg4, arg6);
        0x2::vec_set::insert<0x1::string::String>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::vec_set::VecSet<0x1::string::String>>(&mut v0.id, date_key()), arg5);
        0x2::transfer::public_transfer<CoCoNFT>(v0, 0x2::tx_context::sender(arg6));
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://poap.umilabs.org"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui Japan Meetup Visitor"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<CoCoNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<CoCoNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CoCoNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    fun item_key() : 0x1::string::String {
        0x1::string::utf8(b"item")
    }

    public fun mint(arg0: &mut VisitorList, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : CoCoNFT {
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.expired_at, 1002);
        0x2::vec_set::insert<address>(&mut arg0.visitors, 0x2::tx_context::sender(arg5));
        let v0 = CoCoNFT{
            id          : 0x2::object::new(arg5),
            name        : arg2,
            description : arg3,
            img_url     : arg4,
            created_by  : 0x2::tx_context::sender(arg5),
            created_at  : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut v0.id, count_key(), 1);
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_set::VecSet<0x1::string::String>>(&mut v0.id, date_key(), 0x2::vec_set::empty<0x1::string::String>());
        0x2::dynamic_field::add<0x1::string::String, address>(&mut v0.id, sender_key(), 0x2::tx_context::sender(arg5));
        v0
    }

    fun sender_key() : 0x1::string::String {
        0x1::string::utf8(b"sender_address")
    }

    public fun uid_mut_as_owner(arg0: &mut CoCoNFT) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}

