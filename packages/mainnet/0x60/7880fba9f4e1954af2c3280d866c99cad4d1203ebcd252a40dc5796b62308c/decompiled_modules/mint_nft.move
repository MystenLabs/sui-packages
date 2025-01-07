module 0x607880fba9f4e1954af2c3280d866c99cad4d1203ebcd252a40dc5796b62308c::mint_nft {
    struct StoryPart has store, key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct StoryPartMinted has copy, drop {
        story_id: 0x2::object::ID,
        minted_by: address,
    }

    public fun description(arg0: &StoryPart) : 0x1::string::String {
        arg0.description
    }

    public fun destroy(arg0: StoryPart) {
        let StoryPart {
            id          : v0,
            description : _,
            image_url   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun image_url(arg0: &StoryPart) : 0x1::string::String {
        arg0.image_url
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg2);
        let v1 = StoryPartMinted{
            story_id  : 0x2::object::uid_to_inner(&v0),
            minted_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<StoryPartMinted>(v1);
        let v2 = StoryPart{
            id          : v0,
            description : arg0,
            image_url   : arg1,
        };
        0x2::transfer::public_transfer<StoryPart>(v2, 0x2::tx_context::sender(arg2));
    }

    public fun set_image_url(arg0: &mut StoryPart, arg1: 0x1::string::String) {
        arg0.image_url = arg1;
    }

    // decompiled from Move bytecode v6
}

