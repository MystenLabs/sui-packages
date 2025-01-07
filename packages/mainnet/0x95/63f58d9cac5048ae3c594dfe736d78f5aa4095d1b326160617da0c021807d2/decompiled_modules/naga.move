module 0x9563f58d9cac5048ae3c594dfe736d78f5aa4095d1b326160617da0c021807d2::naga {
    struct Naga has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        video_url: 0x1::string::String,
        image_url: 0x1::string::String,
        artist: 0x1::string::String,
    }

    struct NagaSupply has store, key {
        id: 0x2::object::UID,
        total_minted: u64,
        max_supply: u64,
    }

    struct NagaMinted has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct NAGA has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun admin_mint(arg0: &AdminCap, arg1: &mut NagaSupply, arg2: &0x2::clock::Clock, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) : Naga {
        assert!(arg1.total_minted < arg1.max_supply, 1);
        let v0 = 0x2::object::new(arg8);
        let v1 = NagaMinted{
            nft_id    : 0x2::object::uid_to_inner(&v0),
            owner     : 0x2::tx_context::sender(arg8),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<NagaMinted>(v1);
        let v2 = Naga{
            id          : v0,
            name        : arg3,
            description : arg4,
            video_url   : arg5,
            image_url   : arg6,
            artist      : arg7,
        };
        arg1.total_minted = arg1.total_minted + 1;
        v2
    }

    public fun admin_modify_supply(arg0: &AdminCap, arg1: &mut NagaSupply, arg2: u64) {
        assert!(arg2 > arg1.total_minted, 2);
        arg1.max_supply = arg2;
    }

    public fun get_max_supply(arg0: &NagaSupply) : u64 {
        arg0.max_supply
    }

    public fun get_total_minted(arg0: &NagaSupply) : u64 {
        arg0.total_minted
    }

    fun init(arg0: NAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NAGA>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"video_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"artist"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{video_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{artist}"));
        let v5 = 0x2::display::new_with_fields<Naga>(&v0, v1, v3, arg1);
        0x2::display::update_version<Naga>(&mut v5);
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        let v7 = NagaSupply{
            id           : 0x2::object::new(arg1),
            total_minted : 0,
            max_supply   : 2000,
        };
        0x2::transfer::public_transfer<0x2::display::Display<Naga>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<NagaSupply>(v7);
    }

    // decompiled from Move bytecode v6
}

