module 0xab38806fce87751f2134137a74f41158559ad671a4f12380158c71d79f930ca8::halloween_nft {
    struct StoryPart has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct StoryPartMinted has copy, drop {
        story_id: 0x2::object::ID,
        minted_by: address,
        name: 0x1::string::String,
    }

    struct HALLOWEEN_NFT has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: StoryPart, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<StoryPart>(arg0, arg1);
    }

    public entry fun burn(arg0: StoryPart, arg1: &mut 0x2::tx_context::TxContext) {
        let StoryPart {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &StoryPart) : 0x1::string::String {
        arg0.description
    }

    public fun destroy(arg0: StoryPart) {
        let StoryPart {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun image_url(arg0: &StoryPart) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: HALLOWEEN_NFT, arg1: &mut 0x2::tx_context::TxContext) {
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
        let v4 = 0x2::package::claim<HALLOWEEN_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<StoryPart>(&v4, v0, v2, arg1);
        0x2::display::update_version<StoryPart>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<StoryPart>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_to_sender(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = StoryPart{
            id          : 0x2::object::new(arg3),
            name        : arg0,
            description : arg1,
            image_url   : arg2,
        };
        let v2 = StoryPartMinted{
            story_id  : 0x2::object::id<StoryPart>(&v1),
            minted_by : v0,
            name      : v1.name,
        };
        0x2::event::emit<StoryPartMinted>(v2);
        0x2::transfer::public_transfer<StoryPart>(v1, v0);
    }

    public fun name(arg0: &StoryPart) : 0x1::string::String {
        arg0.name
    }

    // decompiled from Move bytecode v6
}

