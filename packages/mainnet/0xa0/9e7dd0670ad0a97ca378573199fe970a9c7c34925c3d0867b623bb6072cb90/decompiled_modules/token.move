module 0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    struct Token has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        preview_image: 0x2::url::Url,
        uri_path: 0x1::string::String,
        edition_number: u16,
        moment: 0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::moment::Moment,
    }

    struct TokenMinted has copy, drop {
        object_id: 0x2::object::ID,
        token_uri: 0x1::string::String,
        creator: address,
    }

    struct TokenBurned has copy, drop {
        object_id: 0x2::object::ID,
        token_uri: 0x1::string::String,
        burner: address,
    }

    public fun moment(arg0: &Token) : &0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::moment::Moment {
        &arg0.moment
    }

    public fun burn(arg0: Token, arg1: &0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::caps::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        burn_impl(arg0, arg2);
    }

    fun burn_impl(arg0: Token, arg1: &0x2::tx_context::TxContext) {
        let Token {
            id             : v0,
            name           : _,
            description    : _,
            preview_image  : _,
            uri_path       : _,
            edition_number : _,
            moment         : _,
        } = arg0;
        let v7 = TokenBurned{
            object_id : 0x2::object::id<Token>(&arg0),
            token_uri : get_full_uri(&arg0),
            burner    : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<TokenBurned>(v7);
        0x2::object::delete(v0);
    }

    public fun description(arg0: &Token) : 0x1::string::String {
        arg0.description
    }

    public fun edition_number(arg0: &Token) : u16 {
        arg0.edition_number
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
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"edition_number"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"series"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"set"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"rarity"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"team"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"player"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"date"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"play"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"video_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"audio_type"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v6, v0);
        0x1::vector::push_back<0x1::string::String>(v6, v2);
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{preview_image}"));
        0x1::vector::push_back<0x1::string::String>(v6, v1);
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{edition_number}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(arg3));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{moment.set}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{moment.rarity}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{moment.team}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{moment.player}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{moment.date}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{moment.play}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{moment.video}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{moment.audio_type}"));
        (v3, v5)
    }

    fun get_full_uri(arg0: &Token) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"https://nft.mlsquest.com");
        0x1::string::append(&mut v0, arg0.uri_path);
        v0
    }

    public fun get_mut_moment(arg0: &mut Token, arg1: &0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::caps::AdminCap) : &mut 0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::moment::Moment {
        &mut arg0.moment
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TOKEN>(arg0, arg1);
        let (v1, v2) = get_display_template_fields(b"", b"", b"", b"");
        let (v3, v4) = 0x2::transfer_policy::new<Token>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Token>>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Token>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Token>>(0x2::display::new_with_fields<Token>(&v0, v1, v2, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: vector<vector<u8>>, arg1: vector<u16>, arg2: &0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::caps::MinterCap, arg3: &mut 0x2::tx_context::TxContext) : Token {
        assert!(*0x1::vector::borrow<u16>(&arg1, 0) > 0, 513);
        mint_impl(*0x1::vector::borrow<vector<u8>>(&arg0, 0), *0x1::vector::borrow<vector<u8>>(&arg0, 1), *0x1::vector::borrow<vector<u8>>(&arg0, 2), *0x1::vector::borrow<vector<u8>>(&arg0, 3), *0x1::vector::borrow<u16>(&arg1, 0), 0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::moment::new_moment(*0x1::vector::borrow<vector<u8>>(&arg0, 12), *0x1::vector::borrow<vector<u8>>(&arg0, 13), *0x1::vector::borrow<vector<u8>>(&arg0, 4), *0x1::vector::borrow<vector<u8>>(&arg0, 5), *0x1::vector::borrow<vector<u8>>(&arg0, 6), *0x1::vector::borrow<vector<u8>>(&arg0, 7), *0x1::vector::borrow<vector<u8>>(&arg0, 8), *0x1::vector::borrow<vector<u8>>(&arg0, 9), *0x1::vector::borrow<vector<u8>>(&arg0, 10), *0x1::vector::borrow<vector<u8>>(&arg0, 11), *0x1::vector::borrow<u16>(&arg1, 1)), arg3)
    }

    fun mint_impl(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u16, arg5: 0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::moment::Moment, arg6: &mut 0x2::tx_context::TxContext) : Token {
        let v0 = Token{
            id             : 0x2::object::new(arg6),
            name           : 0x1::string::utf8(arg0),
            description    : 0x1::string::utf8(arg1),
            preview_image  : 0x2::url::new_unsafe_from_bytes(arg2),
            uri_path       : 0x1::string::utf8(arg3),
            edition_number : arg4,
            moment         : arg5,
        };
        let v1 = TokenMinted{
            object_id : 0x2::object::id<Token>(&v0),
            token_uri : get_full_uri(&v0),
            creator   : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<TokenMinted>(v1);
        v0
    }

    public fun name(arg0: &Token) : 0x1::string::String {
        arg0.name
    }

    public fun preview_image(arg0: &Token) : 0x1::string::String {
        0x1::string::from_ascii(0x2::url::inner_url(&arg0.preview_image))
    }

    public fun set_display_template(arg0: &mut 0x2::display::Display<Token>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) {
        let (v0, v1) = get_display_template_fields(arg1, arg2, arg3, arg4);
        set_display_template_impl(arg0, v0, v1);
    }

    fun set_display_template_impl(arg0: &mut 0x2::display::Display<Token>, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>) {
        let v0 = 0x2::vec_map::keys<0x1::string::String, 0x1::string::String>(0x2::display::fields<Token>(arg0));
        let v1 = 0x1::vector::length<0x1::string::String>(&v0);
        while (v1 > 0) {
            0x2::display::remove<Token>(arg0, *0x1::vector::borrow<0x1::string::String>(&arg1, v1 - 1));
            v1 = v1 - 1;
        };
        0x2::display::add_multiple<Token>(arg0, arg1, arg2);
        0x2::display::update_version<Token>(arg0);
    }

    public fun update_description(arg0: &mut Token, arg1: vector<u8>, arg2: &0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::caps::AdminCap) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    public fun update_edition_number(arg0: &mut Token, arg1: u16, arg2: &0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::caps::AdminCap) {
        arg0.edition_number = arg1;
    }

    public fun update_name(arg0: &mut Token, arg1: vector<u8>, arg2: &0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::caps::AdminCap) {
        arg0.name = 0x1::string::utf8(arg1);
    }

    public fun update_preview_image(arg0: &mut Token, arg1: vector<u8>, arg2: &0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::caps::AdminCap) {
        arg0.preview_image = 0x2::url::new_unsafe_from_bytes(arg1);
    }

    public fun uri(arg0: &Token) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"https://nft.mlsquest.com");
        0x1::string::append(&mut v0, arg0.uri_path);
        v0
    }

    // decompiled from Move bytecode v6
}

