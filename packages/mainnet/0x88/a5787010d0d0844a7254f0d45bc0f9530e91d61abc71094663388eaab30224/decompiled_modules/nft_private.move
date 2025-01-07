module 0x88a5787010d0d0844a7254f0d45bc0f9530e91d61abc71094663388eaab30224::nft_private {
    struct PriNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        link: 0x2::url::Url,
        image_url: 0x2::url::Url,
        description: 0x1::string::String,
        project_url: 0x2::url::Url,
        edition: u64,
        thumbnail_url: 0x2::url::Url,
        creator: 0x1::string::String,
        attributes: 0x2::table::Table<vector<u8>, vector<u8>>,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        project_url: 0x2::url::Url,
    }

    public(friend) fun burn(arg0: PriNFT) {
        let PriNFT {
            id            : v0,
            name          : _,
            link          : _,
            image_url     : _,
            description   : _,
            project_url   : _,
            edition       : _,
            thumbnail_url : _,
            creator       : _,
            attributes    : v9,
        } = arg0;
        0x2::table::drop<vector<u8>, vector<u8>>(v9);
        0x2::object::delete(v0);
    }

    public fun creator(arg0: &PriNFT) : &0x1::string::String {
        &arg0.creator
    }

    public fun description(arg0: &PriNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &PriNFT) : &0x2::url::Url {
        &arg0.image_url
    }

    public(friend) fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: 0x2::table::Table<vector<u8>, vector<u8>>, arg9: &mut 0x2::tx_context::TxContext) : PriNFT {
        PriNFT{
            id            : 0x2::object::new(arg9),
            name          : 0x1::string::utf8(arg0),
            link          : 0x2::url::new_unsafe_from_bytes(arg1),
            image_url     : 0x2::url::new_unsafe_from_bytes(arg2),
            description   : 0x1::string::utf8(arg3),
            project_url   : 0x2::url::new_unsafe_from_bytes(arg4),
            edition       : arg5,
            thumbnail_url : 0x2::url::new_unsafe_from_bytes(arg6),
            creator       : 0x1::string::utf8(arg7),
            attributes    : arg8,
        }
    }

    public(friend) fun mint_batch(arg0: u64, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x2::vec_map::VecMap<vector<u8>, vector<u8>>, arg10: &mut 0x2::tx_context::TxContext) : vector<PriNFT> {
        assert!(arg0 > 0, 1);
        let v0 = 0x1::vector::empty<PriNFT>();
        while (arg0 > 0) {
            let v1 = vec2map<vector<u8>, vector<u8>>(arg9, arg10);
            0x1::vector::push_back<PriNFT>(&mut v0, mint(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, v1, arg10));
            arg0 = arg0 - 1;
        };
        v0
    }

    public fun name(arg0: &PriNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun project_url(arg0: &PriNFT) : &0x2::url::Url {
        &arg0.project_url
    }

    public(friend) fun update_description(arg0: &mut PriNFT, arg1: vector<u8>) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    fun vec2map<T0: copy + drop + store, T1: copy + store>(arg0: &0x2::vec_map::VecMap<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::table::Table<T0, T1> {
        let v0 = 0x2::vec_map::keys<T0, T1>(arg0);
        let v1 = 0x1::vector::length<T0>(&v0);
        let v2 = 0x2::table::new<T0, T1>(arg1);
        while (v1 > 0) {
            v1 = v1 - 1;
            let v3 = 0x1::vector::pop_back<T0>(&mut v0);
            0x2::table::add<T0, T1>(&mut v2, v3, *0x2::vec_map::get<T0, T1>(arg0, &v3));
        };
        v2
    }

    // decompiled from Move bytecode v6
}

