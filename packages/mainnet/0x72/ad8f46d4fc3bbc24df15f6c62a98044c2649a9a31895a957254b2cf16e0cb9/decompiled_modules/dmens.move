module 0x72ad8f46d4fc3bbc24df15f6c62a98044c2649a9a31895a957254b2cf16e0cb9::dmens {
    struct Dmens has store, key {
        id: 0x2::object::UID,
        app_id: u8,
        poster: address,
        text: 0x1::option::Option<0x1::string::String>,
        ref_id: 0x1::option::Option<address>,
        action: u8,
        url: 0x2::url::Url,
    }

    struct DmensMeta has key {
        id: 0x2::object::UID,
        next_index: u64,
        follows: 0x2::table::Table<address, address>,
        dmens_table: 0x2::table::Table<u64, Dmens>,
        url: 0x2::url::Url,
    }

    struct Like has store, key {
        id: 0x2::object::UID,
        poster: address,
    }

    struct DMENS has drop {
        dummy_field: bool,
    }

    public entry fun batch_burn_indexes(arg0: &mut DmensMeta, arg1: vector<u64>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            let v1 = 0x1::vector::pop_back<u64>(&mut arg1);
            if (0x2::table::contains<u64, Dmens>(&arg0.dmens_table, v1)) {
                burn_by_object(0x2::table::remove<u64, Dmens>(&mut arg0.dmens_table, v1));
            };
            v0 = v0 + 1;
        };
    }

    public entry fun batch_burn_like(arg0: vector<Like>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Like>(&arg0)) {
            let Like {
                id     : v1,
                poster : _,
            } = 0x1::vector::pop_back<Like>(&mut arg0);
            0x2::object::delete(v1);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<Like>(arg0);
    }

    public entry fun batch_burn_objects(arg0: vector<Dmens>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Dmens>(&arg0)) {
            burn_by_object(0x1::vector::pop_back<Dmens>(&mut arg0));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<Dmens>(arg0);
    }

    public entry fun batch_burn_range(arg0: &mut DmensMeta, arg1: u64, arg2: u64) {
        let v0 = if (arg0.next_index < arg2) {
            arg0.next_index
        } else {
            arg2
        };
        while (arg1 < v0) {
            if (0x2::table::contains<u64, Dmens>(&arg0.dmens_table, arg1)) {
                burn_by_object(0x2::table::remove<u64, Dmens>(&mut arg0.dmens_table, arg1));
            };
            arg1 = arg1 + 1;
        };
    }

    public entry fun batch_place(arg0: &mut DmensMeta, arg1: vector<Dmens>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Dmens>(&arg1)) {
            0x2::table::add<u64, Dmens>(&mut arg0.dmens_table, arg0.next_index, 0x1::vector::pop_back<Dmens>(&mut arg1));
            arg0.next_index = arg0.next_index + 1;
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<Dmens>(arg1);
    }

    public entry fun batch_take(arg0: &mut DmensMeta, arg1: vector<u64>, arg2: address) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            let v1 = 0x1::vector::pop_back<u64>(&mut arg1);
            if (0x2::table::contains<u64, Dmens>(&arg0.dmens_table, v1)) {
                0x2::transfer::transfer<Dmens>(0x2::table::remove<u64, Dmens>(&mut arg0.dmens_table, v1), arg2);
            };
            v0 = v0 + 1;
        };
    }

    public fun burn_by_object(arg0: Dmens) {
        let Dmens {
            id     : v0,
            app_id : _,
            poster : _,
            text   : _,
            ref_id : _,
            action : _,
            url    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun destory_all(arg0: DmensMeta) {
        let v0 = &mut arg0;
        batch_burn_range(v0, 0, arg0.next_index);
        let DmensMeta {
            id          : v1,
            next_index  : _,
            follows     : v3,
            dmens_table : v4,
            url         : _,
        } = arg0;
        0x2::table::destroy_empty<u64, Dmens>(v4);
        0x2::table::drop<address, address>(v3);
        0x2::object::delete(v1);
    }

    public(friend) fun dmens_meta(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DmensMeta{
            id          : 0x2::object::new(arg0),
            next_index  : 0,
            follows     : 0x2::table::new<address, address>(arg0),
            dmens_table : 0x2::table::new<u64, Dmens>(arg0),
            url         : 0x2::url::new_unsafe_from_bytes(b"ipfs://bafkreibat54rwwfuxm377yj5vlhjhyj7cbzex2tdhktxmom6rdco54up5a"),
        };
        0x2::transfer::transfer<DmensMeta>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun follow(arg0: &mut DmensMeta, arg1: vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg1);
            0x2::table::add<address, address>(&mut arg0.follows, v1, v1);
            v0 = v0 + 1;
        };
    }

    fun init(arg0: DMENS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Dmens Action"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Dmens Meta"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{url}"));
        let v6 = 0x2::package::claim<DMENS>(arg0, arg1);
        let v7 = 0x2::display::new_with_fields<Dmens>(&v6, v0, v2, arg1);
        0x2::display::update_version<Dmens>(&mut v7);
        let v8 = 0x2::display::new_with_fields<DmensMeta>(&v6, v0, v4, arg1);
        0x2::display::update_version<DmensMeta>(&mut v8);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Dmens>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<DmensMeta>>(v8, 0x2::tx_context::sender(arg1));
    }

    public entry fun like(arg0: &mut DmensMeta, arg1: u8, arg2: vector<u8>, arg3: address, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) == 0 && arg3 != 0x2::tx_context::sender(arg5), 4);
        like_internal(arg0, arg1, 0x1::option::some<address>(arg3), arg4, arg5);
    }

    fun like_internal(arg0: &mut DmensMeta, arg1: u8, arg2: 0x1::option::Option<address>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg2), 2);
        let v0 = Dmens{
            id     : 0x2::object::new(arg4),
            app_id : arg1,
            poster : 0x2::tx_context::sender(arg4),
            text   : 0x1::option::none<0x1::string::String>(),
            ref_id : arg2,
            action : 4,
            url    : 0x2::url::new_unsafe_from_bytes(b"ipfs://bafkreibat54rwwfuxm377yj5vlhjhyj7cbzex2tdhktxmom6rdco54up5a"),
        };
        let v1 = Like{
            id     : 0x2::object::new(arg4),
            poster : 0x2::tx_context::sender(arg4),
        };
        0x2::transfer::public_transfer<Like>(v1, arg3);
        0x2::table::add<u64, Dmens>(&mut arg0.dmens_table, arg0.next_index, v0);
        arg0.next_index = arg0.next_index + 1;
    }

    public fun meta_count_and_next(arg0: &DmensMeta) : (u64, u64) {
        (0x2::table::length<u64, Dmens>(&arg0.dmens_table), arg0.next_index)
    }

    public fun meta_follows(arg0: &DmensMeta) : u64 {
        0x2::table::length<address, address>(&arg0.follows)
    }

    public fun meta_has_dmens(arg0: &DmensMeta, arg1: u64) : bool {
        0x2::table::contains<u64, Dmens>(&arg0.dmens_table, arg1)
    }

    public fun meta_is_following(arg0: &DmensMeta, arg1: address) : bool {
        0x2::table::contains<address, address>(&arg0.follows, arg1)
    }

    public fun parse_dmens(arg0: &Dmens) : (u8, address, 0x1::option::Option<0x1::string::String>, 0x1::option::Option<address>, u8) {
        (arg0.app_id, arg0.poster, arg0.text, arg0.ref_id, arg0.action)
    }

    public fun parse_like(arg0: &Like) : address {
        arg0.poster
    }

    public entry fun post(arg0: &mut DmensMeta, arg1: u8, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) > 0, 4);
        post_internal(arg0, arg1, arg2, arg3);
    }

    fun post_internal(arg0: &mut DmensMeta, arg1: u8, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) <= 10000, 1);
        let v0 = Dmens{
            id     : 0x2::object::new(arg3),
            app_id : arg1,
            poster : 0x2::tx_context::sender(arg3),
            text   : 0x1::option::some<0x1::string::String>(0x1::string::utf8(arg2)),
            ref_id : 0x1::option::none<address>(),
            action : 0,
            url    : 0x2::url::new_unsafe_from_bytes(b"ipfs://bafkreibat54rwwfuxm377yj5vlhjhyj7cbzex2tdhktxmom6rdco54up5a"),
        };
        0x2::table::add<u64, Dmens>(&mut arg0.dmens_table, arg0.next_index, v0);
        arg0.next_index = arg0.next_index + 1;
    }

    public entry fun post_with_ref(arg0: &mut DmensMeta, arg1: u8, arg2: u8, arg3: vector<u8>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 1) {
            assert!(0x1::vector::length<u8>(&arg3) == 0 && arg4 != 0x2::tx_context::sender(arg5), 4);
            repost_internal(arg0, arg1, 0x1::option::some<address>(arg4), arg5);
        } else if (arg2 == 2) {
            assert!(0x1::vector::length<u8>(&arg3) > 0 && arg4 != 0x2::tx_context::sender(arg5), 4);
            quote_post_internal(arg0, arg1, arg3, 0x1::option::some<address>(arg4), arg5);
        } else {
            assert!(arg2 == 3, 3);
            assert!(0x1::vector::length<u8>(&arg3) > 0 && arg4 != 0x2::tx_context::sender(arg5), 4);
            reply_internal(arg0, arg1, arg3, 0x1::option::some<address>(arg4), arg5);
        };
    }

    fun quote_post_internal(arg0: &mut DmensMeta, arg1: u8, arg2: vector<u8>, arg3: 0x1::option::Option<address>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) <= 10000, 1);
        assert!(0x1::option::is_some<address>(&arg3), 2);
        let v0 = Dmens{
            id     : 0x2::object::new(arg4),
            app_id : arg1,
            poster : 0x2::tx_context::sender(arg4),
            text   : 0x1::option::some<0x1::string::String>(0x1::string::utf8(arg2)),
            ref_id : arg3,
            action : 2,
            url    : 0x2::url::new_unsafe_from_bytes(b"ipfs://bafkreibat54rwwfuxm377yj5vlhjhyj7cbzex2tdhktxmom6rdco54up5a"),
        };
        0x2::table::add<u64, Dmens>(&mut arg0.dmens_table, arg0.next_index, v0);
        arg0.next_index = arg0.next_index + 1;
    }

    fun reply_internal(arg0: &mut DmensMeta, arg1: u8, arg2: vector<u8>, arg3: 0x1::option::Option<address>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) <= 10000, 1);
        assert!(0x1::option::is_some<address>(&arg3), 2);
        let v0 = Dmens{
            id     : 0x2::object::new(arg4),
            app_id : arg1,
            poster : 0x2::tx_context::sender(arg4),
            text   : 0x1::option::some<0x1::string::String>(0x1::string::utf8(arg2)),
            ref_id : arg3,
            action : 3,
            url    : 0x2::url::new_unsafe_from_bytes(b"ipfs://bafkreibat54rwwfuxm377yj5vlhjhyj7cbzex2tdhktxmom6rdco54up5a"),
        };
        0x2::table::add<u64, Dmens>(&mut arg0.dmens_table, arg0.next_index, v0);
        arg0.next_index = arg0.next_index + 1;
    }

    fun repost_internal(arg0: &mut DmensMeta, arg1: u8, arg2: 0x1::option::Option<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg2), 2);
        let v0 = Dmens{
            id     : 0x2::object::new(arg3),
            app_id : arg1,
            poster : 0x2::tx_context::sender(arg3),
            text   : 0x1::option::none<0x1::string::String>(),
            ref_id : arg2,
            action : 1,
            url    : 0x2::url::new_unsafe_from_bytes(b"ipfs://bafkreibat54rwwfuxm377yj5vlhjhyj7cbzex2tdhktxmom6rdco54up5a"),
        };
        0x2::table::add<u64, Dmens>(&mut arg0.dmens_table, arg0.next_index, v0);
        arg0.next_index = arg0.next_index + 1;
    }

    public entry fun unfollow(arg0: &mut DmensMeta, arg1: vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg1);
            if (0x2::table::contains<address, address>(&arg0.follows, v1)) {
                0x2::table::remove<address, address>(&mut arg0.follows, v1);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

