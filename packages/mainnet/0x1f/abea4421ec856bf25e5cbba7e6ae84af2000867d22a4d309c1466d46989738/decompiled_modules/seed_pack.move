module 0x1fabea4421ec856bf25e5cbba7e6ae84af2000867d22a4d309c1466d46989738::seed_pack {
    struct SeedPack has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        pack_type: u8,
    }

    struct SEED_PACK has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: SeedPack) {
        let SeedPack {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            pack_type   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun buy_seed_pack_with_sui(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 20000000;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= v0, 0);
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) == v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x47efdbc6f87a800909b03bd1e8be6ea1aca2d50ecb95c00c27e289fbaaa67d91);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v0, arg1), @0x47efdbc6f87a800909b03bd1e8be6ea1aca2d50ecb95c00c27e289fbaaa67d91);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg1));
        };
        let v1 = mint(0x1::string::utf8(b"Magic Pack"), 0x1::string::utf8(b"A magic seed pack with rare seeds chance"), 0x1::string::utf8(b"https://i.imgur.com/woNLd0p.png"), 1, arg1);
        0x2::transfer::public_transfer<SeedPack>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun description(arg0: &SeedPack) : &0x1::string::String {
        &arg0.description
    }

    public fun id(arg0: &SeedPack) : &0x2::object::UID {
        &arg0.id
    }

    public fun image_url(arg0: &SeedPack) : &0x1::string::String {
        &arg0.image_url
    }

    fun init(arg0: SEED_PACK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SEED_PACK>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://garden.sazuto.com/"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Grow A Garden"));
        let v5 = 0x2::display::new_with_fields<SeedPack>(&v0, v1, v3, arg1);
        0x2::display::update_version<SeedPack>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SeedPack>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) : SeedPack {
        let v0 = SeedPack{
            id          : 0x2::object::new(arg4),
            name        : arg0,
            description : arg1,
            image_url   : arg2,
            pack_type   : arg3,
        };
        0x1fabea4421ec856bf25e5cbba7e6ae84af2000867d22a4d309c1466d46989738::events::emit_seed_pack_minted(0x2::object::uid_to_inner(&v0.id), 0x2::tx_context::sender(arg4), arg3);
        v0
    }

    public fun mint_seed_pack_free(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<SeedPack>(mint(0x1::string::utf8(b"Basic Pack"), 0x1::string::utf8(b"A basic seed pack with common seeds"), 0x1::string::utf8(b"https://i.imgur.com/fPtrLI7.png"), 0, arg1), arg0);
    }

    public fun mint_to_sender(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<SeedPack>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun name(arg0: &SeedPack) : &0x1::string::String {
        &arg0.name
    }

    public fun pack_type(arg0: &SeedPack) : u8 {
        arg0.pack_type
    }

    // decompiled from Move bytecode v6
}

