module 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::token_v2 {
    struct TOKEN_V2 has drop {
        dummy_field: bool,
    }

    struct SweetToken has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        uri: 0x2::url::Url,
        edition_number: u32,
    }

    struct TokenMinted has copy, drop {
        object_id: 0x2::object::ID,
        token_uri: 0x2::url::Url,
        creator: address,
    }

    struct TokenBurned has copy, drop {
        object_id: 0x2::object::ID,
        token_uri: 0x2::url::Url,
        burner: address,
    }

    public fun burn(arg0: SweetToken, arg1: &mut 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::Register, arg2: &mut 0x2::tx_context::TxContext) {
        0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::check_minter(arg1, arg2);
        burn_impl(arg0, arg2);
    }

    fun burn_impl(arg0: SweetToken, arg1: &0x2::tx_context::TxContext) {
        let SweetToken {
            id             : v0,
            name           : _,
            uri            : v2,
            edition_number : _,
        } = arg0;
        let v4 = TokenBurned{
            object_id : 0x2::object::id<SweetToken>(&arg0),
            token_uri : v2,
            burner    : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<TokenBurned>(v4);
        0x2::object::delete(v0);
    }

    public fun edition_number(arg0: &SweetToken) : &u32 {
        &arg0.edition_number
    }

    fun init(arg0: TOKEN_V2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TOKEN_V2>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SweetToken>>(0x2::display::new<SweetToken>(&v0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: u32, arg3: &mut 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::Register, arg4: &mut 0x2::tx_context::TxContext) : SweetToken {
        0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::check_minter(arg3, arg4);
        0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::check_frozen(arg3, arg4);
        assert!(arg2 > 0, 1);
        mint_impl(arg0, arg1, arg2, arg4)
    }

    fun mint_impl(arg0: vector<u8>, arg1: vector<u8>, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) : SweetToken {
        let v0 = SweetToken{
            id             : 0x2::object::new(arg3),
            name           : 0x1::string::utf8(arg0),
            uri            : 0x2::url::new_unsafe_from_bytes(arg1),
            edition_number : arg2,
        };
        let v1 = TokenMinted{
            object_id : 0x2::object::id<SweetToken>(&v0),
            token_uri : v0.uri,
            creator   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<TokenMinted>(v1);
        v0
    }

    public fun name(arg0: &SweetToken) : 0x1::string::String {
        arg0.name
    }

    public fun set_display_template(arg0: &mut 0x2::display::Display<SweetToken>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::moment::Moment, arg5: &mut 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::Register, arg6: &mut 0x2::tx_context::TxContext) {
        0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::check_minter(arg5, arg6);
        set_display_template_impl(arg0, arg1, arg2, arg3, arg4);
    }

    fun set_display_template_impl(arg0: &mut 0x2::display::Display<SweetToken>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::moment::Moment) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"edition_number"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"series"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"set"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"rarity"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"team"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"player"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"date"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"play"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"video_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"audio_type"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(arg1));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{uri}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(arg2));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(arg3));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{edition_number}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::moment::series(arg4));
        0x1::vector::push_back<0x1::string::String>(v3, 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::moment::set(arg4));
        0x1::vector::push_back<0x1::string::String>(v3, 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::moment::rarity(arg4));
        0x1::vector::push_back<0x1::string::String>(v3, 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::moment::team(arg4));
        0x1::vector::push_back<0x1::string::String>(v3, 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::moment::player(arg4));
        0x1::vector::push_back<0x1::string::String>(v3, 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::moment::date(arg4));
        0x1::vector::push_back<0x1::string::String>(v3, 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::moment::play(arg4));
        0x1::vector::push_back<0x1::string::String>(v3, 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::moment::video(arg4));
        0x1::vector::push_back<0x1::string::String>(v3, 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::moment::audio_type(arg4));
        let v4 = 0x2::vec_map::keys<0x1::string::String, 0x1::string::String>(0x2::display::fields<SweetToken>(arg0));
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x1::string::String>(&v4)) {
            0x2::display::remove<SweetToken>(arg0, *0x1::vector::borrow<0x1::string::String>(&v4, v5));
            v5 = v5 + 1;
        };
        0x2::display::add_multiple<SweetToken>(arg0, v0, v2);
        0x2::display::update_version<SweetToken>(arg0);
    }

    public fun update_edition_number(arg0: &mut SweetToken, arg1: u32, arg2: &mut 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::Register, arg3: &mut 0x2::tx_context::TxContext) {
        0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::check_minter(arg2, arg3);
        0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::check_frozen(arg2, arg3);
        arg0.edition_number = arg1;
    }

    public fun update_name(arg0: &mut SweetToken, arg1: vector<u8>, arg2: &mut 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::Register, arg3: &mut 0x2::tx_context::TxContext) {
        0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::check_minter(arg2, arg3);
        0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::check_frozen(arg2, arg3);
        arg0.name = 0x1::string::utf8(arg1);
    }

    public fun update_uri(arg0: &mut SweetToken, arg1: vector<u8>, arg2: &mut 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::Register, arg3: &mut 0x2::tx_context::TxContext) {
        0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::check_minter(arg2, arg3);
        0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::check_frozen(arg2, arg3);
        arg0.uri = 0x2::url::new_unsafe_from_bytes(arg1);
    }

    public fun uri(arg0: &SweetToken) : 0x1::string::String {
        0x1::string::from_ascii(0x2::url::inner_url(&arg0.uri))
    }

    // decompiled from Move bytecode v6
}

