module 0x45690211f9818c3354ddc1434c35e5543cc0df80dd3b5b8041fd8d4de2d34df6::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    struct Token has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        preview_image: 0x2::url::Url,
        uri: 0x2::url::Url,
        edition_number: u32,
        moment: 0x45690211f9818c3354ddc1434c35e5543cc0df80dd3b5b8041fd8d4de2d34df6::moment::Moment,
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

    public fun moment(arg0: &Token) : &0x45690211f9818c3354ddc1434c35e5543cc0df80dd3b5b8041fd8d4de2d34df6::moment::Moment {
        &arg0.moment
    }

    public fun burn(arg0: Token, arg1: &mut 0x45690211f9818c3354ddc1434c35e5543cc0df80dd3b5b8041fd8d4de2d34df6::register::Register, arg2: &mut 0x2::tx_context::TxContext) {
        0x45690211f9818c3354ddc1434c35e5543cc0df80dd3b5b8041fd8d4de2d34df6::register::check_minter(arg1, arg2);
        burn_impl(arg0, arg2);
    }

    fun burn_impl(arg0: Token, arg1: &0x2::tx_context::TxContext) {
        let Token {
            id             : v0,
            name           : _,
            description    : _,
            preview_image  : _,
            uri            : v4,
            edition_number : _,
            moment         : _,
        } = arg0;
        let v7 = TokenBurned{
            object_id : 0x2::object::id<Token>(&arg0),
            token_uri : v4,
            burner    : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<TokenBurned>(v7);
        0x2::object::delete(v0);
    }

    public fun description(arg0: &Token) : &0x1::string::String {
        &arg0.description
    }

    public fun edition_number(arg0: &Token) : &u32 {
        &arg0.edition_number
    }

    fun get_display_template_fields(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : (vector<0x1::string::String>, vector<0x1::string::String>) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{uri}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{preview_image}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(arg0));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{edition_number}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(arg1));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(arg2));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(arg3));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{moment.team}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{moment.player}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{moment.date}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{moment.play}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{moment.video}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{moment.audio_type}"));
        (v0, v2)
    }

    public fun get_mut_moment(arg0: &mut Token, arg1: &mut 0x45690211f9818c3354ddc1434c35e5543cc0df80dd3b5b8041fd8d4de2d34df6::register::Register, arg2: &mut 0x2::tx_context::TxContext) : &mut 0x45690211f9818c3354ddc1434c35e5543cc0df80dd3b5b8041fd8d4de2d34df6::moment::Moment {
        0x45690211f9818c3354ddc1434c35e5543cc0df80dd3b5b8041fd8d4de2d34df6::register::check_minter(arg1, arg2);
        0x45690211f9818c3354ddc1434c35e5543cc0df80dd3b5b8041fd8d4de2d34df6::register::check_frozen(arg1, arg2);
        &mut arg0.moment
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TOKEN>(arg0, arg1);
        let (v1, v2) = get_display_template_fields(b"https://collectible.io", b"Default Series", b"Default Set", b"Default Rarity");
        let (v3, v4) = 0x2::transfer_policy::new<Token>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Token>>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Token>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Token>>(0x2::display::new_with_fields<Token>(&v0, v1, v2, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: u32, arg13: u32, arg14: &mut 0x45690211f9818c3354ddc1434c35e5543cc0df80dd3b5b8041fd8d4de2d34df6::register::Register, arg15: &mut 0x2::tx_context::TxContext) : Token {
        assert!(arg12 > 0, 513);
        0x45690211f9818c3354ddc1434c35e5543cc0df80dd3b5b8041fd8d4de2d34df6::register::register_token_uri(arg14, arg3, arg15);
        mint_impl(arg0, arg1, arg2, arg3, arg12, 0x45690211f9818c3354ddc1434c35e5543cc0df80dd3b5b8041fd8d4de2d34df6::moment::new_moment(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg13), arg15)
    }

    fun mint_impl(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u32, arg5: 0x45690211f9818c3354ddc1434c35e5543cc0df80dd3b5b8041fd8d4de2d34df6::moment::Moment, arg6: &mut 0x2::tx_context::TxContext) : Token {
        let v0 = Token{
            id             : 0x2::object::new(arg6),
            name           : 0x1::string::utf8(arg0),
            description    : 0x1::string::utf8(arg1),
            preview_image  : 0x2::url::new_unsafe_from_bytes(arg2),
            uri            : 0x2::url::new_unsafe_from_bytes(arg3),
            edition_number : arg4,
            moment         : arg5,
        };
        let v1 = TokenMinted{
            object_id : 0x2::object::id<Token>(&v0),
            token_uri : v0.uri,
            creator   : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<TokenMinted>(v1);
        v0
    }

    public fun name(arg0: &Token) : &0x1::string::String {
        &arg0.name
    }

    public fun preview_image(arg0: &Token) : 0x1::string::String {
        0x1::string::from_ascii(0x2::url::inner_url(&arg0.preview_image))
    }

    public fun set_display_template(arg0: &mut 0x2::display::Display<Token>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
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

    public fun update_description(arg0: &mut Token, arg1: vector<u8>, arg2: &mut 0x45690211f9818c3354ddc1434c35e5543cc0df80dd3b5b8041fd8d4de2d34df6::register::Register, arg3: &mut 0x2::tx_context::TxContext) {
        0x45690211f9818c3354ddc1434c35e5543cc0df80dd3b5b8041fd8d4de2d34df6::register::check_minter(arg2, arg3);
        0x45690211f9818c3354ddc1434c35e5543cc0df80dd3b5b8041fd8d4de2d34df6::register::check_frozen(arg2, arg3);
        arg0.description = 0x1::string::utf8(arg1);
    }

    public fun update_edition_number(arg0: &mut Token, arg1: u32, arg2: &mut 0x45690211f9818c3354ddc1434c35e5543cc0df80dd3b5b8041fd8d4de2d34df6::register::Register, arg3: &mut 0x2::tx_context::TxContext) {
        0x45690211f9818c3354ddc1434c35e5543cc0df80dd3b5b8041fd8d4de2d34df6::register::check_minter(arg2, arg3);
        0x45690211f9818c3354ddc1434c35e5543cc0df80dd3b5b8041fd8d4de2d34df6::register::check_frozen(arg2, arg3);
        arg0.edition_number = arg1;
    }

    public fun update_name(arg0: &mut Token, arg1: vector<u8>, arg2: &mut 0x45690211f9818c3354ddc1434c35e5543cc0df80dd3b5b8041fd8d4de2d34df6::register::Register, arg3: &mut 0x2::tx_context::TxContext) {
        0x45690211f9818c3354ddc1434c35e5543cc0df80dd3b5b8041fd8d4de2d34df6::register::check_minter(arg2, arg3);
        0x45690211f9818c3354ddc1434c35e5543cc0df80dd3b5b8041fd8d4de2d34df6::register::check_frozen(arg2, arg3);
        arg0.name = 0x1::string::utf8(arg1);
    }

    public fun update_preview_image(arg0: &mut Token, arg1: vector<u8>, arg2: &mut 0x45690211f9818c3354ddc1434c35e5543cc0df80dd3b5b8041fd8d4de2d34df6::register::Register, arg3: &mut 0x2::tx_context::TxContext) {
        0x45690211f9818c3354ddc1434c35e5543cc0df80dd3b5b8041fd8d4de2d34df6::register::check_minter(arg2, arg3);
        0x45690211f9818c3354ddc1434c35e5543cc0df80dd3b5b8041fd8d4de2d34df6::register::check_frozen(arg2, arg3);
        arg0.preview_image = 0x2::url::new_unsafe_from_bytes(arg1);
    }

    public fun uri(arg0: &Token) : 0x1::string::String {
        0x1::string::from_ascii(0x2::url::inner_url(&arg0.uri))
    }

    // decompiled from Move bytecode v6
}

