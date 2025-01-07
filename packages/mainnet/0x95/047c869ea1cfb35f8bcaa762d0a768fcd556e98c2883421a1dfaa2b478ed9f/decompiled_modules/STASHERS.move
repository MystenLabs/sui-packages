module 0x95047c869ea1cfb35f8bcaa762d0a768fcd556e98c2883421a1dfaa2b478ed9f::STASHERS {
    struct STASHERS has drop {
        dummy_field: bool,
    }

    struct StasherStation has key {
        id: 0x2::object::UID,
        stashers: 0x2::table::Table<address, bool>,
    }

    struct Stasher has key {
        id: 0x2::object::UID,
        sid: 0x1::string::String,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        nickname: 0x1::string::String,
        twitter: 0x1::string::String,
        stashs: 0x2::vec_set::VecSet<Stash>,
    }

    struct Stash has copy, drop, store {
        sid: 0x1::string::String,
        content: 0x1::string::String,
        link: 0x1::string::String,
        timestamp_ms: u64,
    }

    public entry fun add_item<T0: store + key>(arg0: &mut Stasher, arg1: T0) {
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, 0x2::object::id<T0>(&arg1), arg1);
    }

    public fun create_stash(arg0: &mut Stasher, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        0x2::vec_set::insert<Stash>(&mut arg0.stashs, new_stash(arg3, arg4, arg2, 0x2::clock::timestamp_ms(arg1)));
    }

    public fun create_stasher(arg0: &mut StasherStation, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        if (0x2::table::contains<address, bool>(&arg0.stashers, v0)) {
            abort 999
        };
        0x2::table::add<address, bool>(&mut arg0.stashers, v0, true);
        0x2::transfer::transfer<Stasher>(new_stasher(arg1, arg2, arg3, arg4, arg5, arg6, arg7), v0);
    }

    public fun delete_stash(arg0: &mut Stasher, arg1: &Stash) {
        0x2::vec_set::remove<Stash>(&mut arg0.stashs, arg1);
    }

    public fun delete_stasher(arg0: Stasher) {
        let Stasher {
            id          : v0,
            sid         : _,
            name        : _,
            image_url   : _,
            description : _,
            nickname    : _,
            twitter     : _,
            stashs      : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: STASHERS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = StasherStation{
            id       : 0x2::object::new(arg1),
            stashers : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<StasherStation>(v0);
        let v1 = 0x2::package::claim<STASHERS>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"sid"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"nickname"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"twitter"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"stashs"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{sid}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{nickname}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{twitter}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{stashs}"));
        let v6 = 0x2::display::new_with_fields<Stasher>(&v1, v2, v4, arg1);
        0x2::display::update_version<Stasher>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<Stasher>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
    }

    fun new_stash(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64) : Stash {
        Stash{
            sid          : arg1,
            content      : arg0,
            link         : arg2,
            timestamp_ms : arg3,
        }
    }

    fun new_stasher(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : Stasher {
        Stasher{
            id          : 0x2::object::new(arg6),
            sid         : arg0,
            name        : arg1,
            image_url   : arg2,
            description : arg3,
            nickname    : arg4,
            twitter     : arg5,
            stashs      : 0x2::vec_set::empty<Stash>(),
        }
    }

    public fun update_stasher(arg0: &mut Stasher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String) {
        arg0.name = arg1;
        arg0.image_url = arg2;
        arg0.description = arg3;
        arg0.nickname = arg4;
        arg0.twitter = arg5;
    }

    // decompiled from Move bytecode v6
}

