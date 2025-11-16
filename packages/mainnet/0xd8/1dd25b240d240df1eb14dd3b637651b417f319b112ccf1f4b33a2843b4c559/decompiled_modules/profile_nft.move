module 0xd81dd25b240d240df1eb14dd3b637651b417f319b112ccf1f4b33a2843b4c559::profile_nft {
    struct UserProfileNFT has store, key {
        id: 0x2::object::UID,
        username: 0x1::string::String,
        avatar_url: 0x1::string::String,
        links_json: 0x1::string::String,
        theme: 0x1::string::String,
        shape: 0x1::string::String,
        accent: 0x1::string::String,
        created_at: u64,
        updated_at: u64,
    }

    public fun create(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) : UserProfileNFT {
        UserProfileNFT{
            id         : 0x2::object::new(arg6),
            username   : 0x1::string::utf8(arg0),
            avatar_url : 0x1::string::utf8(arg1),
            links_json : 0x1::string::utf8(arg2),
            theme      : 0x1::string::utf8(arg3),
            shape      : 0x1::string::utf8(arg4),
            accent     : 0x1::string::utf8(arg5),
            created_at : 0,
            updated_at : 0,
        }
    }

    public fun get_accent(arg0: &UserProfileNFT) : 0x1::string::String {
        arg0.accent
    }

    public fun get_avatar_url(arg0: &UserProfileNFT) : 0x1::string::String {
        arg0.avatar_url
    }

    public fun get_links_json(arg0: &UserProfileNFT) : 0x1::string::String {
        arg0.links_json
    }

    public fun get_shape(arg0: &UserProfileNFT) : 0x1::string::String {
        arg0.shape
    }

    public fun get_theme(arg0: &UserProfileNFT) : 0x1::string::String {
        arg0.theme
    }

    public fun get_username(arg0: &UserProfileNFT) : 0x1::string::String {
        arg0.username
    }

    public fun update(arg0: &mut UserProfileNFT, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        arg0.avatar_url = 0x1::string::utf8(arg1);
        arg0.links_json = 0x1::string::utf8(arg2);
        arg0.theme = 0x1::string::utf8(arg3);
        arg0.shape = 0x1::string::utf8(arg4);
        arg0.accent = 0x1::string::utf8(arg5);
        arg0.updated_at = 0;
    }

    // decompiled from Move bytecode v6
}

