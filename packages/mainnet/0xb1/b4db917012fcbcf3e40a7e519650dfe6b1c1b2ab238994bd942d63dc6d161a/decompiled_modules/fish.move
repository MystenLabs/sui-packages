module 0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::fish {
    struct Fish has key {
        id: 0x2::object::UID,
        name: 0x1::ascii::String,
        image_url: 0x2::url::Url,
        description: 0x1::ascii::String,
    }

    struct FishMintedEvent has copy, drop {
        fish_id: 0x2::object::ID,
        name: 0x1::ascii::String,
        image_url: 0x2::url::Url,
        description: 0x1::ascii::String,
    }

    struct FishBurnedEvent has copy, drop {
        fish_id: 0x2::object::ID,
    }

    struct FISH has drop {
        dummy_field: bool,
    }

    public(friend) fun transfer(arg0: Fish, arg1: address) {
        0x2::transfer::transfer<Fish>(arg0, arg1);
    }

    public(friend) fun burn_and_emit(arg0: Fish) {
        let v0 = FishBurnedEvent{fish_id: 0x2::object::id<Fish>(&arg0)};
        0x2::event::emit<FishBurnedEvent>(v0);
        let Fish {
            id          : v1,
            name        : _,
            image_url   : _,
            description : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    fun init(arg0: FISH, arg1: &mut 0x2::tx_context::TxContext) {
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
        let v4 = 0x2::package::claim<FISH>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Fish>(&v4, v0, v2, arg1);
        0x2::display::update_version<Fish>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Fish>>(v5, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint_and_emit(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : Fish {
        let v0 = Fish{
            id          : 0x2::object::new(arg3),
            name        : 0x1::ascii::string(arg0),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg1),
            description : 0x1::ascii::string(arg2),
        };
        let v1 = FishMintedEvent{
            fish_id     : 0x2::object::id<Fish>(&v0),
            name        : v0.name,
            image_url   : v0.image_url,
            description : v0.description,
        };
        0x2::event::emit<FishMintedEvent>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

