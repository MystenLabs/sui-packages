module 0x586a4797a42ed033d5b1cb9a35c04b7871109202b0ab41f147bb4f644676dde1::mint_nft {
    struct StoryPart has store, key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        url: 0x1::string::String,
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
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
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
            url         : arg1,
        };
        0x2::transfer::public_transfer<StoryPart>(v2, 0x2::tx_context::sender(arg2));
    }

    public fun set_url(arg0: &mut StoryPart, arg1: 0x1::string::String) {
        arg0.url = arg1;
    }

    public fun url(arg0: &StoryPart) : 0x1::string::String {
        arg0.url
    }

    // decompiled from Move bytecode v6
}

