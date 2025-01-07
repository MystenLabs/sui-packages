module 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    struct SweetToken has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        preview_image: 0x2::url::Url,
        uri: 0x2::url::Url,
        project_url: 0x2::url::Url,
        edition_number: u32,
        moment: 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::moment::Moment,
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

    public fun moment(arg0: &SweetToken) : &0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::moment::Moment {
        &arg0.moment
    }

    fun get_display_kvp() : (vector<0x1::string::String>, vector<0x1::string::String>) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"edition_number"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{uri}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{preview_image}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{edition_number}"));
        (v0, v2)
    }

    public fun burn(arg0: SweetToken, arg1: &mut 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::Register, arg2: &mut 0x2::tx_context::TxContext) {
        0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::check_minter(arg1, arg2);
        burn_impl(arg0, arg2);
    }

    fun burn_impl(arg0: SweetToken, arg1: &0x2::tx_context::TxContext) {
        let SweetToken {
            id             : v0,
            name           : _,
            description    : _,
            preview_image  : _,
            uri            : v4,
            project_url    : _,
            edition_number : _,
            moment         : _,
        } = arg0;
        let v8 = TokenBurned{
            object_id : 0x2::object::id<SweetToken>(&arg0),
            token_uri : v4,
            burner    : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<TokenBurned>(v8);
        0x2::object::delete(v0);
    }

    public fun description(arg0: &SweetToken) : &0x1::string::String {
        &arg0.description
    }

    public fun edition_number(arg0: &SweetToken) : &u32 {
        &arg0.edition_number
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TOKEN>(arg0, arg1);
        let v1 = init_display(&v0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SweetToken>>(v1, 0x2::tx_context::sender(arg1));
    }

    fun init_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<SweetToken> {
        let (v0, v1) = get_display_kvp();
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::moment::get_display_kvp(b"moment");
        0x1::vector::append<0x1::string::String>(&mut v3, v4);
        0x1::vector::append<0x1::string::String>(&mut v2, v5);
        let v6 = 0x2::display::new_with_fields<SweetToken>(arg0, v3, v2, arg1);
        0x2::display::update_version<SweetToken>(&mut v6);
        v6
    }

    public fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u32, arg6: &0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::moment::Moment, arg7: &mut 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::Register, arg8: &mut 0x2::tx_context::TxContext) : SweetToken {
        0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::check_minter(arg7, arg8);
        0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::check_frozen(arg7, arg8);
        assert!(arg5 > 0, 1);
        mint_impl(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8)
    }

    fun mint_impl(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u32, arg6: &0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::moment::Moment, arg7: &mut 0x2::tx_context::TxContext) : SweetToken {
        let v0 = SweetToken{
            id             : 0x2::object::new(arg7),
            name           : 0x1::string::utf8(arg0),
            description    : 0x1::string::utf8(arg1),
            preview_image  : 0x2::url::new_unsafe_from_bytes(arg2),
            uri            : 0x2::url::new_unsafe_from_bytes(arg3),
            project_url    : 0x2::url::new_unsafe_from_bytes(arg4),
            edition_number : arg5,
            moment         : *arg6,
        };
        let v1 = TokenMinted{
            object_id : 0x2::object::id<SweetToken>(&v0),
            token_uri : v0.uri,
            creator   : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<TokenMinted>(v1);
        v0
    }

    public fun name(arg0: &SweetToken) : &0x1::string::String {
        &arg0.name
    }

    public fun preview_image(arg0: &SweetToken) : &0x2::url::Url {
        &arg0.preview_image
    }

    public fun project_url(arg0: &SweetToken) : &0x2::url::Url {
        &arg0.project_url
    }

    public fun update_description(arg0: &mut SweetToken, arg1: vector<u8>, arg2: &mut 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::Register, arg3: &mut 0x2::tx_context::TxContext) {
        0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::check_minter(arg2, arg3);
        0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::check_frozen(arg2, arg3);
        arg0.description = 0x1::string::utf8(arg1);
    }

    public fun update_edition_number(arg0: &mut SweetToken, arg1: u32, arg2: &mut 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::Register, arg3: &mut 0x2::tx_context::TxContext) {
        0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::check_minter(arg2, arg3);
        0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::check_frozen(arg2, arg3);
        arg0.edition_number = arg1;
    }

    public fun update_moment(arg0: &mut SweetToken, arg1: &0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::moment::Moment, arg2: &mut 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::Register, arg3: &mut 0x2::tx_context::TxContext) {
        0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::check_minter(arg2, arg3);
        0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::check_frozen(arg2, arg3);
        arg0.moment = *arg1;
    }

    public fun update_name(arg0: &mut SweetToken, arg1: vector<u8>, arg2: &mut 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::Register, arg3: &mut 0x2::tx_context::TxContext) {
        0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::check_minter(arg2, arg3);
        0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::check_frozen(arg2, arg3);
        arg0.name = 0x1::string::utf8(arg1);
    }

    public fun update_preview_image(arg0: &mut SweetToken, arg1: vector<u8>, arg2: &mut 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::Register, arg3: &mut 0x2::tx_context::TxContext) {
        0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::check_minter(arg2, arg3);
        0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::check_frozen(arg2, arg3);
        arg0.preview_image = 0x2::url::new_unsafe_from_bytes(arg1);
    }

    public fun update_project_url(arg0: &mut SweetToken, arg1: vector<u8>, arg2: &mut 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::Register, arg3: &mut 0x2::tx_context::TxContext) {
        0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::check_minter(arg2, arg3);
        0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::check_frozen(arg2, arg3);
        arg0.project_url = 0x2::url::new_unsafe_from_bytes(arg1);
    }

    public fun update_uri(arg0: &mut SweetToken, arg1: vector<u8>, arg2: &mut 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::Register, arg3: &mut 0x2::tx_context::TxContext) {
        0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::check_minter(arg2, arg3);
        0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::register::check_frozen(arg2, arg3);
        arg0.uri = 0x2::url::new_unsafe_from_bytes(arg1);
    }

    public fun uri(arg0: &SweetToken) : &0x2::url::Url {
        &arg0.uri
    }

    // decompiled from Move bytecode v6
}

