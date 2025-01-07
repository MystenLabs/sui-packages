module 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::profile_pictures {
    struct ProfilePictures has key {
        id: 0x2::object::UID,
        hash_to_ipfs: 0x2::table::Table<vector<u8>, 0x1::string::String>,
    }

    public fun add(arg0: &mut ProfilePictures, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: vector<u8>, arg4: 0x1::string::String) {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_profile_pictures_role(arg1, arg2);
        0x2::table::add<vector<u8>, 0x1::string::String>(&mut arg0.hash_to_ipfs, arg3, arg4);
    }

    public fun contains(arg0: &ProfilePictures, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, 0x1::string::String>(&arg0.hash_to_ipfs, cosmetic_to_pfp_hash(arg1, arg2, arg3))
    }

    public fun remove(arg0: &mut ProfilePictures, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: vector<u8>) {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_profile_pictures_role(arg1, arg2);
        0x2::table::remove<vector<u8>, 0x1::string::String>(&mut arg0.hash_to_ipfs, arg3);
    }

    public fun cosmetic_to_pfp_hash(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : vector<u8> {
        let v0 = b"";
        let v1 = if (0x1::vector::is_empty<u8>(&arg0)) {
            b"empty"
        } else {
            arg0
        };
        0x1::vector::append<u8>(&mut v0, v1);
        let v2 = if (0x1::vector::is_empty<u8>(&arg1)) {
            b"empty"
        } else {
            arg1
        };
        0x1::vector::append<u8>(&mut v0, v2);
        let v3 = if (0x1::vector::is_empty<u8>(&arg2)) {
            b"empty"
        } else {
            arg2
        };
        0x1::vector::append<u8>(&mut v0, v3);
        0x2::hash::blake2b256(&v0)
    }

    public fun get(arg0: &ProfilePictures, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : 0x1::string::String {
        let v0 = cosmetic_to_pfp_hash(arg1, arg2, arg3);
        assert!(0x2::table::contains<vector<u8>, 0x1::string::String>(&arg0.hash_to_ipfs, v0), 0);
        *0x2::table::borrow<vector<u8>, 0x1::string::String>(&arg0.hash_to_ipfs, v0)
    }

    public fun hash_to_ipfs(arg0: &ProfilePictures) : &0x2::table::Table<vector<u8>, 0x1::string::String> {
        &arg0.hash_to_ipfs
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProfilePictures{
            id           : 0x2::object::new(arg0),
            hash_to_ipfs : 0x2::table::new<vector<u8>, 0x1::string::String>(arg0),
        };
        0x2::transfer::share_object<ProfilePictures>(v0);
    }

    // decompiled from Move bytecode v6
}

