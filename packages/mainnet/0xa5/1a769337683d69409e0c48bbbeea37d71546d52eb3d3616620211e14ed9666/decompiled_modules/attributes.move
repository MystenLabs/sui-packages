module 0xa51a769337683d69409e0c48bbbeea37d71546d52eb3d3616620211e14ed9666::attributes {
    struct NftData has store {
        number: 0x1::string::String,
        image_url: 0x1::string::String,
        keys: vector<0x1::string::String>,
        values: vector<0x1::string::String>,
    }

    struct CollectionData has key {
        id: 0x2::object::UID,
        nfts: 0x2::table_vec::TableVec<NftData>,
    }

    struct DataCap has store, key {
        id: 0x2::object::UID,
    }

    public fun add_attribute(arg0: &mut CollectionData, arg1: &DataCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>) {
        let v0 = &arg4;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x1::string::String>(v0)) {
            if (!!0x1::string::is_empty(0x1::vector::borrow<0x1::string::String>(v0, v1))) {
                v2 = false;
                /* label 6 */
                assert!(v2, 9223372212948434943);
                let v3 = &arg5;
                let v4 = 0;
                let v5;
                while (v4 < 0x1::vector::length<0x1::string::String>(v3)) {
                    if (!!0x1::string::is_empty(0x1::vector::borrow<0x1::string::String>(v3, v4))) {
                        v5 = false;
                        /* label 15 */
                        assert!(v5, 9223372217243402239);
                        let v6 = NftData{
                            number    : arg2,
                            image_url : arg3,
                            keys      : arg4,
                            values    : arg5,
                        };
                        0x2::table_vec::push_back<NftData>(&mut arg0.nfts, v6);
                        return
                    };
                    v4 = v4 + 1;
                };
                v5 = true;
                /* goto 15 */
            } else {
                v1 = v1 + 1;
            };
        };
        v2 = true;
        /* goto 6 */
    }

    public fun destroy_data(arg0: CollectionData, arg1: DataCap) {
        let CollectionData {
            id   : v0,
            nfts : v1,
        } = arg0;
        let v2 = v1;
        assert!(0x2::table_vec::is_empty<NftData>(&v2), 9223372281667911679);
        0x2::table_vec::destroy_empty<NftData>(v2);
        0x2::object::delete(v0);
        let DataCap { id: v3 } = arg1;
        0x2::object::delete(v3);
    }

    public(friend) fun get_nft(arg0: &mut CollectionData, arg1: u64) : (0x1::string::String, 0x1::string::String, vector<0x1::string::String>, vector<0x1::string::String>) {
        let v0 = if (0x2::table_vec::length<NftData>(&arg0.nfts) == 1) {
            0x2::table_vec::pop_back<NftData>(&mut arg0.nfts)
        } else {
            0x2::table_vec::swap_remove<NftData>(&mut arg0.nfts, arg1)
        };
        let NftData {
            number    : v1,
            image_url : v2,
            keys      : v3,
            values    : v4,
        } = v0;
        (v1, v2, v3, v4)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CollectionData{
            id   : 0x2::object::new(arg0),
            nfts : 0x2::table_vec::empty<NftData>(arg0),
        };
        0x2::transfer::share_object<CollectionData>(v0);
        let v1 = DataCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<DataCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun nfts_left(arg0: &CollectionData) : u64 {
        0x2::table_vec::length<NftData>(&arg0.nfts)
    }

    // decompiled from Move bytecode v6
}

