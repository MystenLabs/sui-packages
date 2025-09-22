module 0xc423623508c656db785ea99a2f714a2f6955806d2d368f65ed5831f67bcc0044::user_profile_nft {
    struct USER_PROFILE_NFT has drop {
        dummy_field: bool,
    }

    struct UserProfileNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        pfp: 0x1::string::String,
        bio: 0x1::string::String,
        links: vector<0x1::string::String>,
    }

    public fun add_link(arg0: &mut UserProfileNFT, arg1: 0x1::string::String) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.links, arg1);
    }

    public fun id(arg0: &UserProfileNFT) : &0x2::object::UID {
        &arg0.id
    }

    fun init(arg0: USER_PROFILE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<USER_PROFILE_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Profile: {name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{bio}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://sambasocialticket.com/b/{id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{pfp}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{pfp}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://sambasocialticket.com/"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Samba Social Ticket Network"));
        let v5 = 0x2::display::new_with_fields<UserProfileNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<UserProfileNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<UserProfileNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) : UserProfileNFT {
        UserProfileNFT{
            id    : 0x2::object::new(arg4),
            name  : arg0,
            pfp   : arg1,
            bio   : arg2,
            links : arg3,
        }
    }

    public fun remove_link(arg0: &mut UserProfileNFT, arg1: u64) {
        0x1::vector::remove<0x1::string::String>(&mut arg0.links, arg1);
    }

    public fun update_bio(arg0: &mut UserProfileNFT, arg1: 0x1::string::String) {
        arg0.bio = arg1;
    }

    public fun update_name(arg0: &mut UserProfileNFT, arg1: 0x1::string::String) {
        arg0.name = arg1;
    }

    public fun update_pfp(arg0: &mut UserProfileNFT, arg1: 0x1::string::String) {
        arg0.pfp = arg1;
    }

    // decompiled from Move bytecode v6
}

