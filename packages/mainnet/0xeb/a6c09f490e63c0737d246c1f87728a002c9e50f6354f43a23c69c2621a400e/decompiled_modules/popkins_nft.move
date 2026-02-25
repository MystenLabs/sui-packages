module 0xeba6c09f490e63c0737d246c1f87728a002c9e50f6354f43a23c69c2621a400e::popkins_nft {
    struct POPKINS_NFT has drop {
        dummy_field: bool,
    }

    struct Popkins has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        link: 0x1::string::String,
        image_url: 0x1::string::String,
        avatar_url: 0x1::string::String,
        avatar_thumb_url: 0x1::string::String,
        description: 0x1::string::String,
        project_url: 0x1::string::String,
        creator: 0x1::string::String,
        key: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct PopkinsMinted has copy, drop {
        popkins_id: 0x2::object::ID,
        key: 0x1::string::String,
    }

    struct PopkinsBurned has copy, drop {
        popkins_id: 0x2::object::ID,
        key: 0x1::string::String,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    public fun id(arg0: &Popkins) : 0x2::object::ID {
        0x2::object::id<Popkins>(arg0)
    }

    public fun attributes(arg0: &Popkins) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        arg0.attributes
    }

    public fun avatar_thumb_url(arg0: &Popkins) : 0x1::string::String {
        arg0.avatar_thumb_url
    }

    public fun avatar_url(arg0: &Popkins) : 0x1::string::String {
        arg0.avatar_url
    }

    public fun creator(arg0: &Popkins) : 0x1::string::String {
        arg0.creator
    }

    public fun description(arg0: &Popkins) : 0x1::string::String {
        arg0.description
    }

    public fun image_url(arg0: &Popkins) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: POPKINS_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MintCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<MintCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun key(arg0: &Popkins) : 0x1::string::String {
        arg0.key
    }

    public fun link(arg0: &Popkins) : 0x1::string::String {
        arg0.link
    }

    public fun mint(arg0: &MintCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg11: &mut 0x2::tx_context::TxContext) : Popkins {
        let v0 = Popkins{
            id               : 0x2::object::new(arg11),
            name             : arg1,
            link             : arg2,
            image_url        : arg3,
            avatar_url       : arg4,
            avatar_thumb_url : arg5,
            description      : arg6,
            project_url      : arg7,
            creator          : arg8,
            key              : arg9,
            attributes       : arg10,
        };
        let v1 = PopkinsMinted{
            popkins_id : 0x2::object::id<Popkins>(&v0),
            key        : v0.key,
        };
        0x2::event::emit<PopkinsMinted>(v1);
        v0
    }

    public fun mint_and_transfer(arg0: &MintCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Popkins>(mint(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg12), arg11);
    }

    public fun name(arg0: &Popkins) : 0x1::string::String {
        arg0.name
    }

    public fun project_url(arg0: &Popkins) : 0x1::string::String {
        arg0.project_url
    }

    // decompiled from Move bytecode v6
}

