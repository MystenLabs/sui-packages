module 0xf1bb21e304a7e006082653c02a32e52a1c325e48f247bc7f32bb8fb41208502b::frens {
    struct Fren has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        trait: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct FRENS has drop {
        dummy_field: bool,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        trait: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    public entry fun burn(arg0: Fren, arg1: &mut 0x2::tx_context::TxContext) {
        let Fren {
            id          : v0,
            name        : _,
            description : _,
            trait       : _,
            image_url   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &Fren) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &Fren) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: FRENS, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://frens-nft.netlify.app/fren/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://frens-nft.netlify.app"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"LOR3LORD"));
        let v4 = 0x2::package::claim<FRENS>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Fren>(&v4, v0, v2, arg1);
        0x2::display::update_version<Fren>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Fren>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : Fren {
        let v0 = Fren{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            trait       : 0x1::string::utf8(arg2),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        let v1 = MintNFTEvent{
            object_id   : 0x2::object::id<Fren>(&v0),
            creator     : 0x2::tx_context::sender(arg4),
            name        : v0.name,
            description : v0.description,
            trait       : v0.trait,
            image_url   : v0.image_url,
        };
        0x2::event::emit<MintNFTEvent>(v1);
        v0
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<Fren>(mint(arg0, arg1, arg2, arg3, arg4), v0);
    }

    public fun name(arg0: &Fren) : &0x1::string::String {
        &arg0.name
    }

    public fun trait(arg0: &Fren) : &0x1::string::String {
        &arg0.trait
    }

    public entry fun update_description(arg0: &mut Fren, arg1: vector<u8>) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    public entry fun update_image_url(arg0: &mut Fren, arg1: vector<u8>) {
        arg0.image_url = 0x2::url::new_unsafe_from_bytes(arg1);
    }

    public entry fun update_trait(arg0: &mut Fren, arg1: vector<u8>) {
        arg0.trait = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

