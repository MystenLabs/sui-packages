module 0x41e68a8c3f5160b925bbfc3eaa5d39dabb9debcd1ad1f2ba4bdfe58206aafd63::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun get_metadata(arg0: &Nft) : (&0x1::string::String, &0x1::string::String, &0x2::url::Url, &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) {
        (&arg0.name, &arg0.description, &arg0.image_url, &arg0.attributes)
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<Nft>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Nft>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Collection"), 0x1::string::utf8(b"Girls"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Number"), 0x1::string::utf8(b"3"));
        let v1 = Nft{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg2),
            attributes  : v0,
        };
        0x2::transfer::public_transfer<Nft>(v1, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

