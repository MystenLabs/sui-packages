module 0x7fe36765c88f9be2cf33898be2b8d4e8d010b3f0400ed760a4547597b04896be::devcon {
    struct Devcon has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct DevconSuply has store, key {
        id: 0x2::object::UID,
        total_minted: u64,
        max_supply: u64,
    }

    struct DevconMinted has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct DEVCON has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun admin_mint(arg0: &AdminCap, arg1: &mut DevconSuply, arg2: &0x2::clock::Clock, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.total_minted < arg1.max_supply, 1);
        let v0 = 0x2::object::new(arg7);
        let v1 = DevconMinted{
            nft_id    : 0x2::object::uid_to_inner(&v0),
            owner     : 0x2::tx_context::sender(arg7),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<DevconMinted>(v1);
        let v2 = Devcon{
            id          : v0,
            name        : arg3,
            description : arg4,
            image_url   : arg5,
        };
        0x2::transfer::transfer<Devcon>(v2, arg6);
        arg1.total_minted = arg1.total_minted + 1;
    }

    public fun admin_modify_supply(arg0: &AdminCap, arg1: &mut DevconSuply, arg2: u64) {
        assert!(arg2 > arg1.total_minted, 2);
        arg1.max_supply = arg2;
    }

    public fun get_max_supply(arg0: &DevconSuply) : u64 {
        arg0.max_supply
    }

    public fun get_total_minted(arg0: &DevconSuply) : u64 {
        arg0.total_minted
    }

    fun init(arg0: DEVCON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<DEVCON>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        let v5 = 0x2::display::new_with_fields<Devcon>(&v0, v1, v3, arg1);
        0x2::display::update_version<Devcon>(&mut v5);
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        let v7 = DevconSuply{
            id           : 0x2::object::new(arg1),
            total_minted : 0,
            max_supply   : 2000,
        };
        0x2::transfer::public_transfer<0x2::display::Display<Devcon>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<DevconSuply>(v7);
    }

    // decompiled from Move bytecode v6
}

