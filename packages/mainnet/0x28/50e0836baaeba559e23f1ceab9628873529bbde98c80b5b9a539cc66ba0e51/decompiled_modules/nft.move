module 0x2850e0836baaeba559e23f1ceab9628873529bbde98c80b5b9a539cc66ba0e51::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        owner: address,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun transfer(arg0: Nft, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg2);
        arg0.owner = arg1;
        0x2::transfer::public_transfer<Nft>(arg0, arg1);
    }

    public fun current_supply() : u64 {
        0
    }

    public fun description(arg0: &Nft) : &0x1::string::String {
        &arg0.description
    }

    public fun from_vec_to_map<T0: copy + drop, T1: drop>(arg0: vector<T0>, arg1: vector<T1>) : 0x2::vec_map::VecMap<T0, T1> {
        assert!(0x1::vector::length<T0>(&arg0) == 0x1::vector::length<T1>(&arg1), 1);
        let v0 = 0;
        let v1 = 0x2::vec_map::empty<T0, T1>();
        while (v0 < 0x1::vector::length<T0>(&arg0)) {
            0x2::vec_map::insert<T0, T1>(&mut v1, 0x1::vector::pop_back<T0>(&mut arg0), 0x1::vector::pop_back<T1>(&mut arg1));
            v0 = v0 + 1;
        };
        v1
    }

    public fun image_url(arg0: &Nft) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"owner"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{owner}"));
        let v5 = 0x2::package::claim<NFT>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<Nft>(&v5, v1, v3, arg1);
        0x2::display::update_version<Nft>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, v0);
        0x2::transfer::public_transfer<0x2::display::Display<Nft>>(v6, v0);
    }

    public fun max_supply_cap() : u64 {
        10000
    }

    public entry fun mint_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0 <= 10000, 0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = Nft{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg2),
            owner       : v0,
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<Nft>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<Nft>(v1, v0);
    }

    public fun name(arg0: &Nft) : &0x1::string::String {
        &arg0.name
    }

    public fun owner(arg0: &Nft) : &address {
        &arg0.owner
    }

    // decompiled from Move bytecode v6
}

