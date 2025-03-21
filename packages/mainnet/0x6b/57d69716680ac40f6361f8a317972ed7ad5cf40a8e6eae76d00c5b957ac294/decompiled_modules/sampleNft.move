module 0x6b57d69716680ac40f6361f8a317972ed7ad5cf40a8e6eae76d00c5b957ac294::sampleNft {
    struct AllocationNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        link: 0x2::url::Url,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SAMPLENFT has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun transfer(arg0: AllocationNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<AllocationNFT>(arg0, arg1);
    }

    public fun burn(arg0: AllocationNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let AllocationNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
            link        : _,
            attributes  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &AllocationNFT) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: SAMPLENFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{link}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://demonopol.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"@demonopol"));
        let v4 = 0x2::package::claim<SAMPLENFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<AllocationNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<AllocationNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<AllocationNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"amount_invested"), 0x1::string::utf8(b"123"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"round"), 0x1::string::utf8(b"1"));
        let v2 = AllocationNFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            link        : 0x2::url::new_unsafe_from_bytes(arg3),
            attributes  : v1,
        };
        let v3 = NFTMinted{
            object_id : 0x2::object::id<AllocationNFT>(&v2),
            creator   : v0,
            name      : v2.name,
        };
        0x2::event::emit<NFTMinted>(v3);
        0x2::transfer::public_transfer<AllocationNFT>(v2, v0);
    }

    public fun name(arg0: &AllocationNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun update_description(arg0: &mut AllocationNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

