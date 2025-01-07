module 0x9af187f7781ae0a9066dfdbae7e74559631055d13525431d7818d0eb0ed3b81c::stamp {
    struct Stamp has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct StampMetadata has drop, store {
        id: 0x2::object::ID,
    }

    struct StampArchive has store, key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, StampMetadata>,
    }

    struct StampSupply has store, key {
        id: 0x2::object::UID,
        total_minted: u64,
        max_supply: u64,
    }

    struct StampMinted has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct STAMP has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun admin_add_stamp_to_archive(arg0: &AdminCap, arg1: &mut StampArchive, arg2: address, arg3: 0x2::object::ID) {
        assert!(!has_stamp(arg1, arg2), 3);
        let v0 = StampMetadata{id: arg3};
        0x2::table::add<address, StampMetadata>(&mut arg1.users, arg2, v0);
    }

    public fun admin_mint(arg0: &AdminCap, arg1: &mut StampArchive, arg2: &mut StampSupply, arg3: &0x2::clock::Clock, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!has_stamp(arg1, arg7), 3);
        assert!(arg2.total_minted < arg2.max_supply, 1);
        let v0 = 0x2::object::new(arg8);
        let v1 = StampMinted{
            nft_id    : 0x2::object::uid_to_inner(&v0),
            owner     : 0x2::tx_context::sender(arg8),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<StampMinted>(v1);
        let v2 = Stamp{
            id          : v0,
            name        : arg4,
            description : arg5,
            image_url   : arg6,
        };
        admin_add_stamp_to_archive(arg0, arg1, arg7, 0x2::object::uid_to_inner(&v2.id));
        arg2.total_minted = arg2.total_minted + 1;
        0x2::transfer::transfer<Stamp>(v2, arg7);
    }

    public fun admin_modify_supply(arg0: &AdminCap, arg1: &mut StampSupply, arg2: u64) {
        assert!(arg2 > arg1.total_minted, 2);
        arg1.max_supply = arg2;
    }

    public fun get_max_supply(arg0: &StampSupply) : u64 {
        arg0.max_supply
    }

    public fun get_total_minted(arg0: &StampSupply) : u64 {
        arg0.total_minted
    }

    public fun has_stamp(arg0: &StampArchive, arg1: address) : bool {
        0x2::table::contains<address, StampMetadata>(&arg0.users, arg1)
    }

    fun init(arg0: STAMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<STAMP>(arg0, arg1);
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
        let v5 = 0x2::display::new_with_fields<Stamp>(&v0, v1, v3, arg1);
        0x2::display::update_version<Stamp>(&mut v5);
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        let v7 = StampSupply{
            id           : 0x2::object::new(arg1),
            total_minted : 0,
            max_supply   : 2000,
        };
        let v8 = StampArchive{
            id    : 0x2::object::new(arg1),
            users : 0x2::table::new<address, StampMetadata>(arg1),
        };
        0x2::transfer::public_transfer<0x2::display::Display<Stamp>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<StampArchive>(v8);
        0x2::transfer::share_object<StampSupply>(v7);
    }

    // decompiled from Move bytecode v6
}

