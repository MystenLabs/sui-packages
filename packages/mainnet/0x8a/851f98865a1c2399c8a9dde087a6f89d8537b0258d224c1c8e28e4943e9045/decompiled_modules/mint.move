module 0x8a851f98865a1c2399c8a9dde087a6f89d8537b0258d224c1c8e28e4943e9045::mint {
    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x2::url::Url,
        description: 0x1::string::String,
    }

    struct MintNFTEvent has copy, drop {
        id: 0x2::object::ID,
        owner_addr: address,
        name_nft: 0x1::string::String,
    }

    struct MINT has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Nft{
            id          : 0x2::object::new(arg3),
            name        : arg0,
            image_url   : 0x2::url::new_unsafe(0x1::string::to_ascii(arg1)),
            description : arg2,
        };
        let v1 = MintNFTEvent{
            id         : 0x2::object::uid_to_inner(&v0.id),
            owner_addr : 0x2::tx_context::sender(arg3),
            name_nft   : arg0,
        };
        0x2::event::emit<MintNFTEvent>(v1);
        0x2::transfer::public_transfer<Nft>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun burn(arg0: Nft, arg1: &mut 0x2::tx_context::TxContext) {
        let Nft {
            id          : v0,
            name        : _,
            image_url   : _,
            description : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: MINT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        let v4 = 0x2::package::claim<MINT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Nft>(&v4, v0, v2, arg1);
        0x2::display::update_version<Nft>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Nft>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

