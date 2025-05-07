module 0x97564204dcd4d34cadbdc87accf2e31620b4b3b3ed6c6a44bd75863bdb75475e::zeph {
    struct ZEPH has drop {
        dummy_field: bool,
    }

    struct Zeph has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        collectible: 0x2eb0fa3e7c7fb22acd44558f62155caeab51c1081e32064e9e299cb62888a086::static_collectible::StaticCollectible,
    }

    public fun new(arg0: &0x2c814fc2631b089760c7a6bef659dde62890709ecc58169e39bf5b60b0f2dbb7::collection_manager::CollectionManagerAdminCap, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut 0x2c814fc2631b089760c7a6bef659dde62890709ecc58169e39bf5b60b0f2dbb7::collection_manager::CollectionManager, arg9: &0x2c814fc2631b089760c7a6bef659dde62890709ecc58169e39bf5b60b0f2dbb7::collection_metadata::CollectionMetadata, arg10: &mut 0x2::tx_context::TxContext) : Zeph {
        0x2c814fc2631b089760c7a6bef659dde62890709ecc58169e39bf5b60b0f2dbb7::collection::assert_is_authorized(arg0, arg8, arg9);
        internal_new(arg0, arg1, 0x2c814fc2631b089760c7a6bef659dde62890709ecc58169e39bf5b60b0f2dbb7::collection_metadata::creator(arg9), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public fun creator(arg0: &Zeph) : address {
        0x2eb0fa3e7c7fb22acd44558f62155caeab51c1081e32064e9e299cb62888a086::static_collectible::creator(&arg0.collectible)
    }

    public fun animation_url(arg0: &Zeph) : 0x1::string::String {
        0x2eb0fa3e7c7fb22acd44558f62155caeab51c1081e32064e9e299cb62888a086::static_collectible::animation_url(&arg0.collectible)
    }

    public fun attributes(arg0: &Zeph) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        0x2eb0fa3e7c7fb22acd44558f62155caeab51c1081e32064e9e299cb62888a086::static_collectible::attributes(&arg0.collectible)
    }

    public fun description(arg0: &Zeph) : 0x1::string::String {
        0x2eb0fa3e7c7fb22acd44558f62155caeab51c1081e32064e9e299cb62888a086::static_collectible::description(&arg0.collectible)
    }

    public fun destroy(arg0: Zeph) {
        let Zeph {
            id            : v0,
            collection_id : _,
            collectible   : v2,
        } = arg0;
        0x2eb0fa3e7c7fb22acd44558f62155caeab51c1081e32064e9e299cb62888a086::static_collectible::destroy(v2);
        0x2::object::delete(v0);
    }

    public fun external_url(arg0: &Zeph) : 0x1::string::String {
        0x2eb0fa3e7c7fb22acd44558f62155caeab51c1081e32064e9e299cb62888a086::static_collectible::external_url(&arg0.collectible)
    }

    public fun image_uri(arg0: &Zeph) : 0x1::string::String {
        0x2eb0fa3e7c7fb22acd44558f62155caeab51c1081e32064e9e299cb62888a086::static_collectible::image_uri(&arg0.collectible)
    }

    public fun name(arg0: &Zeph) : 0x1::string::String {
        0x2eb0fa3e7c7fb22acd44558f62155caeab51c1081e32064e9e299cb62888a086::static_collectible::name(&arg0.collectible)
    }

    public fun number(arg0: &Zeph) : u64 {
        0x2eb0fa3e7c7fb22acd44558f62155caeab51c1081e32064e9e299cb62888a086::static_collectible::number(&arg0.collectible)
    }

    public fun reveal(arg0: &mut Zeph, arg1: &0x2c814fc2631b089760c7a6bef659dde62890709ecc58169e39bf5b60b0f2dbb7::collection_manager::CollectionManagerAdminCap, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &mut 0x2c814fc2631b089760c7a6bef659dde62890709ecc58169e39bf5b60b0f2dbb7::collection_manager::CollectionManager, arg5: &0x2c814fc2631b089760c7a6bef659dde62890709ecc58169e39bf5b60b0f2dbb7::collection_metadata::CollectionMetadata) {
        0x2c814fc2631b089760c7a6bef659dde62890709ecc58169e39bf5b60b0f2dbb7::collection::assert_is_authorized(arg1, arg4, arg5);
        internal_reveal(arg0, arg2, arg3, arg5);
    }

    public fun collection_id(arg0: &Zeph) : 0x2::object::ID {
        arg0.collection_id
    }

    fun init(arg0: ZEPH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ZEPH>(arg0, arg1);
        let (v1, v2, v3) = 0x2c814fc2631b089760c7a6bef659dde62890709ecc58169e39bf5b60b0f2dbb7::collection::new<Zeph>(&v0, 0x2::address::from_bytes(x"70819bb63379ff3853985d16436ff6cb7db7911bd381d635d0779043e358ed39"), 0x1::string::utf8(b"Zephyrians"), 0x1::string::utf8(x"5765e2809972652064726f7070696e67204e4654732074686174207061636b20612070756e63682c207469656420746f2061206b696c6c657220656e65726779206472696e6b2e20436f6d6520666f7220746865206172742c207374617920666f7220746865207574696c6974792e"), 0x1::string::utf8(b""), 0x1::string::utf8(b"ja1TuYFSj8TVvPydqliEGbM16eGssej2cAsdG9QcDxM"), 1881, arg1);
        0x2::transfer::public_transfer<0x2c814fc2631b089760c7a6bef659dde62890709ecc58169e39bf5b60b0f2dbb7::collection_manager::CollectionManagerAdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Zeph>>(0x2::display::new<Zeph>(&v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2c814fc2631b089760c7a6bef659dde62890709ecc58169e39bf5b60b0f2dbb7::collection_metadata::CollectionMetadata>(v1);
        0x2::transfer::public_share_object<0x2c814fc2631b089760c7a6bef659dde62890709ecc58169e39bf5b60b0f2dbb7::collection_manager::CollectionManager>(v2);
    }

    fun internal_new(arg0: &0x2c814fc2631b089760c7a6bef659dde62890709ecc58169e39bf5b60b0f2dbb7::collection_manager::CollectionManagerAdminCap, arg1: &0x2::package::Publisher, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &mut 0x2c814fc2631b089760c7a6bef659dde62890709ecc58169e39bf5b60b0f2dbb7::collection_manager::CollectionManager, arg10: &0x2c814fc2631b089760c7a6bef659dde62890709ecc58169e39bf5b60b0f2dbb7::collection_metadata::CollectionMetadata, arg11: &mut 0x2::tx_context::TxContext) : Zeph {
        0x2c814fc2631b089760c7a6bef659dde62890709ecc58169e39bf5b60b0f2dbb7::collection_manager::assert_blob_reserved(arg9, 0x373e6f64a5df1d8c93a027687ac3d11de39254b86f7a5c223f41104b4f0c3cee::blob_utils::blob_id_to_u256(arg6));
        let v0 = Zeph{
            id            : 0x2::object::new(arg11),
            collection_id : 0x2::object::id<0x2c814fc2631b089760c7a6bef659dde62890709ecc58169e39bf5b60b0f2dbb7::collection_metadata::CollectionMetadata>(arg10),
            collectible   : 0x2eb0fa3e7c7fb22acd44558f62155caeab51c1081e32064e9e299cb62888a086::static_collectible::new<Zeph>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8),
        };
        0x2c814fc2631b089760c7a6bef659dde62890709ecc58169e39bf5b60b0f2dbb7::collection_manager::register_item<Zeph>(arg9, arg0, 0x2eb0fa3e7c7fb22acd44558f62155caeab51c1081e32064e9e299cb62888a086::static_collectible::number(&v0.collectible), &v0);
        v0
    }

    fun internal_reveal(arg0: &mut Zeph, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: &0x2c814fc2631b089760c7a6bef659dde62890709ecc58169e39bf5b60b0f2dbb7::collection_metadata::CollectionMetadata) {
        assert!(arg0.collection_id == 0x2::object::id<0x2c814fc2631b089760c7a6bef659dde62890709ecc58169e39bf5b60b0f2dbb7::collection_metadata::CollectionMetadata>(arg3), 10008);
        0x2eb0fa3e7c7fb22acd44558f62155caeab51c1081e32064e9e299cb62888a086::static_collectible::reveal(&mut arg0.collectible, arg1, arg2);
    }

    public fun new_bulk(arg0: &0x2c814fc2631b089760c7a6bef659dde62890709ecc58169e39bf5b60b0f2dbb7::collection_manager::CollectionManagerAdminCap, arg1: &0x2::package::Publisher, arg2: u64, arg3: vector<0x1::string::String>, arg4: vector<u64>, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: vector<0x1::string::String>, arg8: vector<0x1::string::String>, arg9: &mut 0x2c814fc2631b089760c7a6bef659dde62890709ecc58169e39bf5b60b0f2dbb7::collection_manager::CollectionManager, arg10: &0x2c814fc2631b089760c7a6bef659dde62890709ecc58169e39bf5b60b0f2dbb7::collection_metadata::CollectionMetadata, arg11: &mut 0x2::tx_context::TxContext) : vector<Zeph> {
        0x2c814fc2631b089760c7a6bef659dde62890709ecc58169e39bf5b60b0f2dbb7::collection::assert_is_authorized(arg0, arg9, arg10);
        assert!(0x1::vector::length<0x1::string::String>(&arg3) == arg2, 10000);
        assert!(0x1::vector::length<u64>(&arg4) == arg2, 10001);
        assert!(0x1::vector::length<0x1::string::String>(&arg5) == arg2, 10002);
        assert!(0x1::vector::length<0x1::string::String>(&arg6) == arg2, 10003);
        assert!(0x1::vector::length<0x1::string::String>(&arg7) == arg2, 10004);
        assert!(0x1::vector::length<0x1::string::String>(&arg8) == arg2, 10005);
        let v0 = 0x1::vector::empty<Zeph>();
        let v1 = 0;
        while (v1 < arg2) {
            0x1::vector::push_back<Zeph>(&mut v0, internal_new(arg0, arg1, 0x2c814fc2631b089760c7a6bef659dde62890709ecc58169e39bf5b60b0f2dbb7::collection_metadata::creator(arg10), 0x1::vector::pop_back<0x1::string::String>(&mut arg3), 0x1::vector::pop_back<u64>(&mut arg4), 0x1::vector::pop_back<0x1::string::String>(&mut arg5), 0x1::vector::pop_back<0x1::string::String>(&mut arg6), 0x1::vector::pop_back<0x1::string::String>(&mut arg7), 0x1::vector::pop_back<0x1::string::String>(&mut arg8), arg9, arg10, arg11));
            v1 = v1 + 1;
        };
        v0
    }

    public fun receive<T0: store + key>(arg0: &mut Zeph, arg1: 0x2::transfer::Receiving<T0>) : T0 {
        0x2::transfer::public_receive<T0>(&mut arg0.id, arg1)
    }

    public fun reveal_bulk(arg0: &0x2c814fc2631b089760c7a6bef659dde62890709ecc58169e39bf5b60b0f2dbb7::collection_manager::CollectionManagerAdminCap, arg1: &mut vector<Zeph>, arg2: vector<vector<0x1::string::String>>, arg3: vector<vector<0x1::string::String>>, arg4: &mut 0x2c814fc2631b089760c7a6bef659dde62890709ecc58169e39bf5b60b0f2dbb7::collection_manager::CollectionManager, arg5: &0x2c814fc2631b089760c7a6bef659dde62890709ecc58169e39bf5b60b0f2dbb7::collection_metadata::CollectionMetadata) {
        0x2c814fc2631b089760c7a6bef659dde62890709ecc58169e39bf5b60b0f2dbb7::collection::assert_is_authorized(arg0, arg4, arg5);
        let v0 = 0x1::vector::length<Zeph>(arg1);
        assert!(0x1::vector::length<vector<0x1::string::String>>(&arg2) == v0, 10006);
        assert!(0x1::vector::length<vector<0x1::string::String>>(&arg3) == v0, 10007);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Zeph>(arg1)) {
            let v2 = 0x1::vector::borrow_mut<Zeph>(arg1, v1);
            internal_reveal(v2, 0x1::vector::pop_back<vector<0x1::string::String>>(&mut arg2), 0x1::vector::pop_back<vector<0x1::string::String>>(&mut arg3), arg5);
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

