module 0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::pack {
    struct PACK has drop {
        dummy_field: bool,
    }

    struct TokenList has drop, store {
        tokens: vector<u16>,
    }

    struct PackTokenPool has store, key {
        id: 0x2::object::UID,
        group_count: u8,
        token_counters: vector<u16>,
        opening_enabled: bool,
        version: u64,
    }

    struct Pack has store, key {
        id: 0x2::object::UID,
        pack_token_pool_id: 0x2::object::ID,
        edition_number: u16,
        total_editions: u16,
        uri_path: 0x1::string::String,
        name: 0x1::string::String,
        preview_image: 0x2::url::Url,
        description: 0x1::string::String,
        rarity: 0x1::string::String,
        set: 0x1::string::String,
    }

    struct PackTokenPoolCreated has copy, drop {
        object_id: 0x2::object::ID,
    }

    struct PackOpened has copy, drop {
        object_id: 0x2::object::ID,
        uri: 0x1::string::String,
        opener: address,
        tokens: vector<0x2::object::ID>,
    }

    struct PackBurned has copy, drop {
        object_id: 0x2::object::ID,
        uri: 0x1::string::String,
        burner: address,
    }

    struct PackMinted has copy, drop {
        object_id: 0x2::object::ID,
        uri: 0x1::string::String,
        creator: address,
    }

    fun build_token_dynamic_field_name(arg0: u8, arg1: u16) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"t");
        0x1::string::append(&mut v0, 0x1::u32::to_string((arg0 as u32) << 16 | (arg1 as u32)));
        v0
    }

    fun build_tokenlist_dynamic_field_name(arg0: u8) : 0x1::string::String {
        assert!(arg0 < 16, 775);
        let v0 = 0x1::string::utf8(b"g");
        0x1::string::append(&mut v0, 0x1::u8::to_string(arg0));
        v0
    }

    public fun burn(arg0: Pack, arg1: &0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::caps::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PackBurned{
            object_id : 0x2::object::id<Pack>(&arg0),
            uri       : get_full_uri(&arg0),
            burner    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PackBurned>(v0);
        let Pack {
            id                 : v1,
            pack_token_pool_id : _,
            edition_number     : _,
            total_editions     : _,
            uri_path           : _,
            name               : _,
            preview_image      : _,
            description        : _,
            rarity             : _,
            set                : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public fun description(arg0: &Pack) : &0x1::string::String {
        &arg0.description
    }

    public fun edition_number(arg0: &Pack) : &u16 {
        &arg0.edition_number
    }

    fun get_display_template_fields(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : (vector<0x1::string::String>, vector<0x1::string::String>) {
        let v0 = 0x1::string::utf8(x"7b6465736372697074696f6e7d0a");
        0x1::string::append(&mut v0, 0x1::string::utf8(arg2));
        let v1 = 0x1::string::utf8(arg0);
        0x1::string::append(&mut v1, 0x1::string::utf8(b"{uri_path}"));
        let v2 = 0x1::string::utf8(arg1);
        0x1::string::append(&mut v2, 0x1::string::utf8(b"{uri_path}"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"rarity"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"set"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"edition_number"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"series"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v6, v0);
        0x1::vector::push_back<0x1::string::String>(v6, v2);
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{preview_image}"));
        0x1::vector::push_back<0x1::string::String>(v6, v1);
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{rarity}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{set}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{edition_number}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(arg3));
        (v3, v5)
    }

    fun get_full_uri(arg0: &Pack) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"https://nft.mlsquest.com");
        0x1::string::append(&mut v0, arg0.uri_path);
        v0
    }

    public fun increment_version(arg0: &mut PackTokenPool, arg1: &0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::caps::PackerCap) {
        assert!(arg0.version < 0, 780);
        arg0.version = arg0.version + 1;
    }

    fun init(arg0: PACK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PACK>(arg0, arg1);
        let (v1, v2) = get_display_template_fields(b"", b"", b"", b"");
        let (v3, v4) = 0x2::transfer_policy::new<Pack>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Pack>>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Pack>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Pack>>(0x2::display::new_with_fields<Pack>(&v0, v1, v2, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: 0x2::object::ID, arg1: vector<vector<u8>>, arg2: vector<u16>, arg3: &0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::caps::PackMinterCap, arg4: &mut 0x2::tx_context::TxContext) : Pack {
        assert!(0x1::vector::length<vector<u8>>(&arg1) == 6, 777);
        assert!(0x1::vector::length<u16>(&arg2) == 2, 778);
        let v0 = Pack{
            id                 : 0x2::object::new(arg4),
            pack_token_pool_id : arg0,
            edition_number     : *0x1::vector::borrow<u16>(&arg2, 0),
            total_editions     : *0x1::vector::borrow<u16>(&arg2, 1),
            uri_path           : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg1, 0)),
            name               : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg1, 1)),
            preview_image      : 0x2::url::new_unsafe_from_bytes(*0x1::vector::borrow<vector<u8>>(&arg1, 2)),
            description        : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg1, 3)),
            rarity             : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg1, 4)),
            set                : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg1, 5)),
        };
        let v1 = PackMinted{
            object_id : 0x2::object::id<Pack>(&v0),
            uri       : get_full_uri(&v0),
            creator   : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<PackMinted>(v1);
        v0
    }

    public fun name(arg0: &Pack) : &0x1::string::String {
        &arg0.name
    }

    public fun new_pack_token_pool(arg0: u8, arg1: &0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::caps::PackerCap, arg2: &mut 0x2::tx_context::TxContext) : 0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::uniqueidset::UniqueIdSet {
        assert!(arg0 < 16, 771);
        assert!(arg0 > 0, 781);
        let v0 = PackTokenPool{
            id              : 0x2::object::new(arg2),
            group_count     : arg0,
            token_counters  : 0x1::vector::empty<u16>(),
            opening_enabled : false,
            version         : 0,
        };
        let v1 = 0;
        while (v1 < arg0) {
            let v2 = TokenList{tokens: 0x1::vector::empty<u16>()};
            0x2::dynamic_field::add<0x1::string::String, TokenList>(&mut v0.id, build_tokenlist_dynamic_field_name(v1), v2);
            v1 = v1 + 1;
            0x1::vector::push_back<u16>(&mut v0.token_counters, 0);
        };
        let v3 = PackTokenPoolCreated{object_id: 0x2::object::id<PackTokenPool>(&v0)};
        0x2::event::emit<PackTokenPoolCreated>(v3);
        0x2::transfer::share_object<PackTokenPool>(v0);
        0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::uniqueidset::new_set(arg2)
    }

    entry fun open_pack(arg0: &mut PackTokenPool, arg1: Pack, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 780);
        assert!(arg0.opening_enabled, 779);
        assert!(arg1.pack_token_pool_id == 0x2::object::id<PackTokenPool>(arg0), 770);
        let v0 = 0;
        let v1 = 0x2::random::new_generator(arg2, arg3);
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        while (v0 < arg0.group_count) {
            let v3 = &mut v1;
            let v4 = withdraw_random_token_from_group(arg0, v0, v3);
            0x1::vector::push_back<0x2::object::ID>(&mut v2, 0x2::object::id<0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::token::Token>(&v4));
            0x2::transfer::public_transfer<0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::token::Token>(v4, 0x2::tx_context::sender(arg3));
            v0 = v0 + 1;
        };
        let v5 = PackOpened{
            object_id : 0x2::object::id<Pack>(&arg1),
            uri       : get_full_uri(&arg1),
            opener    : 0x2::tx_context::sender(arg3),
            tokens    : v2,
        };
        0x2::event::emit<PackOpened>(v5);
        let Pack {
            id                 : v6,
            pack_token_pool_id : _,
            edition_number     : _,
            total_editions     : _,
            uri_path           : _,
            name               : _,
            preview_image      : _,
            description        : _,
            rarity             : _,
            set                : _,
        } = arg1;
        0x2::object::delete(v6);
    }

    public fun pool_open(arg0: &PackTokenPool) : bool {
        arg0.opening_enabled
    }

    public fun preview_image(arg0: &Pack) : 0x1::string::String {
        0x1::string::from_ascii(0x2::url::inner_url(&arg0.preview_image))
    }

    public fun rarity(arg0: &Pack) : 0x1::string::String {
        arg0.rarity
    }

    public fun receive_object_for_pool(arg0: &mut PackTokenPool, arg1: 0x2::transfer::Receiving<0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::token::Token>, arg2: u8, arg3: &0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::caps::PackerCap) {
        assert!(arg0.version == 0, 780);
        assert!(arg0.opening_enabled == false, 779);
        assert!(arg2 < arg0.group_count, 775);
        let v0 = 0x1::vector::borrow_mut<u16>(&mut arg0.token_counters, (arg2 as u64));
        *v0 = *v0 + 1;
        0x2::dynamic_object_field::add<0x1::string::String, 0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::token::Token>(&mut arg0.id, build_token_dynamic_field_name(arg2, *v0), 0x2::transfer::public_receive<0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::token::Token>(&mut arg0.id, arg1));
        0x1::vector::push_back<u16>(&mut 0x2::dynamic_field::borrow_mut<0x1::string::String, TokenList>(&mut arg0.id, build_tokenlist_dynamic_field_name(arg2)).tokens, *v0);
    }

    public fun set(arg0: &Pack) : 0x1::string::String {
        arg0.set
    }

    public fun set_display_template(arg0: &mut 0x2::display::Display<Pack>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = get_display_template_fields(arg1, arg2, arg3, arg4);
        set_display_template_impl(arg0, v0, v1);
    }

    fun set_display_template_impl(arg0: &mut 0x2::display::Display<Pack>, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>) {
        let v0 = 0x2::vec_map::keys<0x1::string::String, 0x1::string::String>(0x2::display::fields<Pack>(arg0));
        let v1 = 0x1::vector::length<0x1::string::String>(&v0);
        while (v1 > 0) {
            0x2::display::remove<Pack>(arg0, *0x1::vector::borrow<0x1::string::String>(&arg1, v1 - 1));
            v1 = v1 - 1;
        };
        0x2::display::add_multiple<Pack>(arg0, arg1, arg2);
        0x2::display::update_version<Pack>(arg0);
    }

    public fun set_pool_open(arg0: &mut PackTokenPool, arg1: bool, arg2: &0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::caps::PackerCap) {
        assert!(arg0.version == 0, 780);
        assert!(arg0.opening_enabled != arg1, 779);
        if (arg0.group_count > 1 && !arg0.opening_enabled) {
            let v0 = sizes(arg0);
            let v1 = 1;
            while (v1 < arg0.group_count) {
                assert!(*0x1::vector::borrow<u64>(&v0, (v1 as u64)) == *0x1::vector::borrow<u64>(&v0, 0), 779);
                v1 = v1 + 1;
            };
        };
        arg0.opening_enabled = arg1;
    }

    public fun sizes(arg0: &PackTokenPool) : vector<u64> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u64>();
        while (v0 < arg0.group_count) {
            0x1::vector::push_back<u64>(&mut v1, 0x1::vector::length<u16>(&0x2::dynamic_field::borrow<0x1::string::String, TokenList>(&arg0.id, build_tokenlist_dynamic_field_name(v0)).tokens));
            v0 = v0 + 1;
        };
        v1
    }

    public fun total_editions(arg0: &Pack) : &u16 {
        &arg0.total_editions
    }

    public fun update_description(arg0: &mut Pack, arg1: vector<u8>, arg2: &0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::caps::AdminCap) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    public fun update_edition_number(arg0: &mut Pack, arg1: u16, arg2: &0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::caps::AdminCap) {
        arg0.edition_number = arg1;
    }

    public fun update_name(arg0: &mut Pack, arg1: vector<u8>, arg2: &0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::caps::AdminCap) {
        arg0.name = 0x1::string::utf8(arg1);
    }

    public fun update_preview_image(arg0: &mut Pack, arg1: vector<u8>, arg2: &0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::caps::AdminCap) {
        arg0.preview_image = 0x2::url::new_unsafe_from_bytes(arg1);
    }

    public fun update_rarity(arg0: &mut Pack, arg1: vector<u8>, arg2: &0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::caps::AdminCap) {
        arg0.rarity = 0x1::string::utf8(arg1);
    }

    public fun update_set(arg0: &mut Pack, arg1: vector<u8>, arg2: &0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::caps::AdminCap) {
        arg0.set = 0x1::string::utf8(arg1);
    }

    public fun update_total_editions(arg0: &mut Pack, arg1: u16, arg2: &0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::caps::AdminCap) {
        arg0.total_editions = arg1;
    }

    public fun update_uri(arg0: &mut Pack, arg1: vector<u8>, arg2: &0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::caps::AdminCap) {
        arg0.uri_path = 0x1::string::utf8(arg1);
    }

    public fun uri(arg0: &Pack) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"https://nft.mlsquest.com");
        0x1::string::append(&mut v0, arg0.uri_path);
        v0
    }

    fun withdraw_random_token_from_group(arg0: &mut PackTokenPool, arg1: u8, arg2: &mut 0x2::random::RandomGenerator) : 0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::token::Token {
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, TokenList>(&mut arg0.id, build_tokenlist_dynamic_field_name(arg1));
        let v1 = 0x1::vector::length<u16>(&v0.tokens);
        assert!(v1 > 0, 776);
        let v2 = 0x2::random::generate_u64_in_range(arg2, 0, v1);
        let v3 = if (v2 == 0x1::vector::length<u16>(&v0.tokens)) {
            0x1::vector::pop_back<u16>(&mut v0.tokens)
        } else {
            0x1::vector::swap_remove<u16>(&mut v0.tokens, v2)
        };
        0x2::dynamic_object_field::remove<0x1::string::String, 0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::token::Token>(&mut arg0.id, build_token_dynamic_field_name(arg1, v3))
    }

    entry fun withdraw_token(arg0: &mut PackTokenPool, arg1: u8, arg2: &0x2::random::Random, arg3: &0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::caps::PackerCap, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 780);
        assert!(arg0.opening_enabled == false, 779);
        assert!(arg1 < arg0.group_count, 775);
        let v0 = 0x2::random::new_generator(arg2, arg4);
        let v1 = &mut v0;
        0x2::transfer::public_transfer<0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::token::Token>(withdraw_random_token_from_group(arg0, arg1, v1), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

