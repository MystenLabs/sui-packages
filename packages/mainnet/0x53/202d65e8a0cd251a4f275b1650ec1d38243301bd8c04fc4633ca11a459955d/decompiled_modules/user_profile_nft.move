module 0x53202d65e8a0cd251a4f275b1650ec1d38243301bd8c04fc4633ca11a459955d::user_profile_nft {
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
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<USER_PROFILE_NFT>(arg0, arg1), 0x2::tx_context::sender(arg1));
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

