module 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type {
    struct CollectionNft has store, key {
        id: 0x2::object::UID,
        hash: 0x1::string::String,
        image_url: 0x2::url::Url,
        title: 0x1::string::String,
        creator: address,
        index: u64,
        timestamp_ms: u64,
    }

    public(friend) fun burn(arg0: CollectionNft) {
        let CollectionNft {
            id           : v0,
            hash         : _,
            image_url    : _,
            title        : _,
            creator      : _,
            index        : _,
            timestamp_ms : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun create(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x1::string::String, arg4: 0x2::url::Url, arg5: 0x1::string::String, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : CollectionNft {
        assert!(valid_data(arg0, arg1, arg2), 0);
        let (v0, v1, v2, v3) = extract_data(arg0);
        assert!(v2 == arg3, 1);
        assert!(v1 == arg4, 1);
        assert!(v0 == arg5, 1);
        assert!(v3 == arg6, 1);
        CollectionNft{
            id           : 0x2::object::new(arg9),
            hash         : v2,
            image_url    : v1,
            title        : v0,
            creator      : arg6,
            index        : arg7,
            timestamp_ms : 0x2::clock::timestamp_ms(arg8),
        }
    }

    public fun creator(arg0: &CollectionNft) : address {
        arg0.creator
    }

    fun extract_data(arg0: vector<u8>) : (0x1::string::String, 0x2::url::Url, 0x1::string::String, address) {
        let v0 = 0x2::bcs::new(0x2::hex::decode(arg0));
        (0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)), 0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0)), 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)), 0x2::bcs::peel_address(&mut v0))
    }

    public fun hash(arg0: &CollectionNft) : 0x1::string::String {
        arg0.hash
    }

    public fun id(arg0: &CollectionNft) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun image_url(arg0: &CollectionNft) : 0x2::url::Url {
        arg0.image_url
    }

    public fun index(arg0: &CollectionNft) : u64 {
        arg0.index
    }

    public fun title(arg0: &CollectionNft) : 0x1::string::String {
        arg0.title
    }

    fun valid_data(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : bool {
        let v0 = 0x2::hex::decode(arg0);
        let v1 = 0x2::hex::decode(arg1);
        0x2::ed25519::ed25519_verify(&v1, &arg2, &v0)
    }

    // decompiled from Move bytecode v6
}

